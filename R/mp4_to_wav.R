#' Convert .mp to Audio (.wav)
#' 
#' Converts a .mp4 video to a .wav file for use with \pkg{seewave} and 
#' \pkg{tuneR}.
#' 
#' @param path Path to the in .mp4 video file.
#' @param out Path to place the out .wav file.
#' @param ffmpeg Raw \href{http://www.ffmpeg.org/}{mmpeg} code that may be 
#' provided in lieu of the other arguments.
#' @return Returns a .wav file.
#' @note User must have \href{http://www.ffmpeg.org/}{mmpeg} installed.
#' @references \url{http://www.ffmpeg.org/}
#' @export
#' @examples
#' \dontrun{
#' mp4_to_wav("foo.mp4", "foo.wav")
#' }
mp4_to_wav<- function(path, out = "out.wav", ffmpeg = NULL) {

    ## Detect OS and use shell on Windows or system else
    fun <- ifelse(Sys.info()["sysname"] == "Windows", "shell", "system")
    fun <- match.fun(fun)

    if (missing(path) & is.null(ffmpeg)) {
        stop("Please supply `path` or `ffmpeg`")
    }

	## Check if ffmpeg is available
    version <- try(fun("ffmpeg -version", intern = TRUE))
    if (inherits(version, 'try-error')) {
        warning("The command `ffmpeg`", 
           " is not available in your system. Please install ffmpeg first:\n",
           "http://www.ffmpeg.org/download.html")
        return()
    }
		
    if (file.exists(out)) {
        message(paste0("\"", out, 
            "\" already exists:\nDo you want to overwrite?\n"))
        ans <- menu(c("Yes", "No"))
        if (ans == "2") {
            stop("mp4_to_wav aborted")
        }
        else {
            delete(out)
        }
    }
	

    if (is.null(ffmpeg)) {
    	ffmpeg <- sprintf("ffmpeg -i %s %s", shQuote(path), shQuote(out))
    }
    fun(ffmpeg)
    message(sprintf(".wav file at:\n%s", out))
    invisible(out)	
}
