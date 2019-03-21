library(tidyverse)
library(lubridate)
tbl <- tibble(id = c(1:4), first_log = c("18-12-01", "18-12-02", "18-12-02", "18-12-05"), X18_12_01 = c(NA, 1, 1, 2), X18_12_02 = c(5, 2, 1, 1))
tbl %>%
  gather(day, num_logins, -id, -first_log) %>%
  mutate(
    first_log = ymd(first_log),
    day = day %>% str_remove("^X") %>% ymd(),
    days_since_event = as.period(first_log %--% day, "day"),
  ) %>%
  filter(days_since_event > days(0) & days_since_event <= days(7)) %>%
  group_by(id) %>%
  summarise(total_logins = sum(num_logins, na.rm = TRUE)) %>%
  right_join(tbl, by = "id")
