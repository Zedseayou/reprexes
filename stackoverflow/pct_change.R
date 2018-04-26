library(tidyverse)
set.seed(100)
tbl <- tibble(
  day = 1:4,
  col1 = rnorm(4, mean = 10),
  col2 = rnorm(4, mean = 10)
)

tbl %>%
  mutate_at(
    .vars = vars(-day),
    .funs = funs(pct_change = (. / lag(.)) - 1)
  )
