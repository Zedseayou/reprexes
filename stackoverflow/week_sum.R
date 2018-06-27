library(tidyverse)
library(lubridate)
df <- data.frame('date' = c(20160309, 20160310, 20160311, 20160312, 20160313, 20160314, 20160315, 20160317, 20160318, 20160319, 20160321), 'value' = c(1, 2, 3, 4, 5, 6, 7 ,8, 9, 10, 11))
df %>%
  mutate(date = ymd(date)) %>%
  complete(date = seq.Date(min(date), max(date), by = 1)) %>%
  arrange(date) %>%
  mutate(
    newval = replace_na(value, 0),
    weekSum = newval + lag(newval) + lag(newval, 2) + lag(newval, 3) +
      lag(newval, 4) + lag(newval, 5) + lag(newval, 6)
  ) %>%
  select(-newval) %>%
  filter(!is.na(value))
