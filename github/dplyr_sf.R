library(tidyverse)
library(sf)
set.seed(12345)
points = map2(runif(50, -10, 10), runif(50, -10, 10), ~ st_point(c(.x, .y))) %>%
  st_sfc(crs = 4326) %>%
  st_transform(3857)
sf_pts = st_sf(val = 1:50, geometry = points)

ring1 = st_buffer(points, 50000)
ring2 = st_buffer(points, 100000)
sep_rings = st_sfc(map2(ring2, ring1, ~ st_difference(.x, .y)), crs = 3857)
sf_opt1 <- sf_pts %>%
  st_set_geometry(sep_rings)
plot(sf_opt1)
plot(sf_opt1$geometry)
plot(sf_pts$geometry, add = T)

sf_opt2 <- sf_pts %>%
  mutate(
    ring1 = st_buffer(geometry, 50000),
    ring2 = st_buffer(geometry, 100000)
    ) %>%
  rowid_to_column() %>%
  group_by(rowid) %>%
  mutate(geometry = st_difference(ring2, ring1)) %>%
  ungroup() %>%
  select(val)
plot(sf_opt2)
plot(sf_opt2$geometry)
plot(sf_pts$geometry, add = T)

st_bbox(sf_opt1)
st_bbox(sf_opt2)
