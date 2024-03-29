% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/growthDataUtils.R
\name{gConvert}
\alias{gConvert}
\title{Converts between types of measurements.}
\usage{
gConvert(
  df,
  in.pre = NULL,
  in.var = NULL,
  out.type = c("inc", "rad"),
  out.pre = out.type
)
}
\arguments{
\item{df}{A data.frame that contains the growth measurement data in one-fish-per-line (i.e., \dQuote{wide}) format.}

\item{in.pre}{A string that indicates the prefix for all variable names in the input data.frame that contain the measurements from the calcified structures. See details.}

\item{in.var}{A vector of column numbers or variable names in the input data.frame that contain the measurements from the calcified structures. See details.}

\item{out.type}{A string that identifies the output format data type (i.e., the format to convert to). If \code{"inc"} (the default) the output data frame will be incremental measurements. If \code{"rad"} the output data frame will be radial measurements.}

\item{out.pre}{A string that indicates the prefix to use for the newly computed measurements in the output data frame. Defaults to the same string as \code{out.type}.}
}
\value{
A data.frame with all columns, except for those defined by \code{in.pre} or \code{in.var}, from the \code{df} retained as the left-most columns and the original data in the \code{in.var} columns converted to the \code{out.type} type as the remaining columns.
}
\description{
Converts one-fish-per-line (i.e., \dQuote{wide}) format growth data from radial to incremental or incremental to radial measurements.
}
\details{
The data must be in one-fish-per-line (i.e., \dQuote{wide}) format where each row contains all information (including all measurements from the calcified structure) for an individual fish. It is assumed that the input data.frame is of the opposite data type given in \code{out.type} (i.e., that a conversion is needed). It does not check to see if this is true.

The columns that contain the original measurement data can specified in a variety of ways. First, if all columns begin with the same prefix (and no other columns contain that prefix), then the prefix string may be given to \code{in.pre=}. Second, a sequence of column numbers may be given to \code{in.var=} with the \code{#:#} (if the columns are contiguous) or as a vector (if the columns are not contiguous). Third, a vector of column names may be given to \code{in.var=}. Note  that one, but not both, of \code{in.var=} or \code{in.pre=} must be specified by the user.

The newly computed data will be labeled with a prefix the same as \code{out.type=} (i.e., \code{"rad"} or \code{"inc"}) unless \code{out.pre=} is set by the user. For example, if the data are converted to radial measurements, then the output variables will be \dQuote{rad1}, \dQuote{rad2}, etc. unless \code{out.pre=} was changed from the default. This function assumes that the measurements start with age-1.
}
\examples{
## Get data with radial measurements
data(SMBassWB,package="FSA")
head(SMBassWB)

## Use in.pre= to convert to increments
SMBi1 <- gConvert(SMBassWB,in.pre="anu",out.type="inc")
head(SMBi1)

## Use in.var= with column names to convert to increments
SMBi2 <- gConvert(SMBassWB,in.var=c("anu1","anu2","anu3","anu4",
                                    "anu5","anu6","anu7","anu8",
                                    "anu9","anu10","anu11","anu12"),
                           out.type="inc")
head(SMBi2)

## Use in.var with column numbers to convert to increments
SMBi3 <- gConvert(SMBassWB,in.var=8:19,out.type="inc")
head(SMBi3)

## Convert back to radial measurements
SMBr1 <- gConvert(SMBi1,in.pre="inc",out.type="rad")
head(SMBr1)

}
\seealso{
See \code{\link{addRadCap}} for related functionality.
}
\author{
Derek H. Ogle, \email{DerekOgle51@gmail.com}
}
\keyword{manip}
