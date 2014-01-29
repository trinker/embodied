#' Merge Multiple PDFs
#' 
#' Allows for merging of multiple PDF files.
#' 
#' @param pdfs A vector of paths to multiple PDFs.
#' @param out Path to the output merged PDF.
#' @return Returns a single combined plot.
#' @references \url{http://trinkerrstuff.wordpress.com/2012/10/08/splitting-and-combining-r-pdf-visuals/}
#' @author Ananda Mahto and Tyler Rinker <tyler.rinker@@gmail.com>.
#' @export 
merge_pdf <- function(pdfs, out) {
    mergePDF(in.file = pdfs, file = out)
    message(sprintf("Merged pdf file converted to:\n%s", out))
    invisible(out)	
}

