#' Cut Vector Into Binned List
#' 
#' Cut a vector into a binned list.
#' 
#' @param x A vector.
#' @param breaks The number of bins to create (the \code{length} of the list 
#' output).
#' @return Returns a list equal in length to \code{breaks}.
#' @export
#' @examples
#' binify(LETTERS)
#' binify(LETTERS, 3)
binify <- function(x, breaks = 10){
    y <- as.numeric(as.character(cut(seq_along(x), breaks, 
        labels = 1:breaks)))
    split(x, y)
}