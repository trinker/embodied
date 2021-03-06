#' Video Duration
#' 
#' \code{mp4_duration} - Reports the length of a video in seconds.
#' 
#' @param path Path to the in .mp4 file.
#' @return \code{mp4_duration} - A numeric value giving length of video in 
#' seconds.
#' @keywords duration
#' @export
#' @rdname mp4_duration
#' @examples
#' \dontrun{
#' mp4_duration("foo.mp4")
#' n_img("foo.mp4", 4)
#' mp4_to_times("foo.mp4", 4)
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

#' Video Duration
#' 
#' \code{n_img} - Reports the approximate number of images based on guration and 
#' frames per second.
#' 
#' @param fps The number of image frames per second to output.  Generally the 
#' fps used to desconstruct a video into images will be used to reconstruct the 
#' images back to video.
#' @return \code{n_img} - A numeric value giving the number of images created 
#' from the video.
#' @export
#' @rdname mp4_duration
n_img <- function(path, fps) {
    ceiling(fps * mp4_duration(path))
}

#' Video Duration
#' 
#' \code{mp4_to_times} - Generate a sequence of times corresponding to 
#' \code{fps} and video duration.
#' 
#' @return \code{mp4_to_times} - A sequence of times corresponding to 
#' \code{fps} and video duration
#' @export
#' @rdname mp4_duration
mp4_to_times <- function(path, fps = 4) {
    tot <- mp4_duration(path)
    part <- tot - floor(tot)
    vals <- seq(0, 1, by = 1/fps)
    difs <- vals - part
    minval <- vals[difs >= 0][1]
    maxtime <- ceiling(tot) + minval
    sec_to_hms(seq(0, maxtime, by = 1/fps))
}

