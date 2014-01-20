\name{plot_grid}
\alias{plot_grid}
\title{Title}
\usage{
plot_grid(file, text.color = "gray60", text.size = 2,
  grid.color = text.color, grid.size = 0.25, grid.data = grid_calc())
}
\arguments{
  \item{file}{The imput png file.}

  \item{text.color}{The color to make the coordinate
  labels.}

  \item{text.size}{The size of the coordinate labels.}

  \item{grid.color}{The color to make the grid.}

  \item{grid.size}{The thickness of the grid lines.}

  \item{grid.data}{The output from the \code{grid_calc}
  function.}
}
\value{
Returns an image with a grid and labels.
}
\description{
Description
}
\examples{
\dontrun{
deb <- system.file("extdata/deb_roy.png", package = "embodied")
plot_grid(deb, grid.data = grid_calc(5))
}
}
\author{
Troy (\url{stackoverflow.com}) and Tyler Rinker
<tyler.rinker@gmail.com>.
}
\references{
\url{http://stackoverflow.com/a/21043587/1000343}
}

