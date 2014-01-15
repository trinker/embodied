#' Convert Between Video/Images
#' 
#' \code{mp4_to_png} - Converts a .mp4 video to a directory of sill .png images.
#' 
#' @param path Path to the in .mp4 video file (\code{mp4_to_png}) or .png 
#' directory (\code{png_to_mp4}).
#' @param out Path to place the out .png files or .mp4 video.
#' @param fps The number of image frames per second to output.  Generally the 
#' fps used to desconstruct a video into images will be used to reconstruct the 
#' images back to video.
#' @param size Character string of the output size of the png files in the form 
#' of "width x height" (in px and no spaces).
#' @param other.opts other options to be passed to 
#' \href{http://www.ffmpeg.org/}{ffmpeg}.
#' @param crop Character string of \href{http://www.ffmpeg.org/}{ffmpeg} code 
#' used to crop the images (e.g. \code{"-vf crop=in_w-2*120"}).  See: 
#' \url{http://www.ffmpeg.org/ffmpeg-filters.html#crop} for more.
#' @param ffmpeg Raw \href{http://www.ffmpeg.org/}{mmpeg} code that may be 
#' provided in lieu of the other arguments.
#' @return \code{mp4_to_png} - Returns an directory of still .png images.
#' @note User must have \href{http://www.ffmpeg.org/}{mmpeg} installed.
#' @references \url{http://www.ffmpeg.org/}
#' @export
#' @rdname mp4_to_png
#' @examples
#' \dontrun{
#' mp4_to_png("foo.mp4")
#' }
mp4_to_png <- function(path, out = file.path(dirname(path), "raw"), 
    fps = 4, size = "500x500", other.opts = "", crop = "", ffmpeg = NULL) {

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
            stop("mp4_to_raw aborted")
        }
        else {
            delete(out)
        }
    }
    folder(folder.name=out)
	
	if (!is.null(size)) {
		size <- sprintf("-s %s", size)
	} else {
		size <- ""
	}
	
    if (is.null(ffmpeg)) {
        ffmpeg <- sprintf("ffmpeg -i %s %s %s -f image2 -vf fps=fps=%s %s", 
        	shQuote(path), size, crop, fps, shQuote(out))
    	ffmpeg <- paste0(ffmpeg, "/image-%0", 
    		nchar(ceiling(fps * mp4_duration("foo.mp4"))), "d.png")
    }
    fun(ffmpeg)
    message(sprintf(".png images in:\n%s", out))
}


#' Convert Between Video/Images
#' 
#' \code{png_to_mp4} - Converts a directory of .png images to .mp4 video.
#' 
#' @return \code{mp4_to_png} - Returns a spliced .mp4 video.
#' @note \code{mp4_to_png} - Currently not functional.
#' @export
#' @rdname mp4_to_png
png_to_mp4 <- function(path, out = file.path(dirname(path), "raw"), 
    fps =4, ffmpeg = NULL) {
## Currently not working
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
            stop("mp4_to_raw aborted")
        }
        else {
            delete(out)
        }
    }
    folder(folder.name=out)
#ffmpeg -r 4 -i image-%07d.png -c:v libx264 -r 4 -pix_fmt yuv420p out.mp4		
    if (is.null(ffmpeg)) {
        ffmpeg <- sprintf("ffmpeg -r %s -i image2 -vf fps=fps=%s %s", path, fps, out)
    	ffmpeg <- paste0(ffmpeg, "/image-%07d.png")
    }
    fun(ffmpeg)
    message(sprintf(".png images in:\n%s", out))
}

