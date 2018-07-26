library(tidyverse)
library(sf)
set.seed(12345)
dtorig <- tibble(
  x = 1:100,
  lat = (sample(c(800:900), 100)) / 100,
  lon = (sample(c(3800:3900), 100)) / 100
)

sforig <- st_as_sf(dtorig, coords = c("lon", "lat"), crs = 4326)

distances <- sforig %>%
  st_distance(by_element = FALSE) %>%
  unclass %>%
  `[<-`(lower.tri(., diag = TRUE), NA) %>%
  as_tibble() %>%
  rowid_to_column %>%
  gather(colid, distance, starts_with("V"), na.rm = TRUE) %>%
  arrange(desc(distance))
distances

sforig %>%
  st_geometry %>%
  plot(col = "red", pch = 19)

sforig %>%
  filter(x %in% c(30, 68)) %>%
  st_geometry %>%
  plot( add = TRUE, col = "blue", pch = 19)
