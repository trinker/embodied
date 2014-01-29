\name{mp4_duration}
\alias{mp4_duration}
\alias{mp4_to_times}
\alias{n_img}
\title{Video Duration}
\usage{
mp4_duration(path)

n_img(path, fps)

mp4_to_times(path, fps = 4)
}
\arguments{
  \item{path}{Path to the in .mp4 file.}

  \item{fps}{The number of image frames per second to
  output.  Generally the fps used to desconstruct a video
  into images will be used to reconstruct the images back
  to video.}
}
\value{
\code{mp4_duration} - A numeric value giving length of
video in seconds.

\code{n_img} - A numeric value giving the number of images
created from the video.

\code{mp4_to_times} - A sequence of times corresponding to
\code{fps} and video duration
}
\description{
\code{mp4_duration} - Reports the length of a video in
seconds.

\code{n_img} - Reports the approximate number of images
based on guration and frames per second.

\code{mp4_to_times} - Generate a sequence of times
corresponding to \code{fps} and video duration.
}
\examples{
\dontrun{
mp4_duration("foo.mp4")
n_img("foo.mp4", 4)
mp4_to_times("foo.mp4", 4)
}
}
\keyword{duration}

