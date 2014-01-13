#' Convert Video to Images
#' 
#' Convert an .mp4 video to .png images.
#' 
#' @param path Path to the in .mp4 file.
#' @param out Path to place the out .png files.
#' @param frames per second The number of image frames per second to output.
#' @param ffmpeg Raw \href{http://www.ffmpeg.org/}{mmpeg} code that may be 
#' provided in lieu of the other arguments.
#' @return Returns an interval .mp4.
#' @note User must have \href{http://www.ffmpeg.org/}{mmpeg} installed.
#' @references \url{http://www.ffmpeg.org/}
#' @export
#' @examples
#' \dontrun{
#' mp4_to_png("spliced.mp4")
#' }
mp4_to_png <- function(path, out = file.path(dirname(path), "raw"), 
    images.per.sec = 1, ffmpeg = NULL) {

    ## Detect OS and use shell on Windows or system else
    fun <- ifelse(Sys.info()["sysname"] == "Windows", "shell", "system")
    fun <- match.fun(fun)
	
	if (missing(path) & is.null(ffmpeg)) {
		stop("Please supply `path` or `ffmpeg`")
	}

    if (file.exists(out)) {
        message(paste0("\"", out, 
            "\" already exists:\nDo you want to overwrite?\n"))
        ans <- menu(c("Yes", "No"))
        if (ans == "2") {
            stop("mp4_to_raw aborted")
        }
        else {
            delete(out)
        }
    }
    folder(folder.name=out)
		
    if (is.null(ffmpeg)) {
        ffmpeg <- sprintf("ffmpeg -i %s -f image2 -vf fps=fps=%s %s", path, fps, out)
    	ffmpeg <- paste0(ffmpeg, "/image-%07d.png")
    }
    fun(ffmpeg)
    message(sprintf(".png images in:\n%s", out))
}

