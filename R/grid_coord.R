#' Convert gridify Labels to X & Y Coordinates
#' 
#' Converts the standard gridify grid labels to usable x and y coordinates that 
#' correspond tot eh center of each grid cell.
#' 
#' @param dataframe A dataframe (generally from \code{read.embodied}).
#' @param columns The number of columns (corresponds to 
#' \code{\link[embodied]{gridify}}).
#' @param rows The number of rows (corresponds to 
#' \code{\link[embodied]{gridify}}).
#' @param coord Character name of the coordinate column ("coord" by default).
#' @return Returns a dataframe with an x and y coordinates columns.
#' @keywords coordinate
#' @export 
#' @examples
#' grid_coord(deb_long)
grid_coord <- function (dataframe, columns = 30, rows = columns, coord = "coord") {

    key <- grid_calc(columns = columns, rows = rows)[["points"]][, c("labs", "x", "y")]
    COORD <- toupper(dataframe[, coord])
    dataframe[, "x"] <- COORD %l% key[, c("labs", "x")]
    dataframe[, "y"] <- COORD %l% key[, c("labs", "y")]
    
    dataframe
}

