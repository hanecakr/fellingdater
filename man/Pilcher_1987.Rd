% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{Pilcher_1987}
\alias{Pilcher_1987}
\title{Pilcher 1987 sapwood data set.}
\format{
A tibble of 2 variables:
\describe{
\item{n_sapwood}{number of sapwood rings}
\item{count}{number of times n_sapwood was observed}
}
}
\source{
Pilcher J.R. 1987. A 700 year dating chronology for northern France. Applications of tree-ring studies. Current research in dendrochronology and related subjects. BAR International Series 333, 127–139.
}
\usage{
Pilcher_1987
}
\description{
Sapwood data set for northern France , published by Pilcher in 1987.
}
\details{
\if{html}{\out{<div class="sourceCode">}}\preformatted{sample size = 219 observations
}\if{html}{\out{</div>}}
}
\examples{
sw_data_info("Pilcher_1987")

sw_model("Pilcher_1987", plot = TRUE)

}
\keyword{datasets}
