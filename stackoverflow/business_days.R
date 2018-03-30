df <- data.frame(StartDate=as.POSIXct(c("2017-05-17 12:53:00","2017-08-31 21:16:00","2017-08-25 13:54:00","2017-09-06 15:47:00","2017-10-15 05:11:00"), format = "%Y-%m-%d %H:%M:%S"),
                 EndDate=as.POSIXct(c("2017-06-09 11:57:00","2017-11-29 16:51:00","2017-09-06 15:13:00","2018-01-03 16:22:00","2017-11-17 11:51:00"), format = "%Y-%m-%d %H:%M:%S"))
library(tidyverse)
library(lubridate)

df %>%
  rename(start = StartDate, end = EndDate) %>%
  mutate_at(vars(start, end), ~ as.Date(floor_date(., unit = "day"))) %>%
  data.frame(
    .,
    day = I(map2(.$start, .$end, ~ as.character(seq.Date(.x, .y, by = 1))))) %>%
  unnest(day) %>%
  as_tibble() %>%
  mutate(wday = wday(day, week_start = 1)) %>%
  filter(wday %in% 1:5) %>%
  count(start, end)
