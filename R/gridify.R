#' Add Grids to Multiple png
#' 
#' A wrapper function for \code{grid_calc} and \code{plot_grid} used to read in 
#' a directory of png files.  Add grid lines.  Output to directory.
#' 
#' @param path Path to the in directory with the png files.
#' @param out Path to the out directory.
#' @param columns The number of grid columns.
#' @param rows The number of grid rows.
#' @param parallel logical.  If \code{TRUE} attempts to run the function on 
#' multiple cores.  Note that this may not mean a speed boost if you have one 
#' core or if the data set is smaller as the cluster takes time to create.
#' @param cores The number of cores to use if \code{parallel = TRUE}.  Default 
#' is half the number of available cores.
#' @param width The width of the device.
#' @param height The height of the device.
#' @param text.color The color to make the coordinate labels.
#' @param text.size The size of the coordinate labels.
#' @param grid.color The color to make the grid.
#' @param \ldots other arguments passed to \code{\link[grDevices]{png}}.
#' @return Returns multiple png files with grid lines.
#' @export
#' @importFrom parallel parLapply makeCluster detectCores stopCluster clusterEvalQ clusterExport
#' @importFrom tools file_ext
#' @seealso \code{\link[embodied]{plot_grid}}
#' @examples
#' deb <- system.file("extdata", package = "embodied")
#' gridify(deb, "out")
gridify <- function(path = ".", out = file.path(path, "out"), 
    columns = 20, rows = columns, parallel = FALSE, cores = detectCores()/2,
    width = 480, height = 480, text.color = "gray60", text.size = 3, 
	grid.color = text.color, ...){
	
## detect mp4 file extension and use mp4_to_png to generate pngs w/ grids
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
## Add Lapply handling
        invisible(lapply(fls, function(x){
            png(file.path(out, basename(x)), width=width, height=height, ...)
            print(plot_grid(x, grid.data = dat, text.color = text.color, 
            	text.size = text.size, grid.color = grid.color))
            dev.off()
        }))

    message(sprintf("Grid files plotted to:\n%s", out))
}
