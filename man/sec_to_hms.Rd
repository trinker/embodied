\name{sec_to_hms}
\alias{sec_to_hms}
\title{Convert Seconds to h:m:s.ss}
\usage{
sec_to_hms(x)
}
\arguments{
  \item{x}{A vector of times in seconds.}
}
\value{
Returns a vector of times in h:m:s.ss format.
}
\description{
Converts a vector of seconds to h:m:s.ss.
}
\examples{
sec_to_hms(c(256, 3456, 56565))
}
\seealso{
\code{\link[chron]{times}}
}
\keyword{conversion}
\keyword{time,}

