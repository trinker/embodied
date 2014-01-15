## Create delete directories:
delete <- function(file = NULL) {
    x <- if (is.null(file)) {
        menu(dir())
    } else {
        file
    }
    unlink(x, recursive = TRUE, force = FALSE)
}

folder <- function(..., folder.name = NULL) {
    if (!is.null(folder.name)) {
        x <- strsplit(folder.name, split = ", ")
    } else {
        x <- substitute(...())
    }
    if (!is.null(x)) {
        x <- unblanker(scrubber(unlist(lapply(x, function(y) {
            as.character(y)}))))
    }
    if (is.null(x)) {
        hfolder()
    } else {
        if (length(x) == 1) {
            hfolder(x)
        } else {
            lapply(x, function(z) {
                hfolder(z)
            })
        }
    }
}

hfolder <- function(folder.name = NULL) {
    if (is.null(folder.name)) {
        FN <- mgsub(c(":", " "), c(".", "_"), 
            substr(Sys.time(), 1, 19))
    } else {
        FN <-folder.name
    }
    parts <- unlist(strsplit(FN, "/"))
    if (length(parts) == 1) {
        x <- paste(getwd(), "/", FN, sep = "")
    } else {

        ## If nested path (multiple directories created)
        if (!file.exists(dirname(FN))) {

            y <- FN
            z <- length(parts)
            for (i in rev(seq_along(parts))) {
                if(file.exists(y)) {
                    z <- z + 1
                    break
                }
                y <- dirname(paste(parts[1:i], collapse ="/"))
                z <- z - 1
            }
            
            for (i in z:(length(parts) - 1)) {
                suppressWarnings(dir.create(paste(parts[1:i], collapse ="/")))
            }
        
        }
        x <- FN
    }
    dir.create(x)
    return(x)
}
#================
## Print function
prin <- function(x, print) {
    if (print) {
        cat(x); cat("\n")
        invisible(x)
    } else {
        x	
    }
}
#================
## Convert hours:mins:secs to numeric seconds
hms2sec <- function (x) {
    hms <- as.character(x)
    op <- FALSE
    if (length(hms) == 1) {
        hms <- c(hms, "00:00:00")
        op <- TRUE
    }
    DF <- sapply(data.frame(do.call(rbind, strsplit(hms, ":"))), 
        function(x) {
            as.numeric(as.character(x))
        })
    out <- DF[, 1] * 3600 + DF[, 2] * 60 + DF[, 3]
    if (op) {
        out <- out[1]
    }
    out
}
#================
## Parsing tools
unblanker <-
function(x)subset(x, nchar(x)>0)

scrubber <-
function(text.var, rm.quote = TRUE, fix.comma = TRUE, ...){
    x <- reducer(Trim(clean(text.var)))
    if (rm.quote) {
        x  <- gsub('\"', "", x)
    }
    if (fix.comma) {
        x <- gsub(" ,", ",", x)
    }
    ncx <- nchar(x)
    x <- paste0(Trim(substring(x, 1, ncx - 1)), substring(x, ncx))
    x[is.na(text.var)] <- NA
    x
}

mgsub <-
function(pattern, replacement = NULL, text.var, fixed = TRUE, ...){
    key <- data.frame(pat=pattern, rep=replacement, 
        stringsAsFactors = FALSE)
    msubs <-function(K, x, ...){
        sapply(seq_len(nrow(K)), function(i){
                x <<- gsub(K[i, 1], K[i, 2], x, fixed = fixed, ...)
            }
        )
       return(gsub(" +", " ", x))
    }
    x <- Trim(msubs(K=key, x=text.var, ...))
    return(x)
}

Trim <-
function (x) gsub("^\\s+|\\s+$", "", x)

reducer <- 
function(x) gsub("\\s+", " ", x)

clean <-
function(text.var) {
    gsub("\\s+", " ", gsub("\r|\n|\t", " ", text.var))
}
#================
## Grab text between 2 points
genXtract <- 
function(text.var, left, right, with = FALSE, merge = TRUE){
    if (length(left) != length(right)) {
        stop("left and right must be equal length") 
    }
    specchar <- c(".", "|", "(", ")", "[", "{", "^", "$", "*", "+", "?")
    left <- mgsub(specchar, paste0("\\", specchar), left, fixed = TRUE)
    right <- mgsub(specchar, paste0("\\", specchar), right, fixed = TRUE)
    FUN <- function(left, right, text.var, with){   
        fmt <- if (with==TRUE) {
            "(%s).*?(%s)"
        } else {
            "(?<=%s).*?(?=%s)"
        }
        re <- sprintf(fmt, as.character(left), as.character(right))
        if(length(text.var)==1){
            unlist(regmatches(text.var, gregexpr(re, text.var, perl=TRUE)))
        }else{  
            regmatches(text.var, gregexpr(re, text.var, perl=TRUE)) 
        }
    }
    out <- invisible(lapply(seq_along(left), function(i) {
        FUN(left[i], right[i], text.var = text.var, with = with)
    }))
    names(out) <- paste(left, " : ", "right")
    if (length(left) == 1) {
        return(unlist(out, recursive = FALSE))
    } else {
        if (merge) {
            out <- invisible(lapply(seq_along(text.var), function(i) {
                unlist(invisible(lapply(seq_along(out), function(j) {
                    out[[j]][[i]]
                })))
            }))            
        }
    }
    out
}
#================
## 
