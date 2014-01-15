\name{convert_to_mp4}
\alias{convert_to_mp4}
\title{Convert Video to .mp4}
\usage{
convert_to_mp4(path, out = paste0(substring(path, 1, nchar(path) - 4),
  ".mp4"), codec = NULL)
}
\arguments{
  \item{path}{Path to the in video file.}

  \item{out}{Path to the in out .mp4 file.}

  \item{codec}{An optional codec string to supply
  \href{http://www.ffmpeg.org/ffmpeg.html}{ffmpeg}.  If
  \code{NULL)}, \code{convert_to_mp4} will attempt to guess
  based on in put )\code{path}) video file extension.}
}
\description{
Reports the length of a video in seconds.
}
\examples{
\dontrun{
convert_to_mp4("new_project.wmv")
convert_to_mp4("x.avi")
}
}
\keyword{convert}

