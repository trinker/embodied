#' Directory .png Files
#' 
#' Given a directory, \code{dir_png} will determine the files (with optional 
#' full path; see \code{full} argument) that are .png files.
#' 
#' @param path Path to the directory where the .png files are to be located.
#' @param full logical.  If \code{TRUE} then the entire path to each .pg image 
#' is given.  
#' @return Returns a character vector with image names that are .png files.
#' @export
#' @importFrom tools file_ext
#' @seealso \code{\link[tools]{file_ext}}
#' @examples
#' dir.create("DELETE_ME")
#' png("DELETE_ME/test1.png"); plot(1:10); dev.off()
#' png("DELETE_ME/test2.png"); plot(1:10); dev.off()
#' pdf("DELETE_ME/test3.pdf"); plot(1:10); dev.off()
#' dir_png("DELETE_ME")
#' unlink("DELETE_ME", recursive = TRUE, force = FALSE)
dir_png <- function(path, full = FALSE) {
    
    fls <- dir(path)
    out <- fls[file_ext(fls) == "png"]
    if (full) {
        out <- file.path(path, out)
    }
    out
}
