#' Video Duration
#' 
#' Reports the length of a video in seconds.
#' 
#' @param path Path to the in .mp4 file.
#' @return A numeric value giving length of video in seconds.
#' @keywords duration
#' @export
#' @examples
#' \dontrun{
#' mp4_duration("foo.mp4")
#' }
mp4_duration <- function(path) {

	## check if path exists
    if (!file.exists(path)) stop(path, " does not exist")
	
    ## Detect OS and use shell on Windows or system else
    fun <- ifelse(Sys.info()["sysname"] == "Windows", "shell", "system")
    fun <- match.fun(fun)

    ## Check if ffmpeg is available
    version <- try(fun("ffmpeg -version", intern = TRUE))
    if (inherits(version, 'try-error')) {
        warning("The command `ffmpeg`", 
           " is not available in your system. Please install ffmpeg first:\n",
           "http://www.ffmpeg.org/download.html")
        return()
    }

    y <- tempdir()
    dur <- file.path(y, "out.txt")
    suppressWarnings(fun(sprintf("ffmpeg -i %s > %s 2>&1", shQuote(path), 
    	shQuote(dur))))
    durin <- readLines(dur)
    delete(dur)
    durline <- durin[grepl("Duration", durin)]
    hms2sec(Trim(genXtract(durline, "Duration:", ",")))
}
