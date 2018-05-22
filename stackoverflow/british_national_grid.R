df = read.table(text = 'Easting Northing
 320875 116975
                320975 116975
                320975 116925
                321175 116925
                321175 116875
                321275 116875', header = TRUE)

library(tidyverse)
library(sf)
df %>%
  st_as_sf(coords = c("Easting", "Northing"), crs = 27700) %>%
  st_transform(4326) %>% mapview::mapview()
  st_coordinates() %>%
  as_tibble()
