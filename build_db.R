library(httr)
library(sf)
library(dplyr)
library(elevatr)
library(lakemorpho)

if(!file.exists("data/lakemorphometry.zip")){
  GET("https://edg.epa.gov/data/PUBLIC/ORD/NHEERL/LakeMorphometry.zip",
      write_disk("lakemorphometry.zip",TRUE), progress())
}
if(!dir.exists("data/LakeMorphGdb.gdb/")){
  unzip("data/lakemorphometry.zip",exdir = "data/")
}
lyrs <- st_layers("data/LakeMorphGdb.gdb/")$name
all_morpho <- assign(lyrs[1],st_read("data/LakeMorphGdb.gdb/",lyrs[1],
                                     stringsAsFactors = FALSE)) %>%
  mutate(huc_region = lyrs[1])
for(i in lyrs[-1]){
  assign(i, st_read("data/LakeMorphGdb.gdb/",i,stringsAsFactors = FALSE))
  all_morpho <- get(i) %>%
    mutate(huc_region = i) %>%
    rbind(all_morpho)
}

nla_morpho <- all_morpho %>%
  filter(!is.na(nlaSITE_ID))

lmd <- vector("numeric",nrow(nla_morpho))         
for(i in seq_along(nla_morpho[,1])){
  browser()
  lk <- as(nla_morpho[i,], "Spatial")
  el <- get_elev_raster(lk,12,src = "aws")
  lmc <- lakeSurroundTopo(lk, el) 
  lmd[i] <- lakeMaxDepth(lmc)
}

nla_morpho$max_depth_raw <- lmd