\name{gridify}
\alias{gridify}
\title{Add Grids to Multiple png}
\usage{
gridify(path = ".", out = file.path(path, "out"), pdf = TRUE,
  columns = 30, rows = columns, parallel = TRUE,
  cores = detectCores()/2, width = 6, height = 6, text.color = "gray60",
  text.size = 3, grid.color = text.color, fps = 4, size = "500x500",
  other.opts = "", crop = "", ...)
}
\arguments{
  \item{path}{Path to the in directory with the .png files
  or a single .mp4 file.}

  \item{out}{Path to the out directory.}

  \item{pdf}{logical.  If \code{TRUE} a single .pdf
  (\file{./raw/gridified.png}) is generated.  This enables
  zooming and a single scrollable file.}

  \item{columns}{The number of grid columns.}

  \item{rows}{The number of grid rows.}

  \item{parallel}{logical.  If \code{TRUE} attempts to run
  the function on multiple cores.  Note that this may not
  mean a speed boost if you have one core or if the data
  set is smaller as the cluster takes time to create. For a
  visual representation of the use of parallel processing
  see:
  \url{https://raw.github.com/trinker/embodied/master/inst/gridify_parallel_test/output.png}}

  \item{cores}{The number of cores to use if \code{parallel
  = TRUE}.  Default is half the number of available cores.}

  \item{width}{The width of the device.}

  \item{height}{The height of the device.}

  \item{text.color}{The color to make the coordinate
  labels.}

  \item{text.size}{The size of the coordinate labels.}

  \item{grid.color}{The color to make the grid.}

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

  \item{\ldots}{other arguments passed to
  \code{\link[grDevices]{png}}.}
}
\value{
Returns multiple png files with grid lines.
}
\description{
A wrapper function for \code{grid_calc} and
\code{plot_grid} used to read in a directory of png files.
Add grid lines.  Output to directory.
}
\examples{
deb <- system.file("extdata", package = "embodied")
gridify(deb, "out")
}
\seealso{
\code{\link[embodied]{plot_grid}}
\code{\link[embodied]{mp4_to_png}}
}

