\name{mp4_to_png}
\alias{mp4_to_png}
\alias{png_to_mp4}
\title{Convert Between Video/Images}
\usage{
mp4_to_png(path, out = file.path(dirname(path), "raw"), fps = 4,
  size = "500x500", other.opts = "", crop = "", ffmpeg = NULL)

png_to_mp4(path, out = file.path(dirname(path), "raw"), fps = 4,
  ffmpeg = NULL)
}
\arguments{
  \item{path}{Path to the in .mp4 video file
  (\code{mp4_to_png}) or .png directory
  (\code{png_to_mp4}).}

  \item{out}{Path to place the out .png files or .mp4
  video.}

  \item{fps}{The number of image frames per second to
  output.  Generally the fps used to desconstruct a video
  into images will be used to reconstruct the images back
  to video.}

  \item{size}{Character string of the output size of the
  png files in the form of "width x height" (in px and no
  spaces).}

  \item{other.opts}{other options to be passed to
  \href{http://www.ffmpeg.org/}{ffmpeg}.}

  \item{crop}{Character string of
  \href{http://www.ffmpeg.org/}{ffmpeg} code used to crop
  the images (e.g. \code{"-vf crop=in_w-2*120"}).  See:
  \url{http://www.ffmpeg.org/ffmpeg-filters.html#crop} for
  more.}

  \item{ffmpeg}{Raw \href{http://www.ffmpeg.org/}{mmpeg}
  code that may be provided in lieu of the other
  arguments.}
}
\value{
\code{mp4_to_png} - Returns an directory of still .png
images.

\code{mp4_to_png} - Returns a spliced .mp4 video.
}
\description{
\code{mp4_to_png} - Converts a .mp4 video to a directory of
sill .png images.

\code{png_to_mp4} - Converts a directory of .png images to
.mp4 video.
}
\note{
User must have \href{http://www.ffmpeg.org/}{mmpeg}
installed.

\code{mp4_to_png} - Currently not functional.
}
\examples{
\dontrun{
mp4_to_png("foo.mp4")
}
}
\references{
\url{http://www.ffmpeg.org/}
}

