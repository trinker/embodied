\name{mp4_duration}
\alias{mp4_duration}
\alias{n_img}
\alias{size_ratio}
\title{Video Duration}
\usage{
mp4_duration(path)

n_img(path, fps)

size_ratio(width.a, height.a, width.b, height.b, path = NULL)
}
\arguments{
  \item{path}{Path to the in .mp4 file.}

  \item{fps}{The number of image frames per second to
  output.  Generally the fps used to desconstruct a video
  into images will be used to reconstruct the images back
  to video.}
}
\value{
A numeric value giving length of video in seconds.

A numeric value giving length of video in seconds.
}
\description{
\code{mp4_duration} - Reports the length of a video in
seconds.

\code{n_img} - Reports the approximate number of images
based on guration and frames per second.

\code{size_ratio} - Gives either the new width or height
given the other and the old width and height.
}
\examples{
\dontrun{
mp4_duration("foo.mp4")
n_img("foo.mp4", 4)
}
}
\keyword{duration}

