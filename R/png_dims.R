#' .png Sizing
#' 
#' \code{png_dims} - Reports the width and height of a .png file.
#' 
#' @param path Path to the in .png file.
#' @param width.a The new width (supply either width.a or height.a).
#' @param height.a The new height (supply either width.a or height.a).
#' @param width.b The old width (may give path to .png in liue of old width and 
#' height).
#' @param height.b The old height(may give path to .png in liue of old width and 
#' height).
#' @export
#' @rdname png_dims
#' @examples
#' \dontrun{
#' file <- system.file("extdata/deb_roy.png", package = "embodied")
#' png_dims(file)
#' size_ratio(, 10, 3, 5)
#' size_ratio(10, , 3, 5)
#' size_ratio(10, , path = file)
#' }
png_dims <- function(path) {

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
    durline <- durin[grepl("png,", durin)]
    out <- as.numeric(unlist(strsplit(gsub("(.*)(\\s)(\\d+x\\d+)(.*)", 
        "\\3", durline), "x")))
    names(out) <- c("width", "height")
    out
}



#' .png Sizing
#' 
#' \code{size_ratio} - Gives either the new width or height given the other and 
#' the old width and height.
#' 
#' @export
#' @rdname png_dims
size_ratio <- function(width.a, height.a, width.b, height.b, path = NULL) {
  
    if (!is.null(path)) {
        dims <- png_dims(path)
        names(dims) <- NULL
        width.b <- dims[1]
        height.b <- dims[2]
    }
    confact <- width.b/height.b
    if (missing(width.a)) {
        height.a * confact
    } else {
        if (missing(height.a)) {
            width.a/confact
        } else {
            stop("must supply either `width.a` or `height.a`")
        }
    }

}

