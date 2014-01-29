#' Add Grids to Multiple png
#' 
#' \code{gridify} - A wrapper function for \code{grid_calc} and \code{plot_grid} 
#' used to read in a directory of png files.  Add grid lines.  Output to 
#' directory.
#' 
#' @param path Path to the in directory with the .png files or a single .mp4 
#' file.
#' @param out Path to the out directory.
#' @param pdf logical.  If \code{TRUE} a single .pdf (\file{./raw/gridified.png})
#' is generated.  This enables zooming and a single scrollable file.  
#' \href{http://www.ghostscript.com/}{ghostscript} must be installed and on your 
#' path.
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
#' @param grid.size The thickness of the grid lines.
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
#' @param code.sheet A path to the embodied .csv coding sheet.
#' @param duration An aptional duration of the original video, in seconds, if 
#' .png files are passed to \code{path}.  This is used for \code{code.sheet}.  
#' Note that \code{fps} should also be set.
#' @param people The people whose coordinates will be logged.
#' @param clean logical.  If \code{TRUE} and \code{pdf = TRUE} the directory 
#' with sequence of images will be removed after 
#' \href{http://www.ghostscript.com/}{Gohstscript} integration.
#' @param \ldots other arguments passed to \code{\link[grDevices]{png}}.
#' @return Returns multiple files with grid lines.
#' @export
#' @note Note that in order to properly view the time format column in the 
#' \code{code.sheet}, the user may need to adjust the .csv display settings when 
#' the .csv is opened.  Within some spreadsheet programs, changing the 
#' \strong{format} to a \strong{custom} of \code{hh:mm:ss.00} enables proper 
#' viewing.
#' @section Considerations: Larger mp4 files may cause errors or unexpected 
#' hangups due to extended processig time and large file sizes.  The user may 
#' want to consider breaking the job into smaller subcomponents and using 
#' elementary, non-wrapper functions including \code{gridify_pdf}).  See the 
#' \code{Example} section for an example workflow utilizing this approach.
#' @rdname gridify
#' @importFrom parallel parLapply makeCluster detectCores stopCluster clusterEvalQ clusterExport
#' @importFrom tools file_ext file_path_sans_ext
#' @importFrom ggplot2 ggtitle
#' @seealso \code{\link[embodied]{plot_grid}},
#' \code{\link[embodied]{mp4_to_png}}
#' @examples
#' \dontrun{
#' deb <- system.file("extdata", package = "embodied")
#' gridify(deb, "out")
#' 
#' #=============================#
#' # AN APPROACH FOR LARGER JOBS #
#' #=============================#
#' 
#' ## Create png files from .mp4
#' loc <- "foo.mp4"
#' fps <- 4
#' x <- mp4_to_png(loc, fps = fps)
#' 
#' ## Generate fridied pdfs from
#' y <- folder(folder.name=file.path(x, "out"))
#' imgs <- dir(x)[grep("image-", dir(x))]
#' bins <- binify(file.path(x, imgs))
#' pdfs <- file.path(y, "pdfs")
#' lapply(bins, gridify_pdf, out=pdfs)
#' 
#' ## Merge PDFs, compact PDF, clean up
#' z <- merge_pdf(file.path(pdfs, dir(pdfs)), file.path(y, "gridify.pdf"))
#' library(tools)
#' compactPDF(z)
#' delete(pdfs)
#' 
#' ## Code sheet
#' write_embodied(
#'     id = file_path_sans_ext(imgs), 
#'     time = mp4_to_times(loc, fps = fps)[seq_along(imgs)], 
#'     file = file.path(y, "coding.csv")
#' )
#' }
gridify <- function(path = ".", out = file.path(path, "out"), pdf = TRUE,
    columns = 30, rows = columns, parallel = TRUE, cores = detectCores()/2,
    width = 6, height = 6, text.color = "gray60", text.size = 2, 
    grid.size = .25, grid.color = text.color, fps = 4, size = "500x500", 
    other.opts = "", crop = "", code.sheet = file.path(out, "embodied.csv"), 
    duration = NULL, people = paste("person", 1:3, sep = "_"), clean = FALSE, 
	...){
	
    ## Evaluate out because path may change and defualt uses path
    if(basename(path) == path && file_ext(path) =="mp4" && 
        dirname(out) == basename(path)) {

        out <- file.path(getwd(), "raw", basename(out))

    }

    path2 <- NULL
	
    ## If path is mp4 generate png files
    if(file_ext(path) == "mp4") {
        path2 <- path
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
    imgnms <- file_path_sans_ext(basename(fls))
    fls <-file.path(path, fls)[file_ext(fls) == "png"]
    dat <- grid_calc(columns, rows)

    ## pdf vs png output
    if(pdf) {
        folder(folder.name = file.path(out, "pdfs"))
        ## Parallel process handling
        if (parallel && cores > 1){
            plot_fun <- function(x) pdf(x, width=width, height=height, ...) 
           
            cl <- makeCluster(mc <- getOption("cl.cores", detectCores()/2))
            vars <- c("fls", "dat", "text.color", "grid.color", "ggtitle",
                "file_path_sans_ext", "plot_grid", "text.size", "plot_fun")
            
            clusterExport(cl=cl, varlist=vars, envir = environment())
            
            parLapply(cl, fls, function(x){
                plot_fun(file.path(out, "pdfs", gsub("\\.png", "\\.pdf", basename(x))))
                print(plot_grid(x, grid.data = dat, text.color = text.color, 
                    text.size = text.size, grid.color = grid.color, 
                    grid.size = grid.size)+ 
                    ggtitle(file_path_sans_ext(basename(x))))
                dev.off()
            })

        } else { 

            invisible(lapply(fls, function(x){
                pdf(file.path(out, "pdfs", gsub("\\.png", "\\.pdf", basename(x))))
                print(plot_grid(x, grid.data = dat, text.color = text.color, 
                	  text.size = text.size, grid.color = grid.color, 
                    grid.size = grid.size) + 
                    ggtitle(basename(x)))
                dev.off()
            }))
        }
        fls <- file.path(out, "pdfs", dir(file.path(out, "pdfs")))
        mergePDF(in.file=fls, file = file.path(out, "gridified.pdf"))
        if (clean) {
            delete(file.path(out, "pdfs"))
        }
    } else {

        ## Parallel process handling
        if (parallel && cores > 1){
            plot_fun <- function(x) png(x, width=width, height=height, ...)
            
            cl <- makeCluster(mc <- getOption("cl.cores", detectCores()/2))
            vars <- c("fls", "plot_grid", "dat", "text.color", "grid.color", 
                "plot_fun", "file_path_sans_ext", "text.size")
            
            clusterExport(cl=cl, varlist=vars, envir = environment())
            
            parLapply(cl, fls, function(x){
                plot_fun(file.path(out, basename(x)))
                print(plot_grid(x, grid.data = dat, text.color = text.color, 
                    text.size = text.size, grid.color = grid.color, 
                    grid.size = grid.size))
                dev.off()
            })
            
            stopCluster(cl)
        } else { 
            invisible(lapply(fls, function(x){
                png(file.path(out, basename(x)), width=width, height=height, ...)
                print(plot_grid(x, grid.data = dat, text.color = text.color, 
                	text.size = text.size, grid.color = grid.color, 
                  grid.size = grid.size))
                dev.off()
            }))
        }
    }

    if (!is.null(code.sheet)) {

        if (is.null(path2) & is.null(duration)) {

            times <- rep(NA, length(imgnms))
   
        } else {
            if (is.null(path2) & !is.null(duration)) {
                tot <- duration 
            } else {
                tot <- mp4_duration(path2)
            }
            part <- tot - floor(tot) 
            vals <- seq(0, 1, by = 1/fps) 
            difs <- vals - part
            minval <- vals[difs >= 0][1]
            maxtime <- ceiling(tot) + minval
            times <- sec_to_hms(seq(0, maxtime, by = 1/fps))

        }
        imgnms <- imgnms[grep("image-", imgnms)]
        write_embodied(id = imgnms, time = times[1:length(imgnms)], 
            people = people, file = code.sheet)
    }

    message(sprintf("Grid files plotted to:\n%s", out))
    invisible(out)	
}


#' Add Grids to Multiple png
#' 
#' \code{gridify_pdf} - A lighter weight version of \code{gridify} intended to
#' be used as a part of the workflow for for larger jobs (though restricted to 
#' PDF file output).  
#' 
#' @param pngs A vector of paths to multiple png files. 
#' @export
#' @rdname gridify
gridify_pdf <- function (pngs, out = "out/pdf", 
    columns = 30, rows = columns, parallel = TRUE, cores = detectCores()/2, 
    width = 6, height = 6, text.color = "gray60", text.size = 2, 
    grid.size = 0.25, grid.color = text.color, fps = 4, ...) {

    if (!file.exists(out)) {
        folder(folder.name = out)
    }

    imgnms <- file_path_sans_ext(basename(pngs))

    dat <- grid_calc(columns, rows)

    if (parallel && cores > 1) {
        plot_fun <- function(x) pdf(x, width = width, height = height, 
            ...)
        cl <- makeCluster(mc <- getOption("cl.cores", detectCores()/2))
        vars <- c("pngs", "dat", "text.color", "grid.color", 
            "ggtitle", "file_path_sans_ext", "plot_grid", 
            "text.size", "plot_fun")
        clusterExport(cl = cl, varlist = vars, envir = environment())
        parLapply(cl, pngs, function(x) {
            plot_fun(file.path(out, gsub("\\.png", 
              "\\.pdf", basename(x))))
            print(plot_grid(x, grid.data = dat, text.color = text.color, 
              text.size = text.size, grid.color = grid.color, 
              grid.size = grid.size) + ggtitle(file_path_sans_ext(basename(x))))
            dev.off()
        })
    } else {
        invisible(lapply(pngs, function(x) {
            pdf(file.path(out, gsub("\\.png", "\\.pdf", 
              basename(x))))
            print(plot_grid(x, grid.data = dat, text.color = text.color, 
              text.size = text.size, grid.color = grid.color, 
              grid.size = grid.size) + ggtitle(basename(x)))
            dev.off()
        }))
    }

    message(sprintf("Grid files plotted to:\n%s", out))
    invisible(out)
}