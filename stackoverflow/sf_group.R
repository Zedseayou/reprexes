library(tidyverse)
library(sf)
set.seed(100)
nc <- system.file("shape/nc.shp", package="sf") %>%
  st_read() %>%
  mutate(
    group = sample.int(5, 100, replace = TRUE),
    group = parse_factor(group, levels = 1:5)
    )

plot(nc[, "group"])
ggplot(nc, aes(fill = group)) +
  theme_minimal() +
  geom_sf() +
  scale_fill_brewer(type = "qual")
