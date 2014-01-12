#' Title
#' 
#' Description
#' 
#' @param file The imput png file.
#' @param coord.color The color to make the coordinate labels.
#' @param grid.color The color to make the grid.
#' @param text.size The size of the coordinate labels.
#' @param grid.data The output from the \code{grid_calc} function.
#' @return Returns an image with a grid and labels.
#' @references
#' \url{http://stackoverflow.com/a/21043587/1000343}
#' @author Troy (\url{stackoverflow.com}) and Tyler Rinker <tyler.rinker@@gmail.com>.
#' @export
#' @importFrom ggplot2 ggplot annotation_custom geom_text geom_segment coord_cartesian aes theme_bw
#' @importFrom png readPNG
plotgrid <- function(file, coord.color = "gray60", grid.color = coord.color, 
	text.size = 3, grid.data = grid_calc()){
	width <- grid.data[["columns"]]
	height <- grid.data[["rows"]]
    ggplot(grid.data[["points"]]) + theme_bw()+
        annotation_custom(rasterGrob(readPNG(file), 0, 0, 1, 1, 
        	just=c("left", "bottom")), 0, width, 0, height)+
        geom_text(aes(x=x, y=y, label=labs), color=coord.color, 
        	size = text.size)+
        geom_segment(aes(x=x, xend=xend, y=y, yend=yend), 
        	data=grid.data[["coords"]], color=grid.color) +
        coord_cartesian(c(0, width), c(0, height))
}

