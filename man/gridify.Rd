\name{gridify}
\alias{gridify}
\title{Add Grids to Multiple png}
\usage{
gridify(path = ".", out = file.path(path, "out"), pdf = TRUE,
  columns = 30, rows = columns, parallel = TRUE,
  cores = detectCores()/2, width = 6, height = 6, text.color = "gray60",
  text.size = 2, grid.size = 0.25, grid.color = text.color, fps = 4,
  size = "500x500", other.opts = "", crop = "",
  code.sheet = file.path(out, "embodied.csv"), duration = NULL,
  people = paste("person", 1:3, sep = "_"), clean = TRUE, ...)
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

  \item{grid.size}{The thickness of the grid lines.}

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

  \item{code.sheet}{A path to the embodied .csv coding
  sheet.}

  \item{duration}{An aptional duration of the original
  video, in seconds, if .png files are passed to
  \code{path}.  This is used for \code{code.sheet}. Note
  that \code{fps} should also be set.}

  \item{people}{The people whose coordinates will be
  logged.}

  \item{clean}{logical.  If \code{TRUE} and \code{pdf =
  TRUE} the directory with sequence of images will be
  removed after
  \href{http://www.ghostscript.com/}{Gohstscript}
  integration.}

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
\note{
Note that in order to properly view the time format column
in the \code{code.sheet}, the user may need to adjust the
.csv display settings when the .csv is opened.  Within some
spreadsheet programs, changing the \strong{format} to a
\strong{custom} of \code{hh:mm:ss.00} enables proper
viewing.
}
\examples{
deb <- system.file("extdata", package = "embodied")
gridify(deb, "out")
}
\author{
Ananda Mahto and Tyler Rinker <tyler.rinker@gmail.com>.
}
\seealso{
\code{\link[embodied]{plot_grid}}
\code{\link[embodied]{mp4_to_png}}
}

