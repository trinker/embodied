\name{png_dims}
\alias{png_dims}
\alias{size_ratio}
\title{.png Sizing}
\usage{
png_dims(path)

size_ratio(width.a, height.a, width.b, height.b, path = NULL)
}
\arguments{
  \item{path}{Path to the in .png file.}

  \item{width.a}{The new width (supply either width.a or
  height.a).}

  \item{height.a}{The new height (supply either width.a or
  height.a).}

  \item{width.b}{The old width (may give path to .png in
  liue of old width and height).}

  \item{height.b}{The old height(may give path to .png in
  liue of old width and height).}
}
\description{
\code{png_dims} - Reports the width and height of a .png
file.

\code{size_ratio} - Gives either the new width or height
given the other and the old width and height.
}
\examples{
\dontrun{
file <- system.file("extdata/deb_roy.png", package = "embodied")
png_dims(file)
size_ratio(, 10, 3, 5)
size_ratio(10, , 3, 5)
size_ratio(10, , path = file)
}
}

