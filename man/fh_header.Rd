% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fh_header.R
\name{fh_header}
\alias{fh_header}
\title{Retrieve the HEADER fields of a Heidelberg format (.fh) file}
\usage{
fh_header(x)
}
\arguments{
\item{x}{The output of \code{read_fh(x, header = TRUE)}, a \code{data.frame} of class
\code{rwl}.}
}
\value{
A \code{data.frame} with 29 header fields.
}
\description{
This function reports the HEADER fields from a Heidelberg format
(.fh) ring-width file. The header fields are harvested from the .fh-file by
the \code{read_fh()} function, which stores the HEADER fields from the .fh file
as attributes of the \code{data.frame} with the measurement data it returns.
}
\examples{
Doel1 <- system.file("extdata", "DOEL1.fh", package = "fellingdater")
Doel1_trs <- read_fh(Doel1, verbose = FALSE)
fh_header(Doel1_trs)

}
