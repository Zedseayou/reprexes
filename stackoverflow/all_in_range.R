library(tidyverse)
c1a <- read_table2(
  "WAV    UV     VIOLET    BLUE
  D1    10.8   10.1      23.5
  A4    6.2    8.2       19.9
  A1    8.3    11.7      28.6
  C2    7.9    8.2       31.0
  C3    10.7   9.5       18.1"
)

paint2 <- read_table2(
  "ID    UV     VIOLET    BLUE
  D1    7.9    10.1      19.3
  D2    7.0    9.2      15.9
  D3    21.4   20.7      27.4
  D4    10.3   8.9      20.9
  D5    21.7   16.5      21.3"
)

indices <- paint2 %>% map2(
  .x = .[, -1],
  .y = 2:ncol(.),
  .f = ~ between(.x, min(c1a[, .y]), max(c1a[, .y]))
) %>%
  transpose() %>%
  map_lgl(~ all(unlist(., use.names = FALSE))) %>%
  which()

paint2$ID[indices]
