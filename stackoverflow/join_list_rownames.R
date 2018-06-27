library(tidyverse)
lst <- list(
  data.frame(x = 1:3, y = 2:4, row.names = letters[1:3]),
  data.frame(z = 1:4, w = 2:5, row.names = letters[3:6]),
  data.frame(r = 2:4, s = 3:5, row.names = letters[2:4])
)

lst %>%
  map(rownames_to_column) %>%
  bind_rows() %>%
  group_by(rowname) %>%
  summarise_all(mean, na.rm = TRUE) %>%
  map_dfc(replace_na, 0)

