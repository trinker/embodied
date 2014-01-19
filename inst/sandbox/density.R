file <- system.file("extdata/deb_roy.png", package = "embodied")
base <- read_png(file, columns=20)

dat <- deb_complete[rep(1:nrow(deb_complete), deb_complete$wc), ]

base + 
    stat_density2d(data = dat, 
        aes(x=x, y=y, alpha=..level.., fill=..level..), size=2, bins=10, geom="polygon") + 
    scale_fill_gradient(low = "yellow", high = "red") +
    scale_alpha(range = c(0.00, 0.5), guide = FALSE) +
    geom_density2d(colour="black") +
    geom_point(data = dat, aes(size = wc, colour = person, x=x, y=y)) +
    guides(alpha=FALSE)   


