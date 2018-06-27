dates <- c('2000-01-01', '2000-01-02', '2000-01-03', '2000-01-05', NA, '2000-01-07', '2000-01-08')

library(tidyverse)
library(lubridate)

tbl <- dates %>%
  tibble(date = .) %>%
  filter(!is.na(date)) %>%
  mutate(
    date = ymd(date),
    group = cumsum(c(TRUE, diff(date) != 1))
    ) %>%
  nest(date) %>%
  {map(.$data, ~.[['date']])}

tbl
