library(tidyverse)
library(sf)
library(rnaturalearth)
library(maps)

x_coord <- c(25, 25, 275, 275)
y_coord <- c(20, -50, -50, 20)
polygon <-  cbind(x_coord, y_coord) %>%
  st_linestring() %>%
  st_cast("POLYGON") %>%
  st_sfc(crs = 4326, check_ring_dir = TRUE) %>%
  st_sf() %>%
  st_wrap_dateline(options = c("WRAPDATELINE=YES", "DATELINEOFFSET=180"))

land <- rnaturalearth::ne_countries(returnclass = "sf") %>%
  st_union()
ocean <- st_difference(polygon, land)

plot(st_geometry(land))
plot(st_geometry(polygon), add = TRUE)
plot(st_geometry(ocean), add = TRUE, col = "blue")

ggplot() +
  theme_bw() +
  borders("world") +
  geom_sf(data = ocean)

