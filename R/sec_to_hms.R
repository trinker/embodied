#' Convert Seconds to h:m:s.ss
#' 
#' Converts a vector of seconds to h:m:s.ss.
#' 
#' @param x A vector of times in seconds.
#' @return Returns a vector of times in h:m:s.ss format.  
#' @keywords time, conversion
#' @seealso \code{\link[chron]{times}}
#' @export
#' @importFrom chron times
#' @examples 
#' sec_to_hms(c(256, 3456, 56565))
sec_to_hms <- 
function (x) {
    l1 <- FALSE
    if (length(x) == 1) {
        x <- c(x, 0)
        l1 <- TRUE
    }
    h <- floor(x/3600)
    m <- floor((x - h * 3600)/60)
    s <- x - (m * 60 + h * 3600)
    pad <- function(x) sprintf("%02d", as.numeric(x))

    ss <- as.character(s - floor(s))
    ss <- sapply(strsplit(ss, "\\."), tail, 1)
    out <- times(paste2(data.frame(apply(data.frame(h = h, m = m, 
        s = s), 2, pad)), sep = ":"))
    out <- paste(out, ss, sep = ".")
    if (l1) {
        out <- out[1]
    }
    out
}
