\name{mp4_interval}
\alias{mp4_interval}
\title{Grab Video Intervals}
\usage{
mp4_interval(path, out = file.path(dirname(path), "interval.mp4"),
  from = "00:00:00.0", to = NULL, duration = NULL, ffmpeg = NULL)
}
\arguments{
  \item{path}{Path to the in .mp4 file.}

  \item{out}{Path to the out .mp4 file.}

  \item{from}{The starting time the grab from in the form
  of "00:00:00.0" ("hh:mm:ss.d").}

  \item{to}{The ending time to grab to (may provide either
  \code{to} or \code{duration}) in the form of "00:00:00.0"
  ("hh:mm:ss.d").}

  \item{duration}{The duration to the ending time to grab
  to (may provide either \code{to} or \code{duration}) in
  the form of "00:00:00.0" ("hh:mm:ss.d") or numeric
  seconds.}

  \item{ffmpeg}{Raw \href{http://www.ffmpeg.org/}{mmpeg}
  code that may be provided in lieu of the other
  arguments.}
}
\value{
Returns an interval .mp4.
}
\description{
Grab .mp4 video from time 1 to time 2 and output a new
.mp4.
}
\note{
User must have \href{http://www.ffmpeg.org/}{mmpeg}
installed.
}
\examples{
\dontrun{
mp4_interval("foo.mp4", from="00:00:05.5", duration="00:00:06.5")
mp4_interval("foo.mp4", from="00:00:05.5", duration=6)
mp4_interval("foo.mp4", from="00:00:05.5", to="00:00:15.5")
}
}
\references{
\url{http://www.ffmpeg.org/}
}

