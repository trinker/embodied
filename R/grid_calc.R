#' Title
#' 
#' Description
#' 
#' @param width
#' @param height
#' @return
#' @references
#' @keywords
#' @export
#' @seealso
#' @examples
grid_calc <- function(width = 10, height = width) {
	
    # generate the points and labels for the grid
    points <- data.frame(expand.grid(w=1:width, h=1:height))
    points$labs <- paste0("(", points$w, "," ,points$h, ")")
    points$x <- points$w-0.5 # center
    points$y <- points$h-0.5
    
    # make the gridline co-ordinates
    gridx <- data.frame(x=0:width, xend=0:width, y=rep(0,width+1), 
    	yend=rep(height, width+1))
    gridy <- data.frame(x=rep(0, height+1), xend=rep(width, height+1), 
    	y=0:height, yend=0:height)
    list(coords = rbind(gridx, gridy), w = width, h = height, points = points)
}

