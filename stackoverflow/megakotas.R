library(tidyverse)
library(sf)
library(raster)
# library(sp)
# library(rgeos)

states <- getData("GADM", country = "USA", level = 1) %>%
  st_as_sf() %>%
  st_transform(crs = 3310)

megakotas <- states %>%
  left_join(
    y = rownames_to_column(USArrests, var = "State"),
    by = c("NAME_1" = "State")
  ) %>%
  filter(!NAME_1 %in% c("District of Columbia", "Alaska", "Hawaii")) %>%
  mutate(State = fct_collapse(NAME_1, Megakotas = c("North Dakota", "South Dakota"))) %>%
  group_by(State) %>%
  summarise(Murder = sum(Murder)) %>%
  st_simplify(dTolerance = 1000)

ggplot(megakotas) +
  geom_sf(aes(fill = Murder)) +
  scale_fill_viridis_c() +
  theme_minimal()
