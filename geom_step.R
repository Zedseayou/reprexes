library(tidyverse)
tbl <- tribble(
  ~s1, ~s2, ~value,
  "1/1/2018 12:00 AM", "1/1/2018 1:45 AM", 10.2,
  "1/1/2018 2:00 AM", "1/1/2018 2:30 AM", 3.1
) %>%
  mutate_at(vars(s1, s2), lubridate::dmy_hm) %>%
  gather("s", "datetime", s1, s2) %>%
  arrange(datetime)
tbl_1 <- tbl %>% bind_cols(id = group_indices(tbl, value))

tbl_2 <- tbl_1 %>%
  group_by(id) %>%
  summarise(datetime = last(datetime)) %>%
  mutate(s = "s4", value = 0) %>%
  bind_rows(tbl_1, .)
full_tbl <- tbl_2 %>%
  group_by(id) %>%
  summarise(datetime = first(datetime)) %>%
  mutate(s = "s0", value = 0) %>%
  bind_rows(., tbl_2) %>%
  arrange(datetime, s)

print(full_tbl)

ggplot(data = full_tbl) +
  geom_step(aes(x = datetime, y = value))

