library(tidyverse)
library(sf)
library(sp)
Sr1 = Polygon(cbind(c(2,4,4,1,2),c(2,3,5,4,2)))
Sr2 = Polygon(cbind(c(5,4,2,5),c(2,3,2,2)))
Srs = Polygons(list(Sr1,Sr2), "s1/2")

SpP = SpatialPolygons(list(Srs))
sfc <- st_as_sfc(SpP)
sfc

sf_obj <- sfc %>%
  map(
    .f = function(polygon) polygon %>% map(list) %>% st_multipolygon()
  ) %>%
  st_sfc() %>%
  st_sf() %>%
  rowid_to_column() %>%
  st_cast("POLYGON") %>%
  mutate(area = st_area(geometry)) %>%
  group_by(rowid) %>%
  top_n(1, area)

plot(sfc, col = "red")
plot(sf_obj$geometry, col = "blue", add = TRUE)

