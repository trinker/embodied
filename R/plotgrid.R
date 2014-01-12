#' Title
#' 
#' Description
#' 
#' @param file
#' @param coord.color
#' @param grid.color
#' @param text.size
#' @param grid.data
#' @return
#' @references
#' @keywords
#' @export
#' @seealso
#' @examples
plotgrid <- function(file, coord.color = "gray60", grid.color = coord.color, 
	text.size = 3, grid.data = grid_dat){
	width <- grid.data[["w"]]
	height <- grid.data[["h"]]
    ggplot(grid.data[["points"]]) + theme_bw()+
        annotation_custom(rasterGrob(readPNG(file), 0, 0, 1, 1, 
        	just=c("left", "bottom")), 0, width, 0, height)+
        geom_text(aes(x=x, y=y, label=labs), color=coord.color, 
        	size = text.size)+
        geom_segment(aes(x=x, xend=xend, y=y, yend=yend), 
        	data=grid.data[["coords"]], color=grid.color) +
        coord_cartesian(c(0, width), c(0, height))
}

