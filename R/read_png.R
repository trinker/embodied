#' Read In .png File
#' 
#' Reads a .png file in as a ggplot2 object.
#' 
#' @param file The imput png file.
#' @param columns The number of columns (corresponds to 
#' \code{\link[embodied]{gridify}}).
#' @param rows The number of rows (corresponds to 
#' \code{\link[embodied]{gridify}}).
#' @return Reads in and plots a png file.
#' @keywords raster 
#' @export
#' @importFrom ggplot2 ggplot theme annotation_custom geom_text geom_segment coord_cartesian aes theme_bw
#' @importFrom png readPNG
#' @importFrom grid rasterGrob unit
#' @examples
#' file <- system.file("extdata/deb_roy.png", package = "embodied")
#' base <- read_png(file)
#' base
read_png <- function(file, columns = 30, rows = columns){
    dat <- data.frame(x = c(0, columns), y = c(0, rows))
    ggplot(data = dat, aes(x=x, y=y)) + theme_bw()+
        annotation_custom(rasterGrob(readPNG(file), 0, 0, 1, 1, 
            just=c("left", "bottom")), 0, columns, 0, rows) +
        coord_cartesian(c(0, columns), c(0, rows)) +
        theme(axis.text=element_blank(),
            axis.ticks=element_blank(),
            plot.margin=unit(c(0,0,-1,-1), "cm"))
}
