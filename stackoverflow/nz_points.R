library(tidyverse)
library(sf)
library(rnaturalearth)

nz <- ne_countries(country = "New Zealand", returnclass = "sf", scale = "large") %>%
  st_cast("POLYGON") %>%
  mutate(area = st_area(geometry)) %>%
  top_n(3, area)

points <- tibble(
  x = runif(1000, st_bbox(nz)[1], st_bbox(nz)[3]),
  y = runif(1000, st_bbox(nz)[2], st_bbox(nz)[4])
)
points
points <- st_as_sf(points, coords = c("x", "y"), crs = 4326)
plot(nz$geometry, col = "red")
plot(points, pch = 19, cex = 1, add = TRUE)

points <- points %>% mutate(on_land = lengths(st_within(points, nz)))
plot(nz$geometry, col = "red")
plot(points, pch = 19, cex = 1, add = TRUE)
