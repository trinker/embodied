library(embodied)
deb_long

columns = 20; rows = columns; dataframe <- deb_long; coord = "coord"

grid_coord <- function (dataframe, columns = 20, rows = columns, coord = "coord") {

    key <- grid_calc(columns = columns, rows = rows)[["points"]][, c("labs", "x", "y")]
    COORD <- toupper(dataframe[, coord])
    dataframe[, "x"] <- COORD %l% key[, c("labs", "x")]
    dataframe[, "y"] <- COORD %l% key[, c("labs", "y")]
    
    dataframe
}

dat <- grid_coord(deb_long)
library(png); library(grid)

head(dat)
file <- system.file("extdata/deb_roy.png", package = "embodied")



read_png <- function(file, columns = 20, rows = 20){
    dat <- data.frame(x = c(0, columns), y = c(0, rows))
    ggplot(data = dat, aes(x=x, y=y)) + theme_bw()+
        annotation_custom(rasterGrob(readPNG(file), 0, 0, 1, 1, 
            just=c("left", "bottom")), 0, columns, 0, rows) +
        coord_cartesian(c(0, columns), c(0, rows)) +
        theme(axis.text=element_blank(),
            axis.ticks=element_blank(),
            plot.margin=unit(c(0,0,-1,-1), "cm"))
}

## here we're working with one static image so pass it once
## otherwise we'd loop through the files as well.

base <- read_png(file)

dat[, "person"] <- reports:::simpleCap(dat[, "person"])


## i <- 13
ids <- as.character(unique(dat[, "id"]))
pp <- function() {
    for (i in 1:length(ids)) {
       png(sprintf("out/img-%s.png", pad(1:length(ids))[i]), width=450, height = 400)
        if (i == 1) {
            print(base + 
                geom_point(
                    data = dat[dat[, "id"] %in% ids[1:i], ], 
                    aes(group = person, 
                        colour=person), 
                    size = 2) + 
                theme(legend.position="bottom", 
                    plot.margin=unit(c(0,0,1,-1), "cm"), 
                    legend.title=element_blank(), 
                    axis.title.x = element_blank())) 
        } else {
            print(base + 
                geom_point(data = dat[dat[, "id"] %in% ids[i], ], 
                    aes(group = person, 
                        colour=person), 
                    size = 2) +
                geom_path(data = dat[dat[, "id"] %in% ids[1:i], ], 
                    aes(group = person, colour=person)) + 
                theme(legend.position="bottom", 
                    plot.margin=unit(c(0,0,1,-1), "cm"), 
                    legend.title=element_blank(), 
                    axis.title.x = element_blank())) 
        }
       dev.off()
    }
}

pp()


shell("ffmpeg -r 5 -i out/img-%02d.png -c:v libx264 -r 30 -pix_fmt yuv420p out/out.mp4")
shell("convert -delay 10 -loop 0 out/*.png out/out.gif") #requires imagemagick

