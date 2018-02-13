library(tidyverse)
library(lubridate)

tbl <- tibble(
  x = 1:10,
  start = seq(
    from = ymd_hms("2018-01-01 12:00:00"),
    to = ymd_hms("2018-02-01 12:00:00"),
    length = 10
    ),
  end = seq(
    from = ymd_hms("2018-01-01 15:00:00"),
    to = ymd_hms("2018-02-01 15:00:00"),
    length = 10
  ),
  interval = start %--% end
)

tbl %>% mutate(y = 1:10)
tbl %>% select(everything())
tbl %>% arrange(end)
tbl %>% filter(x > 5)

tbl %>% select(-interval)
tbl %>% select(-interval) %>% mutate(y = 1:10)
tbl %>% select(-interval) %>% select(everything())
tbl %>% select(-interval) %>% arrange(end)
tbl %>% select(-interval) %>% filter(x > 5)

