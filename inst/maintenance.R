####################
# MAINTENANCE FILE #
###############################################################
# This file is designed to hold small scripts associated with #
# internal embodied package maintenance tasks.                #
###############################################################

#==========================
#staticdocs current version
#==========================
#packages
# install.packages("highlight"); library(devtools); install_github("staticdocs", "hadley")

library(highlight); library(qdap); library(staticdocs); library(acc.roxygen2)

#STEP 1: create static doc  
#right now examples are FALSE in the future this will be true
#in the future qdap2 will be the go to source
build_package(package="C:/Users/trinker/GitHub/embodied", 
    base_path="C:/Users/trinker/Desktop/embodied/", examples = TRUE)

#STEP 2: reshape index
path <- "C:/Users/trinker/Desktop/embodied"
path2 <- paste0(path, "/index.html")
rdme <- "C:/Users/trinker/GitHub/embodied/inst/extra_statdoc/readme.R"

expand_statdoc(path2, to.icon = c("png_to_mp4", "n_img"), readme = rdme)


#STEP 3: move to trinker.guthub
library(reports)
file <- "C:/Users/trinker/GitHub/trinker.github.com/"
delete(paste0(file, "embodied"))
file.copy(path, file, TRUE, TRUE)
delete(path)

#==========================
#Check spelling
#==========================
path <- file.path(getwd(), "R")
txt <- suppressWarnings(lapply(file.path(path, dir(path)), readLines))
txt <- lapply(txt, function(x) x[substring(x, 1, 2) == "#'"])
new <- lapply(1:length(txt), function(i){
    c("\n", dir(path)[i], "=========", txt[[i]])
})
out <- paste(unlist(new), collapse="\n")
cat(out, file=file.path(path.expand("C:/Users/trinker/Desktop"), "spelling.doc"))

#==========================
#Get Examples to run
#==========================
library(embodied)
examples(path = "C:/Users/trinker/GitHub/embodied/R/")

#==========================
# NEWS.md
#==========================
update_news()


#==========================
# NEWS new version
#==========================
x <- c("BUG FIXES", "NEW FEATURES", "MINOR FEATURES", "IMPROVEMENTS", "CHANGES")
cat(paste(x, collapse = "\n\n"), file="clipboard")

#==========================
# Compress pdf vignette
#==========================
tools::compactPDF("vignettes/embodied-package.pdf", gs_quality = "ebook")

x <- "vignettes/figure"
lapply(file.path(x, dir(x)), tools::compactPDF, gs_quality = "ebook")




