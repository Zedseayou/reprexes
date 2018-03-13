library(tidyverse)
library(sf)
tbl <- read_table2(
  "t        z     Etot   ID
0.00 1680.960 1192.526 sim1
0.01 1680.959 1192.526 sim1
0.02 1680.958 1192.526 sim1
0.04 1680.952 1192.526 sim1
0.06 1680.942 1192.526 sim1
0.08 1680.929 1192.526 sim1"
)

lines <- tbl %>%
  st_as_sf(coords = c("t", "z")) %>%
  group_by(ID) %>%
  summarise(Etot = mean(Etot)) %>%
  st_cast("LINESTRING")

ggplot(lines) +
  theme_bw() +
  geom_sf()
