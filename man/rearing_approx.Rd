% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/set-instream-habitat.R
\name{rearing_approx}
\alias{rearing_approx}
\title{function uses an existing relationship to return a linear interpolated approx function}
\usage{
rearing_approx(watershed, species, life_stage)
}
\arguments{
\item{watershed}{name of the watershed to compute approx function on}

\item{species}{one of 'fr' (Fall Run), 'sr' (Spring Run), or 'st' (Steelhead)}
}
\value{
an approx function obtained from calling \code{\link[stats]{approxfun}}
}
\description{
function uses an existing relationship to return a linear interpolated approx function
}
