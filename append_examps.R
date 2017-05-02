# compare union vs rbind
library(sf)
lyrs <- st_layers("data/LakeMorphGdb.gdb/")$name[1:3]
assign(lyrs[1],st_read("data/LakeMorphGdb.gdb/",lyrs[1],
                                       stringsAsFactors = FALSE))
x <- California18[7710,]
x
y <- California18[7711,]


s1 <- rbind(c(0,0),c(1,0),c(1,1),c(0,1),c(0,0))
s2 <- rbind(c(3,3),c(5,3),c(5,5),c(3,5),c(3,3))
s2_hole <- rbind(c(3.5,3.5),c(4.5,3.5),c(4.5,4.5),c(3.5,4.5),c(3.5))
s3 <- rbind(c(1,6),c(2,6),c(2,7),c(1,7),c(1,6))
t1 <- rbind(c(2,0),c(3,2),c(4,0),c(2,0))
t2 <- rbind(c(4,2),c(4,1),c(7,2),c(4,2))
t3 <- rbind(c(4,6),c(6,6),c(6,7),c(4,6))

squares_sfc <- st_sfc(st_polygon(list(s1)),st_polygon(list(s2, s2_hole)),
                      st_polygon(list(s3)))
squares <- st_sf(data.frame(ltrs = letters[1:3], nums = 1:3), 
                 geom = squares_sfc)
triangles_sfc <- st_sfc(st_polygon(list(t1)), st_polygon(list(t2)), 
                        st_polygon(list(t3)))
triangles <- st_sf(data.frame(ltrs = letters[4:6], nums = c(7,99,5)), 
                   geom = triangles_sfc)

sq_tri <- rbind(squares,triangles)


plot(squares)
plot(triangles,add=T)

plot(
