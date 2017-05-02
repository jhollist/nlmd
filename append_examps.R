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
s3 <- rbind(c(1,6),c(2,6),c(2,7),c(1,7),c(1,6))
t1 <- rbind(c(2,0),c(3,2),c(4,0),c(2,0))
t2 <- rbind(c(),c(),c(),c())
t3
st_polygon(list(s1))

