wd <- getwd()
setwd("movie2frames")
x <- folder(out)
setwd(x)
fls <-file.path("movie2frames/out", rdirs(out, 1:10, text.only = TRUE))
folder(folder.name = fls)


##  browseURL("https://copy.com/web/spliced.mp4?download=1")
##  move to working directory

## cd GitHub/density/movie2frames  ## shell command

## Splice
## ffmpeg -i truly_amazing_teacher.mp4 -ss 00:00:20.0 -c copy -t 00:00:35.0 spliced.mp4

shell("ffmpeg -i deb_roy.mp4 -ss 00:11:16.0 -c copy -t 1 spliced.mp4")
shell("ffmpeg -i spliced.mp4 -r 1 -s 700x500 -vf crop=in_w-2*120 -f image2 out/image2-%07d.png")

grid.data <- grid_calc()
width <- grid.data[["columns"]]
height<- grid.data[["rows"]]
ggplot(grid.data[["points"]]) + theme_bw()+  
    annotation_custom(rasterGrob(readPNG("out/image2-0000004.png"), 0, 0, 1, 1, 
        just=c("left", "bottom")), 0, width, 0, height) +
        annotate("text", x=14, y=15, label = "Image from Deb Roy Ted Talk\nhttp://www.youtube.com/watch?v=RE4ce4mexrU", size=4.5, color="white") +
        #annotate(text, aes(x=15, y=15, label="Image from Deb Roy Ted Talk\nhttp://www.youtube.com/watch?v=RE4ce4mexrU"), color="white", 
        #	size = 3)+
        coord_cartesian(c(0, width), c(0, height)) +
  theme(axis.text=element_blank(),
        axis.ticks=element_blank(),
        plot.margin=unit(c(0,0,-1,-1), "cm"))


ggsave("deb_roy.png")

library(png)
library(grid)
img <- readPNG("out/image2-0000004.png")
g <- rasterGrob(img, interpolate=TRUE)

qplot(1:10, 1:10, geom="blank") +
  annotation_custom(g, 0, width, 0, height) +
  coord_cartesian(c(0, width), c(0, height))

