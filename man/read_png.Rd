\name{read_png}
\alias{read_png}
\title{Read In .png File}
\usage{
read_png(file, columns = 30, rows = columns)
}
\arguments{
  \item{file}{The imput png file.}

  \item{columns}{The number of columns (corresponds to
  \code{\link[embodied]{gridify}}).}

  \item{rows}{The number of rows (corresponds to
  \code{\link[embodied]{gridify}}).}
}
\value{
Reads in and plots a png file.
}
\description{
Reads a .png file in as a ggplot2 object.
}
\examples{
file <- system.file("extdata/deb_roy.png", package = "embodied")
base <- read_png(file)
base
}
\keyword{raster}

