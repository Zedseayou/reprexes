library(tidyverse)
library(lubridate)
tbl <- tibble(
  time = ymd_hms("2017-03-15 10:29:57") + 1:66
)
head(tbl)
tail(tbl)
tbl %>%
  mutate(minute = minute(time)) %>%
  group_by(minute) %>%
  filter(n() == 60)
