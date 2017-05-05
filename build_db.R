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
  filter(nlaSITE_ID != "NA")

lmd <- vector("numeric",nrow(nla_morpho))         
for(i in seq_along(nla_morpho$COMID)){
  lk <- as(nla_morpho[i,], "Spatial")
  el <- get_elev_raster(lk,9)
  lmc <- lakeSurroundTopo(lk, el) 
  lmd[i] <- lakeMaxDepth(lmc)
  message(paste0(round(i/nrow(nla_morpho)*100, 3), "%"))
}

nla_morpho$max_depth_raw <- lmd