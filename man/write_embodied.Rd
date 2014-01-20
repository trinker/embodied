\name{write_embodied}
\alias{read_embodied}
\alias{write_embodied}
\title{Read/Write Data for embodied Package}
\usage{
write_embodied(id, time, people = paste("person", 1:3, sep = "_"),
  file = file.path(".", "embodied.csv"))

read_embodied(file, columns = 30, rows = columns)
}
\arguments{
  \item{id}{The id of the image numbers (generates an id
  column in the csv coding sheet.}

  \item{time}{A vector of time stamps corresponding to the
  each image id.}

  \item{people}{The people whose coordinates will be
  logged.}

  \item{file}{A path to the embodied .csv.}

  \item{columns}{The number of columns (corresponds to
  \code{\link[embodied]{gridify}}).}

  \item{rows}{The number of rows (corresponds to
  \code{\link[embodied]{gridify}}).}
}
\description{
embodied provides a rigid tempalte to code coordinate data
and reading this information back into R.
}
\note{
The \code{write_embodied}/\code{read_embodied} expects
columns to be named in a particular way.  Altering column
names (i.e. the \code{id} and \code{time} column names) may
result in error.
}
\keyword{data}
\keyword{read,}
\keyword{write,}

