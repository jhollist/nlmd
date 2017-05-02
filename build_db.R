library(httr)
library(sf)
library(dplyr)

if(!file.exists("data/lakemorphometry.zip")){
  GET("https://edg.epa.gov/data/PUBLIC/ORD/NHEERL/LakeMorphometry.zip",
      write_disk("lakemorphometry.zip",TRUE), progress())
}
if(!dir.exists("data/LakeMorphGdb.gdb/")){
  unzip("data/lakemorphometry.zip",exdir = "data/")
}
lyrs <- st_layers("data/LakeMorphGdb.gdb/")$name
sf_time <- system.time({
all_morpho <- assign(lyrs[1],st_read("data/LakeMorphGdb.gdb/",lyrs[1],
                                     stringsAsFactors = FALSE)) %>%
  mutate(huc_region = lyrs[1])
for(i in lyrs[-1]){
  assign(i, st_read("data/LakeMorphGdb.gdb/",i,stringsAsFactors = FALSE))
  all_morpho <- get(i) %>%
    #filter(nlaSITE_ID != "NA") %>%
    mutate(huc_region = i) %>%
    rbind(all_morpho)
}
})

library(sp)
library(rgdal)
library(rgeos)
sp_time <- system.time({
all_morpho_sp <- assign(lyrs[1],readOGR(dsn = "data/LakeMorphGdb.gdb/", layer = lyrs[1]))
for(i in lyrs[-1]){
  assign(i,readOGR(dsn = "data/LakeMorphGdb.gdb/", layer = i))
  all_morpho_sp <- gUnion(all_morpho_sp, get(i))
}
})


