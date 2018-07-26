library(tidyverse)
library(sf)

light_shape <- read_sf(here::here("data", "light_shape.shp"))
light_shape %>%
  filter(!is.na(segment_ID)) %>%
  group_by(segment_ID) %>%
  summarise() %>%
  ggplot() +
  geom_sf(aes(fill = factor(segment_ID)))
