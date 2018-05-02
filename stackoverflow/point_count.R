library(tidyverse)
library(sf)
nc <- system.file("shape/nc.shp", package="sf") %>%
  read_sf() %>%
  st_transform(3857)
set.seed(1000)
points <- tibble(
  x = runif(1000, min = st_bbox(nc)[1], max = st_bbox(nc)[3]),
  y = runif(1000, min = st_bbox(nc)[2], max = st_bbox(nc)[4])
) %>%
  st_as_sf(coords = c("x", "y"), crs = 3857)

plot(nc$geometry)
plot(points$geometry, add = TRUE)

nc %>%
  mutate(pt_count = lengths(st_contains(nc, points))) %>%
  select(pt_count) %>%
  plot()

mydf <- here::here("data", "manhattan", "MNMapPLUTO.shp") %>%
  st_read() %>%
  st_transform(3857)

latlon <- data_frame(
  'lat' = c(40.758896,40.758896),
  'lon' = c(-73.985130, -73.985130)
  ) %>%
  st_as_sf(coords = c("lon", "lat"), crs = 4326) %>%
  st_transform(3857)

pts <- tibble(
  x = runif(1000, min = st_bbox(mydf)[1], max = st_bbox(mydf)[3]),
  y = runif(1000, min = st_bbox(mydf)[2], max = st_bbox(mydf)[4])
) %>%
  st_as_sf(coords = c("x", "y"), crs = 3857)

mydf %>%
  mutate(pt_count = lengths(st_contains(mydf, pts))) %>%
  select(pt_count) %>%
  plot()

