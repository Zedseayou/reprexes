library(tidyverse)
tbl <- tibble(
  year = rep(1901, 6),
  month = 1:6,
  X1 = c(9.1, 0, 0, 0, 0, 0),
  X2 = rep(0, 6),
  X3 = rep(0, 6),
  X4 = rep(0, 6),
  X5 = c(0, 0.5, 0, 0, 1.8, 0),
  X6 = c(0, 0, 0, 0, 4.3, 0)
)

tbl %>%
  gather(key = "day", value = "precip", X1:X6) %>%
  mutate(day = as.numeric(str_replace(day, "X", ""))) %>%
  arrange(year, month, day)
