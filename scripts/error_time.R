library(tidyverse)
library(lubridate)
start = parse_date_time("2018-01-01","%Y-%m-%d")
end = parse_date_time("2018-01-02","%Y-%m-%d")
series = seq(start,end,by=600)
error = data.frame(
  on = parse_date_time(c("2018-01-01 00:13:57","2018-01-01 01:01:44"),"%Y-%m-%d %H:%M:%S"),
  off = parse_date_time(c("2018-01-01 00:21:32","2018-01-01 02:33:45"),"%Y-%m-%d %H:%M:%S")
) %>%
  mutate(
    off = ceiling_date(off, unit = "10 minutes"),
    intvs = interval(on, off)
  )

series %>%
  tibble(dttm = .) %>%
  bind_cols(status = map_lgl(series, ~ any(. %within% error$intvs))) %>%
  mutate(status = ifelse(status == TRUE, "ERROR", "OK")) %>%
  print(n = 20)
