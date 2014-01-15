p_load(embodied, matlab, directlabels)

#fpss <- rep(c(10), each=2)
#pars <- c(TRUE, FALSE)

fpss <- rep(c(.25, .5, 1:10), each=2)
pars <- unlist(replicate(length(fpss)/2, sample(c(TRUE, FALSE)), FALSE))
p_load(matlab) 

comps <- lapply(1:length(fpss), function(i) {
    cat(paste("\n=============\n", i, " in ", length(fpss), "\n=============\n\n"))
    tic(gcFirst=FALSE) 
    gridify("talking to daddy.mp4", fps = fpss[i], parallel=pars[i])
    delete("raw")
    as.numeric(gsub("[a-z]|\\s+", "", capture.output(toc(echo=TRUE) )))
})

cons <- mp4_duration("talking to daddy.mp4")
dat <- data.frame(fps=fpss, n = fpss * cons, parallel =pars, time = unlist(comps))
dat2 <- with(dat, dat[order(fps, parallel), ])
dat2

p <- ggplot(dat2, aes(x=n, y=time, group=parallel, colour=parallel)) + 
    geom_line(size=1) + geom_point(size=2, colour="black")

direct.label(p,"last.bumpup") + 
    scale_x_continuous(
        expand = c(0,0), 
        limits = c((min(dat2$n) - max(dat2$n)*.02), 
           max(dat2$n) + (max(dat2$n)*.10))) +
    ggtitle("Parallel Processing on gridify Function") +
    annotate("text", x = 150, y =600, label = "parallel = c(TRUE, FALSE)\nNumber of Cores = 4") +
    xlab("Number of Images") + ylab("Time (sec)")

ggsave("output.png")
