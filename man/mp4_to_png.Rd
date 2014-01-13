\name{mp4_to_png}
\alias{mp4_to_png}
\title{Convert Video to Images}
\usage{
mp4_to_png(path, out = file.path(dirname(path), "raw"), images.per.sec = 1,
  ffmpeg = NULL)
}
\arguments{
  \item{path}{Path to the in .mp4 file.}

  \item{out}{Path to place the out .png files.}

  \item{frames}{per second The number of image frames per
  second to output.}

  \item{ffmpeg}{Raw \href{http://www.ffmpeg.org/}{mmpeg}
  code that may be provided in lieu of the other
  arguments.}
}
\value{
Returns an interval .mp4.
}
\description{
Convert an .mp4 video to .png images.
}
\note{
User must have \href{http://www.ffmpeg.org/}{mmpeg}
installed.
}
\examples{
\dontrun{
mp4_to_png("spliced.mp4")
}
}
\references{
\url{http://www.ffmpeg.org/}
}

