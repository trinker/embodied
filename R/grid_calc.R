#' Calculate Grid Lines
#' 
#' Calculate gridlines to plot ontop of an image.
#' 
#' @param columns The number of columns.
#' @param rows The number of rows.
#' @return Returns a list of 4:
#' \item{coords}{The coordinates to utilize for plotting the grid} 
#' \item{columns}{The number of columns} 
#' \item{rows}{The number of rows} 
#' \item{points}{points and labels} 
#' @references
#' \url{http://stackoverflow.com/a/21043587/1000343}
#' @author Troy (\url{stackoverflow.com}) and Tyler Rinker <tyler.rinker@@gmail.com>.
#' @export
#' @examples
#' grid_calc()
grid_calc <- function(columns = 20, rows = columns, coord.labs = FALSE) {
	
    # generate the points and labels for the grid
    points <- data.frame(expand.grid(w=1:columns, h=1:rows))
	if (coord.labs) {
         points$labs <- paste0("(", points$w, "," ,points$h, ")")
	} else {
		nr <- nrow(points)
		nl <- ceiling(nr/26)
		points$labs <- paste0(rep(LETTERS, nl), rep(1:nl, each = nl))[1:nr]
		
	}
    points$x <- points$w-0.5 # center
    points$y <- points$h-0.5
    
    # make the gridline co-ordinates
    gridx <- data.frame(x=0:columns, xend=0:columns, y=rep(0,columns+1), 
    	yend=rep(rows, columns+1))
    gridy <- data.frame(x=rep(0, rows+1), xend=rep(columns, rows+1), 
    	y=0:rows, yend=0:rows)
    list(coords = rbind(gridx, gridy), columns = columns, rows = rows, 
    	points = points)
}
