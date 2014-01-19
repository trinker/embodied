\name{grid_coord}
\alias{grid_coord}
\title{Convert gridify Labels to X & Y Coordinates}
\usage{
grid_coord(dataframe, columns = 30, rows = columns, coord = "coord")
}
\arguments{
  \item{dataframe}{A dataframe (generally from
  \code{read.embodied}).}

  \item{columns}{The number of columns (corresponds to
  \code{\link[embodied]{gridify}}).}

  \item{rows}{The number of rows (corresponds to
  \code{\link[embodied]{gridify}}).}

  \item{coord}{Character name of the coordinate column
  ("coord" by default).}
}
\value{
Returns a dataframe with an x and y coordinates columns.
}
\description{
Converts the standard gridify grid labels to usable x and y
coordinates that correspond tot eh center of each grid
cell.
}
\examples{
grid_coord(deb_long)
}
\keyword{coordinate}

