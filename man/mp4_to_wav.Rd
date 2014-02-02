\name{mp4_to_wav}
\alias{mp4_to_wav}
\title{Convert .mp to Audio (.wav)}
\usage{
mp4_to_wav(path, out = file.path(path, "out.wav"), ffmpeg = NULL)
}
\arguments{
  \item{path}{Path to the in .mp4 video file.}

  \item{out}{Path to place the out .wav file.}

  \item{ffmpeg}{Raw \href{http://www.ffmpeg.org/}{mmpeg}
  code that may be provided in lieu of the other
  arguments.}
}
\value{
Returns a .wav file.
}
\description{
Converts a .mp4 video to a .wav file for use with
\pkg{seewave} and \pkg{tuneR}.
}
\note{
User must have \href{http://www.ffmpeg.org/}{mmpeg}
installed.
}
\examples{
\dontrun{
mp4_to_wav("foo.mp4", "foo.wav")
}
}
\references{
\url{http://www.ffmpeg.org/}
}

