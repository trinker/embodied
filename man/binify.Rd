\name{binify}
\alias{binify}
\title{Cut Vector Into Binned List}
\usage{
binify(x, breaks = 10)
}
\arguments{
  \item{x}{A vector.}

  \item{breaks}{The number of bins to create (the
  \code{length} of the list output).}
}
\value{
Returns a list equal in length to \code{breaks}.
}
\description{
Cut a vector into a binned list.
}
\examples{
binify(LETTERS)
binify(LETTERS, 3)
}

