\name{gridify}
\alias{gridify}
\title{Add Grids to Multiple png}
\usage{
gridify(path = ".", out = file.path(path, "out"), columns = 20,
  rows = columns, parallel = FALSE, cores = detectCores()/2,
  width = 480, height = 480, text.color = "gray60", text.size = 3,
  grid.color = text.color, ...)
}
\arguments{
  \item{path}{Path to the in directory with the png files.}

  \item{out}{Path to the out directory.}

  \item{columns}{The number of grid columns.}

  \item{rows}{The number of grid rows.}

  \item{parallel}{logical.  If \code{TRUE} attempts to run
  the function on multiple cores.  Note that this may not
  mean a speed boost if you have one core or if the data
  set is smaller as the cluster takes time to create.}

  \item{cores}{The number of cores to use if \code{parallel
  = TRUE}.  Default is half the number of available cores.}

  \item{width}{The width of the device.}

  \item{height}{The height of the device.}

  \item{text.color}{The color to make the coordinate
  labels.}

  \item{text.size}{The size of the coordinate labels.}

  \item{grid.color}{The color to make the grid.}

  \item{\ldots}{other arguments passed to
  \code{\link[grDevices]{png}}.}
}
\value{
Returns multiple png files with grid lines.
}
\description{
A wrapper function for \code{grid_calc} and
\code{plot_grid} used to read in a directory of png files.
Add grid lines.  Output to directory.
}
\examples{
deb <- system.file("extdata", package = "embodied")
gridify(deb, "out")
}
\seealso{
\code{\link[embodied]{plot_grid}}
}

