library(tidyverse)
library(sf)
dane <- tibble(
  x = rpois(200, 485000),
  y = rpois(200,625000),
  ID = 1:200
  )

df_punkty <- dane %>%
  st_as_sf(coords = c("x","y")) %>%
  st_set_crs(2180)

extremes <- matrix(, 2, 2)
extremes[1, 1] <- min(dane$x)
extremes[2, 1] <- max(dane$x)
extremes[1, 2] <- min(dane$y)
extremes[2, 2] <- max(dane$y)

extremes %>%
  st_linestring() %>%
  plot()
