library(tidyverse)
tbl_A <- read_table2(
  "x     y     z     a     b     c
  1      0      0      3      0      0
  2      0      0      5      6      5
  3      0      0      6      8      2
  4      0      1      8      0      6
  5      0      0      20     2      0
  6      0      1      3      3      7"
)
tbl_b <- tbl_A %>%
  filter(z == 1) %>%
  summarise_at(vars(a:c), ~ sum(. > 5 & . < 10)) %>%
  print()
