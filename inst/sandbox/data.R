deb <- system.file("extdata/deb_roy.png", package = "embodied")
plot_grid(deb, grid.color="red", text.color="black")


motion <- data.frame(
    id = pad(1:30),
    time = tail(sec2hms(680 + seq(0, 30*.5, by=.5)), -1),
    deb = qcv(h4, i4, i4, i4, p3, p3, q3, q3, r3, r3, r3, r3, s3, t3, a3, b3, 
        b3, c3, x3, q4, q4, k5, d6, e6, e6, f6, g6, f6, e6, d6),
    philip = qcv(p11, w10, x10, x10, d10, d10, d10, i9, i9, j9, p8, o8, t7, 
        t7, n8, n8, n8, g9, a10, a10, a10, b10, c10, w10, q11, k12, k12, f13, 
        l12, l12),
    rony = rep("l11", 30),
    brandon = qcv(w12, w12, w12, w12, w12, b12, g11, l10, k10, j10, j10, c11, 
        b11, v11, q12, r12, r12, r12, s12, y11, x11, q12, m13, w11, g10, n9, q9, 
        x8, e8, k7)
)


melt(motion, id.vars = c('id', 'time'))

