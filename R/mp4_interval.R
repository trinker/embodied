#' Grab Video Intervals
#' 
#' Grab .mp4 video from time 1 to time 2 and output a new .mp4.
#' 
#' @param path Path to the in .mp4 file.
#' @param out Path to the out .mp4 file.
#' @param from The starting time the grab from in the form of "00:00:00.0" 
#' ("hh:mm:ss.d").
#' @param to The ending time to grab to (may provide either \code{to} or 
#' \code{duration}) in the form of "00:00:00.0" ("hh:mm:ss.d").
#' @param duration The duration to the ending time to grab to (may provide 
#' either \code{to} or \code{duration}) in the form of "00:00:00.0" 
#' ("hh:mm:ss.d") or numeric seconds.
#' @param ffmpeg Raw \href{http://www.ffmpeg.org/}{mmpeg} code that may be 
#' provided in lieu of the other arguments.
#' @return Returns an interval .mp4.
#' @note User must have \href{http://www.ffmpeg.org/}{mmpeg} installed.
#' @references \url{http://www.ffmpeg.org/}
#' @export
#' @examples
#' \dontrun{
#' mp4_interval("foo.mp4", from="00:00:05.5", duration="00:00:06.5")
#' mp4_interval("foo.mp4", from="00:00:05.5", duration=6)
#' mp4_interval("foo.mp4", from="00:00:05.5", to="00:00:15.5")
#' }
mp4_interval <- function(path, out = file.path(dirname(path), "interval.mp4"), 
    from = "00:00:00.0", to = NULL, duration = NULL, ffmpeg = NULL) {

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
	
	if (is.null(path) & is.null(ffmpeg)) {
		stop("Please supply `path` or `ffmpeg`")
	}
    if (is.null(ffmpeg)) {
        if (missing(duration) && is.null(to)) {
            stop("Please supply either `to` or `duration`.")
        } 
        if (is.null(duration) && !is.null(to)) {
            duration <- hms2sec(to) - hms2sec(from)
        } 
        if (!is.numeric(duration)) {
            duration <- hms2sec(duration)
        }
        ffmpeg <- sprintf("ffmpeg -i %s -ss %s -c copy -t %s %s", 
            shQuote(path), from, duration, shQuote(out))
    }
    fun(ffmpeg)
    message(sprintf("Interval video in:\n%s", out))
}
