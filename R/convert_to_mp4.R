#' Convert Video to .mp4
#' 
#' Reports the length of a video in seconds.
#' 
#' @param path Path to the in video file.
#' @param out Path to the in out .mp4 file.
#' @param codec An optional codec string to supply 
#' \href{http://www.ffmpeg.org/ffmpeg.html}{ffmpeg}.  If \code{NULL)}, 
#' \code{convert_to_mp4} will attempt to guess based on in put )\code{path})
#' video file extension.
#' @keywords convert
#' @export
#' @importFrom tools file_ext
#' @examples
#' \dontrun{
#' convert_to_mp4("new_project.wmv")
#' convert_to_mp4("x.avi")
#' }
convert_to_mp4 <- function(path, 
    out = paste0(substring(path, 1, nchar(path) - 4), ".mp4"),
    codec = NULL) {

    ## check if path exists ad out is mp4
    if (!file.exists(path)) stop(path, " does not exist")
    if (file_ext(out)!="mp4") {
    	warning("out argument, ", out, ", is not a `.mp4` file")
    }

    if (file.exists(out)) {
        message(paste0("\"", out, 
            "\" already exists:\nDo you want to overwrite?\n"))
        ans <- menu(c("Yes", "No"))
        if (ans == "2") {
            stop("convert_to_mp4 aborted")
        }
        else {
            delete(out)
        }
    }

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

    ## attempts to figure out codec to use based on infile
    if (is.null(codec)) {
        codec <- switch(file_ext(path),
             mov = {codec <- "-vcodec copy -acodec copy"}, 
             avi = {codec <- "-vcodec copy -acodec copy"},
             wmv = {codec <- "-vcodeclibx264 -strict -2"},
             {warning(file_ext(path), " type not be supported")
                 codec <- "-vcodec copy -acodec copy"}
        )
    }

    fun(sprintf("ffmpeg -i %s %s %s", 
        shQuote(path), codec, shQuote(out)))
    
    message(".mp4 file generated:\n", out)
}
