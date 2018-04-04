library(tidyverse)
library(sf)
data <- here::here("..", "SmallAgSat_Ghana_UDRY", "2017", "final_polygons", "Ghana_UDRY_2017_final.rds") %>%
  read_rds() %>%
  st_transform(3857)

map_int(
  c(-10, -1, 1, 10, 100, 1000, 10000, 100000, 1000000, 10000000),
  function(x) data %>% st_set_precision(x) %>% st_is_valid() %>% sum()
  )

data %>%
  st_set_precision(1) %>%
  filter(st_is_valid(.)) %>%
  st_simplify(dTolerance = 1) %>%
  filter(st_is(., "POLYGON")) %>%
  # lwgeom::st_make_valid() %>%
  # SmallAgSat::validate_polygons() %>%
  # st_geometry_type() %>% table()
  # st_is_valid() %>% table()
  st_precision()
  st_intersection()
  SmallAgSat::st_remove_overlaps()
