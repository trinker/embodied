\name{resize}
\alias{resize}
\title{Resize Media}
\usage{
resize(path, width = 320, height = size_ratio(width, , path = path),
  out = file.path(dirname(path), paste0("resized_", basename(path))))
}
\arguments{
  \item{path}{Path to the in .mp4 file.}

  \item{out}{Path to the out .mp4 file.}

  \item{width}{The width of the device.}

  \item{height}{The height of the device.}
}
\value{
Returns resized media (.png, .avi, etc.).
}
\description{
Resize media (.png, .avi, etc.).
}
\examples{
\dontrun{
file <- system.file("extdata/deb_roy.png", package = "embodied")
resize(file, out = "test.png")
}
}

