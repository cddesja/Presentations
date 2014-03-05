\name{win}
\alias{win}

\title{
Winsorized Mean
}
\description{
This function calculates the winsorized mean
}

\usage{
win(x, tr = 0.2)
}

\arguments{
  \item{x}{A vector of values for calculating the mean}
  \item{tr}{The value to use for trimming. By default this is 0.2}
}


\value{
An object of class \code{funMeans} is returned. Running summary for this object returns information about the winsorized mean, the mean, and the sample size. 
}

\references{
Desjardins, C. 2014. Wonderful world of central tendencies.
}

\author{
Christopher David Desjardins
}

\seealso{
See Also as \code{\link{trim}}, ~~~
}

\examples{
\dontrun{
FunMeans2 <- win(trim.data)
summary(FunMeans2)
}
}

\keyword{methods}
