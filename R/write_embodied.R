#' Read/Write Data for embodied Package
#' 
#' embodied provides a rigid tempalte to code coordinate data and reading this 
#' information back into R.  
#' 
#' @param id The id of the image numbers (generates an id column in the csv 
#' coding sheet.
#' @param time A vector of time stamps corresponding to the each image id. Note 
#' that in order to properly view the time format column the user may need to 
#' adjust the .csv display settings when the .csv is opened.  Within some 
#' spreadsheet programs, changing the \strong{format} to a \strong{custom} of 
#' \code{hh:mm:ss.00} enables proper viewing.
#' @param people The people whose coordinates will be logged.
#' @param file A path to the embodied .csv coding sheet.
#' @note The \code{write_embodied}/\code{read_embodied} expects columns to be 
#' named in a particular way.  Altering column names (i.e. the \code{id} and 
#' \code{time} column names) may result in error.
#' @keywords read, write, data
#' @rdname write_embodied
#' @export
#' @importFrom reshape2 melt
write_embodied <- function(id, time, people = paste("person", 1:3, sep="_"), 
    file = file.path(".", "embodied.csv")) {

    n <- length(id)
    dat <- data.frame(id = id, time = time, 
        matrix(rep(NA, n * length(people)), nrow = n))

	names(dat)[-c(1:2)] <- people
    write.csv(dat, file = file, row.names = FALSE, na = "")
}

#'
#'
#'
#'
#'
#' @param columns The number of columns (corresponds to 
#' \code{\link[embodied]{gridify}}).
#' @param rows The number of rows (corresponds to 
#' \code{\link[embodied]{gridify}}).
#' @rdname write_embodied
#' @export
read_embodied <- function(file, columns = 30, rows = columns) {

    dat <- read.csv(file)
    dat_long <- melt(dat, id.vars =c("id", "time"))
    names(dat_long)[3:4] <- c("person", "coord") 
    grid_coord(dat_long, columns = columns, rows = rows)
 
}





