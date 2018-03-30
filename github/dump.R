library(tidyverse)
library(sf)
polys <- "C:/Users/Calum/Documents/GitHub/SmallAgSat_Ghana_UDRY/2017/raw_polygons/Ghana_UDRY_2017_raw.kml" %>%
  st_read() %>%
  st_zm() %>%
  st_cast("POLYGON") %>%
  mutate_if(is.factor, as.character) %>%
  mutate(
    merge_id = str_extract(
      string = Description,
      pattern = "(?<=filename_town</td> <td>).*?(?=</td)")
  ) %>%
  select(merge_id) %>%
  SmallAgSat::calc_area_ha() %>%
  lwgeom::st_make_valid() %>%
  SmallAgSat::validate_polygons() %>%
  arrange(merge_id, desc(area_ha)) %>%
  as.data.frame() %>%
  group_by(merge_id) %>%
  summarise(area_ha = first(area_ha), geometry = first(geometry)) %>%
  mutate(
    geometry = geometry %>%
      unclass() %>%
      map(~ st_polygon(list(.))) %>%
      st_sfc()
  ) %>%
  st_sf() %>%
  st_simplify(dTolerance = 0.00001) %>%
  st_set_crs(4326) %>%
  SmallAgSat::st_deduplicate(merge_id)
st_intersection(polys)

p4 <- polys[c(2358, 2374, 2384, 2976), ]
st_write(p4, "p4.kml", delete_dsn = TRUE)
write_rds(p4, "p4.rds")

x <- dput(p4)
y <- st_read("p4.kml")
z <- read_rds("p4.rds")
st_intersection(p4)
st_intersection(x)
st_intersection(y)
st_intersection(z)

prune <- polys[-c(2358, 2374, 2384, 2976, 2757, 2776, 2792), ]
st_intersection(prune)
st_write(prune, "prune.kml", delete_dsn = TRUE)
prune2 <- st_read("prune.kml")
st_intersection(prune2)

st_erase = function(x, y) st_difference(x, st_union(st_combine(y)))
plot(p4$geometry[1])
st_erase(p4$geometry[1], p4$geometry[-1]) %>% plot(add = T)

