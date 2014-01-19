#' Deb Roy Fake Lab Motion & Dialogue (Long Format)
#' 
#' A fictional long dataset containing fabricated motion paths and dialogue for 
#' Deb Roy, Philip DeCamp, Brandon C. Roy, and Rony Kubat in Deb's MIT lab.
#' 
#' @details 
#' \itemize{ 
#'   \item id. The image frame id number.
#'   \item time. The video time.
#'   \item person. The person who is moving.
#'   \item coord. The grid location of the individual at that time.
#'   \item dialogue. The speech being used (taken from Romeo and Juliet.
#'   \item wc. Word count.
#'   \item x. An x coordinate (developed from \code{gridify}).
#'   \item y. A y coordinate (developed from \code{gridify}).
#' } 
#' 
#' @docType data 
#' @keywords datasets 
#' @name deb_complete 
#' @usage data(deb_complete) 
#' @format A data frame with 120 rows and 6 variables 
#' @references \url{http://www.ted.com/talks/deb_roy_the_birth_of_a_word.html}
NULL


#' Deb Roy Fake Lab Motion (Wide Format)
#' 
#' A fictional wide dataset containing fabricated motion paths for Deb Roy, 
#' Philip DeCamp, Brandon C. Roy, and Rony Kubat in Deb's MIT lab.
#' 
#' @details 
#' \itemize{ 
#'   \item id. The image frame id number.
#'   \item time. The video time. 
#'   \item deb. Fake movement for Deb Roy.
#'   \item philip. Fake movement for Philip DeCamp.
#'   \item rony. Fake movement for Rony Kubat.
#'   \item brandon. Fake movement for Brandon C. Roy.
#' } 
#' 
#' @docType data 
#' @keywords datasets 
#' @name deb_wide 
#' @usage data(deb_wide) 
#' @format A data frame with 30 rows and 6 variables 
#' @references \url{http://www.ted.com/talks/deb_roy_the_birth_of_a_word.html}
NULL
 
#' Deb Roy Fake Lab Motion (Long Format)
#' 
#' A fictional long dataset containing fabricated motion paths for Deb Roy, 
#' Philip DeCamp, Brandon C. Roy, and Rony Kubat in Deb's MIT lab.
#' 
#' @details 
#' \itemize{ 
#'   \item id. The image frame id number.
#'   \item time. The video time.
#'   \item person. The person who is moving.
#'   \item coord. The grid location of the individual at that time.
#' } 
#' 
#' @docType data 
#' @keywords datasets 
#' @name deb_long 
#' @usage data(deb_long) 
#' @format A data frame with 120 rows and 4 variables 
#' @references \url{http://www.ted.com/talks/deb_roy_the_birth_of_a_word.html}
NULL
 
#' Deb Roy Fake Dialogue 
#' 
#' A fictional dataset containing fabricated dialogue for Deb Roy, Philip 
#' DeCamp, Brandon C. Roy, and Rony Kubat in Deb's MIT lab.  Dialogue taken from
#' Romeo and Juliet.
#' 
#' @details 
#' \itemize{ 
#'   \item person. The person who is talking.
#'   \item time. The video time.
#'   \item dialogue. The speech being used (taken from Romeo and Juliet.
#' } 
#' 
#' @docType data 
#' @keywords datasets 
#' @name deb_dialogue 
#' @usage data(deb_dialogue) 
#' @format A data frame with 30 rows and 3 variables 
NULL

