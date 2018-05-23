library(tidyverse)
library(sf)
nc <- system.file("shape", "nc.shp", package = "sf") %>%
  read_sf() %>%
  st_transform(3857)

district <- st_polygon(list(matrix(
  data = c(-9000000, 4000000, -8500000, 4000000, -8500000, 4500000, -9000000, 4500000, -9000000, 4000000),
  ncol = 2,
  byrow = TRUE
  ))) %>%
  st_sfc(crs = 3857)

contained <- nc %>%
  filter(st_within(., district, sparse = FALSE))

plot(nc$geometry)
plot(district, add = TRUE)
plot(contained$geometry, add = TRUE, col = "red")
