\name{dir_png}
\alias{dir_png}
\title{Directory .png Files}
\usage{
dir_png(path, full = FALSE)
}
\arguments{
  \item{path}{Path to the directory where the .png files
  are to be located.}

  \item{full}{logical.  If \code{TRUE} then the entire path
  to each .pg image is given.}
}
\value{
Returns a character vector with image names that are .png
files.
}
\description{
Given a directory, \code{dir_png} will determine the files
(with optional full path; see \code{full} argument) that
are .png files.
}
\examples{
dir.create("DELETE_ME")
png("DELETE_ME/test1.png"); plot(1:10); dev.off()
png("DELETE_ME/test2.png"); plot(1:10); dev.off()
pdf("DELETE_ME/test3.pdf"); plot(1:10); dev.off()
dir_png("DELETE_ME")
unlink("DELETE_ME", recursive = TRUE, force = FALSE)
}
\seealso{
\code{\link[tools]{file_ext}}
}

