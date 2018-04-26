library(lubridate)
library(tidyverse)
df <- data.frame(
  id = c(1, 2, 3, 4, 5, 6),
  dates = as.Date(c(
    "2017-01-15", "2017-01-17", "2017-02-01",
    "2017-02-12", "2017-03-30", "2017-04-01"
  ))
)

df %>%
  mutate(
    interval = interval(dates - 30, dates),
    dates_in_intv = map_int(interval, function(x) sum(.$dates %within% x))
    )
