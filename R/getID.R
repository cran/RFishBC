#' @title Extracts a fish identification from a vector of image file names
#' 
#' @description This returns a vector of fish identification values from a vector of image file names.
#' 
#' @param x A charachter vector of image file names.
#' @param IDpattern A regular expression used to extract the fish identification value from the image file names in \code{x}. Defaults to extracting all values after the last underscore in the image file name (sans extension). Can be set with \code{\link{RFBCoptions}}.
#' @param IDreplace A string to replace the expression matched in \code{IDpattern}. Can be set with \code{\link{RFBCoptions}}.
#' @param \dots Parameters to be given to \code{\link{sub}}.
#' 
#' @seealso \code{\link{listFiles}} and \code{\link{digitizeRadii}}.
#'
#' @details By default it is assumed that the ID value follows an underscore at the end/tail of image file name (sans extension). Other patterns can be used by giving a suitable regular expression to \code{IDpattern} and possibly a replacement (usually a group identifier such as \dQuote{\\1}) in \code{IDreplace}. You may find the webpage at \code{spannbaueradam.shinyapps.io/r_regex_tester/} useful for identifying the necessary regular expression pattern for your situation.
#' 
#' If the pattern in \code{IDpattern} does not exist in each element of \code{x} then an error will be returned. In other words, the fish identification value must be in the same \dQuote{place} (based on \code{IDpattern}) in EVERY image filename.
#' 
#' If the vector of returned IDs contains any duplicated values then a warning will be issued.
#' 
#' The list of image file names in a given folder/directory may be obtained with \code{\link{listFiles}}. 
#'
#' @return Character vector.
#' 
#' @author Derek H. Ogle, \email{DerekOgle51@gmail.com}
#' 
#' @export
#'
#' @examples
#' ## These are possible vectors of image file names with the fish ID after
#' ##   the last underscore ... which is the default behavior
#' ex1 <- c("Scale_1.jpg","Scale_2.jpg")
#' ex2 <- c("Kiyi_472.bmp","Kiy_567.jpg")
#' ex3 <- c("PWF_MI345.tiff","PWF_WI567.tiff")
#' ex4 <- c("LKT_oto_23.jpg","LKT_finray_34.jpg")
#' 
#' ## These are extracted fish IDs
#' getID(ex1)
#' getID(ex2)
#' getID(ex3)
#' getID(ex4)
#' 
#' ## These are possible vectors of image file names with the fish ID NOT after
#' ##   the last underscore. This requires judicious use of IDpattern= and
#' ##   IDreplace= (similar to pattern= and replacement- as used in sub()).
#' 
#' ### fish ID at the beginning of the name
#' ex5 <- c("1_Scale.jpg","2_Scale.jpg")
#' getID(ex5,IDpattern="\\_.*")
#' 
#' ### fish ID between two underscores (might be used if multiple images for one ID)
#' ex6 <- c("DWS_100_1.jpg","DWS_101_2,jpg")
#' getID(ex6,IDpattern=".*\\_(.+?)\\_.*",IDreplace="\\1")
#' ex7 <- c("DWS_MI100_1.jpg","DWS_MI100_2,jpg")
#' getID(ex7,IDpattern=".*\\_(.+?)\\_.*",IDreplace="\\1")
#' 
#' ### Will be warned if the returned IDs are not unique
#' \dontrun{
#' ex8 <- c("Ruffe_456.jpg","Ruffe_456.jpg","Ruffe_567.jpg")
#' getID(ex8)
#' }
#' 
getID <- function(x,IDpattern,IDreplace,...) {
  if (missing(IDpattern)) IDpattern <- iGetopt("IDpattern")
  if (missing(IDreplace)) IDreplace <- iGetopt("IDreplace")
  if (!all(grepl(IDpattern,x))) STOP("'IDpattern' not found in all items of 'x'")
  else res <- sub(x=tools::file_path_sans_ext(x),
                  pattern=IDpattern,
                  replacement=IDreplace,
                  ...)
  if (length(res)!=length(unique(res))) WARN("All returned IDs are not unique.")
  res
}
