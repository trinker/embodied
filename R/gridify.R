#' Add Grids to Multiple png
#' 
#' A wrapper function for \code{grid_calc} and \code{plot_grid} used to read in 
#' a directory of png files.  Add grid lines.  Output to directory.
#' 
#' @param path Path to the in directory with the .png files or a single .mp4 
#' file.
#' @param out Path to the out directory.
#' @param pdf logical.  If \code{TRUE} a single .pdf (\file{./raw/gridified.png})
#' is generated.  This enables zooming and a single scrollable file.
#' @param columns The number of grid columns.
#' @param rows The number of grid rows.
#' @param parallel logical.  If \code{TRUE} attempts to run the function on 
#' multiple cores.  Note that this may not mean a speed boost if you have one 
#' core or if the data set is smaller as the cluster takes time to create.  
#' For a visual representation of the use of parallel processing see:
#' \url{https://raw.github.com/trinker/embodied/master/inst/gridify_parallel_test/output.png}
#' @param cores The number of cores to use if \code{parallel = TRUE}.  Default 
#' is half the number of available cores.
#' @param width The width of the device.
#' @param height The height of the device.
#' @param text.color The color to make the coordinate labels.
#' @param text.size The size of the coordinate labels.
#' @param grid.color The color to make the grid.
#' @param fps The number of image frames per second to output.  Generally the 
#' fps used to desconstruct a video into images will be used to reconstruct the 
#' images back to video.
#' @param size Character string of the output size of the png files in the form 
#' of "width x height" (in px and no spaces).
#' @param other.opts other options to be passed to 
#' \href{http://www.ffmpeg.org/}{ffmpeg}.
#' @param crop Character string of \href{http://www.ffmpeg.org/}{ffmpeg} code 
#' used to crop the images (e.g. \code{"-vf crop=in_w-2*120"}).  See: 
#' \url{http://www.ffmpeg.org/ffmpeg-filters.html#crop} for more.
#' @param \ldots other arguments passed to \code{\link[grDevices]{png}}.
#' @return Returns multiple png files with grid lines.
#' @export
#' @importFrom parallel parLapply makeCluster detectCores stopCluster clusterEvalQ clusterExport
#' @importFrom tools file_ext
#' @importFrom ggplot2 ggtitle
#' @seealso \code{\link[embodied]{plot_grid}}
#' \code{\link[embodied]{mp4_to_png}}
#' @examples
#' deb <- system.file("extdata", package = "embodied")
#' gridify(deb, "out")
gridify <- function(path = ".", out = file.path(path, "out"), pdf = TRUE,
    columns = 20, rows = columns, parallel = TRUE, cores = detectCores()/2,
    width = 6, height = 6, text.color = "gray60", text.size = 3, 
    grid.color = text.color, fps = 4, size = "500x500", other.opts = "", 
    crop = "", ...){
	
	## Evaluate out because path may change and defualt uses path
    if(basename(path) == path && file_ext(path) =="mp4" && 
    		dirname(out) == basename(path)) {
        out <- file.path(getwd(), "raw", basename(out))
    }
	
	## If path is mp4 generate png files
	if(file_ext(path) == "mp4") {
        mp4_to_png(path, file.path(dirname(path), "raw"), fps = fps, 
        	size = size, other.opts = other.opts, crop = crop)
		path <- file.path(dirname(path), "raw")
	}
	
    if (file.exists(file.path(path, "out"))) {
        message(paste0("\"", file.path(path, "out"), 
            "\" already exists:\nDo you want to overwrite?\n"))
        ans <- menu(c("Yes", "No"))
        if (ans == "2") {
            stop("gridify aborted")
        }
        else {
            delete(file.path(path, "out"))
        }
    }
    folder(folder.name = out)

    fls <- dir(path)
    fls <-file.path(path, fls)[file_ext(fls) == "png"]
    dat <- grid_calc(columns, rows)

    ## pdf vs png output
    if(pdf) {
        ## Parallel process handling
        if (parallel && cores > 1){
            
            cl <- makeCluster(mc <- getOption("cl.cores", detectCores()/2))
            vars <- c("fls", "dat", "text.color", "grid.color", "ggtitle",
                "plot_grid", "text.size")
            
            clusterExport(cl=cl, varlist=vars, envir = environment())
            
            imgs <- parLapply(cl, fls, function(x){
                plot_grid(x, grid.data = dat, text.color = text.color, 
                    text.size = text.size, grid.color = grid.color)+ 
                    ggtitle(basename(x))
            })
            
            stopCluster(cl)
            pdf(file.path(out, "gridified.pdf"), width=width, height=height, ...)
            invisible(print(imgs))
            dev.off()
        } else { 
            pdf(file.path(out, "gridified.pdf"), width=width, height=height, ...)
            invisible(lapply(fls, function(x){
                print(plot_grid(x, grid.data = dat, text.color = text.color, 
                	text.size = text.size, grid.color = grid.color) + 
                  ggtitle(basename(x)))
            }))
            dev.off()
        }
    } else {
        ## Parallel process handling
        if (parallel && cores > 1){
            plot_fun <- function(x) png(x, width=width, height=height, ...)
            
            cl <- makeCluster(mc <- getOption("cl.cores", detectCores()/2))
            vars <- c("fls", "plot_grid", "dat", "text.color", "grid.color", "plot_fun", "text.size")
            
            clusterExport(cl=cl, varlist=vars, envir = environment())
            
            parLapply(cl, fls, function(x){
                plot_fun(file.path(out, basename(x)))
                print(plot_grid(x, grid.data = dat, text.color = text.color, 
                    text.size = text.size, grid.color = grid.color))
                dev.off()
            })
            
            stopCluster(cl)
        } else { 
            invisible(lapply(fls, function(x){
                png(file.path(out, basename(x)), width=width, height=height, ...)
                print(plot_grid(x, grid.data = dat, text.color = text.color, 
                	text.size = text.size, grid.color = grid.color))
                dev.off()
            }))
        }
    }
    message(sprintf("Grid files plotted to:\n%s", out))
    invisible(out)	
}
