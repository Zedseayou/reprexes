library(tidyverse)
library(sf)
library(fiftystater)

sf_fifty <- sf::st_as_sf(fifty_states, coords = c("long", "lat")) %>%
  group_by(id, piece) %>%
  summarize(do_union = FALSE) %>%
  st_cast("POLYGON") %>%
  ungroup()

midwest <- sf_fifty %>%
  filter(
    id %in% c(
      "illinois", "indiana", "iowa",
      "kansas", "michigan", "minnesota",
      "missouri", "nebraska", "north dakota",
      "ohio", "south dakota", "wisconsin"
    )
  ) %>%
  summarise(id = "midwest")

ggplot() +
  theme_minimal() +
  geom_sf(data = sf_fifty) +
  geom_sf(data = midwest, col = "hotpink", alpha = 0, size = 2)
