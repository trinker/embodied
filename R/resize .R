#' Resize Media
#' 
#' Resize media (.png, .avi, etc.).
#' 
#' @param path Path to the in .mp4 file.
#' @param out Path to the out .mp4 file.
#' @param width The width of the device.
#' @param height The height of the device.
#' @return Returns resized media (.png, .avi, etc.).
#' @export
#' @examples
#' file <- system.file("extdata/deb_roy.png", package = "embodied")
#' resize(file, out = "test.png")
resize <- function(path, width = 320, height = 240, 
    out = file.path(dirname(path), paste0("resized_", basename(path)))){

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

    ffmpeg <- sprintf("ffmpeg -i %s -vf scale=%s:%s %s", 
        shQuote(path), width, width, shQuote(out))

    fun(ffmpeg)
    message(sprintf("Resized media in:\n%s", out))
    invisible(out)

}



