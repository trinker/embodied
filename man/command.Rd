\name{command}
\alias{command}
\title{Generic Wrapper for shell/system}
\usage{
command(cmd, ...)
}
\arguments{
  \item{cmd}{The system command to be invoked, as a
  character string.}

  \item{\ldots}{Arguments passed to either
  \code{\link[base]{shell}} or \code{\link[base]{system}}.
  Function arguments are OS dependent.  Windows users see
  \code{\link[base]{shell}}.  Others can view
  \code{\link[base]{system}} for specific function
  arguments.}
}
\description{
It is useful to use a universal system command interface
that works best with the user's particular OS.
\code{command} does this by utilizing one function to
represent both \code{\link[base]{shell}} and
\code{\link[base]{system}} without restricting the
available arguments of either base system interface.
}
\examples{
command("R --version")
}
\seealso{
\code{\link[base]{shell}}, \code{\link[base]{system}}
}

