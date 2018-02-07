library(tidyverse)
library(lubridate)
library(magrittr)

comms.break<- tibble(line = c("line1","line2","line3","line1"),eventstart = c("1/1/2017 7:24","1/2/2017 8:25","1/1/2017 7:24","1/2/2017 9:25"),eventend = c("1/1/2017 7:25","1/2/2017 8:26","1/1/2017 7:29","1/2/2017 10:25"))

line1_intv <- comms.break %>%
  filter(line == "line1") %>%
  mutate(interval = interval(dmy_hm(eventstart), dmy_hm(eventend))) %>%
  extract2("interval")

line2_intv <- comms.break %>%
  filter(line == "line2") %>%
  mutate(interval = interval(dmy_hm(eventstart), dmy_hm(eventend))) %>%
  extract2("interval")

line3_intv <- comms.break %>%
  filter(line == "line3") %>%
  mutate(interval = interval(dmy_hm(eventstart), dmy_hm(eventend))) %>%
  extract2("interval")

minutes <- comms.break %>%
  gather(key = "event", value = "datetime", eventstart, eventend) %>%
  mutate(datetime = dmy_hm(datetime)) %>%
  arrange(datetime) %>%
  complete(datetime = full_seq(datetime, 60)) %>%
  spread(key = "line", value = "event") %>%
  select(datetime)

output <- minutes %>%
  bind_cols(line1 = map_lgl(minutes$datetime, ~ any(. %within% line1_intv))) %>%
  bind_cols(line2 = map_lgl(minutes$datetime, ~ any(. %within% line2_intv))) %>%
  bind_cols(line3 = map_lgl(minutes$datetime, ~ any(. %within% line3_intv))) %>%
  mutate_at(vars(line1:line3), as.integer)
print(output)
