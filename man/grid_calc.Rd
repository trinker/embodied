\name{grid_calc}
\alias{grid_calc}
\title{Calculate Grid Lines}
\usage{
grid_calc(columns = 30, rows = columns)
}
\arguments{
  \item{columns}{The number of columns.}

  \item{rows}{The number of rows.}
}
\value{
Returns a list of 4: \item{coords}{The coordinates to
utilize for plotting the grid} \item{columns}{The number of
columns} \item{rows}{The number of rows}
\item{points}{points and labels}
}
\description{
Calculate gridlines to plot ontop of an image.
}
\examples{
grid_calc()
}
\author{
Troy (\url{stackoverflow.com}) and Tyler Rinker
<tyler.rinker@gmail.com>.
}
\references{
\url{http://stackoverflow.com/a/21043587/1000343}
}

