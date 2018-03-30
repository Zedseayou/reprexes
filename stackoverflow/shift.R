library(tidyverse)
tbl <- read_table2(
  "date a b c d e f
   2008 1 5 3 6 9 8
   2008 3 6 2 1 5 8
   2008 2 8 3 4 3 0
   2009 5 5 3 6 9 8
   2009 3 3 2 2 5 5
   2010 2 8 3 7 7 0"
)

tbl %>%
  select(-date) %>%
  map2_dfc(.x = ., .y = 1:ncol(.), ~ lag(.x, n = .y - 1, default = 0)) %>%
  bind_cols(date = tbl$date, .)
