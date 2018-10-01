library(tidyverse)
library(sf)
library(leaflet)

df1 <- data.frame(lon=c(-71.53700 -71.51676 -71.51682 -71.51524 -71.53921 -71.53700), lat=c(-32.94082, -32.93327, -32.93325, -32.92814, -32.93408, -32.94082))
df2 <- data.frame(lon=c(-72.11527, -72.09601, -72.08983, -72.10905, -72.11527), lat=c(-36.61267, -36.61720, -36.60192, -36.59682, -36.61267))
example <- list(df1, df2)

polys <- example %>%
  bind_rows(.id = "df_id") %>%
  st_as_sf(coords = c("lon", "lat"), crs = 4326) %>%
  group_by(df_id) %>%
  summarise(geometry = st_combine(geometry)) %>%
  st_cast("POLYGON")

leaflet(polys[2, ]) %>%
  addPolygons()
