temps <- data.frame(
  rainfall = c(1, 1, 1, 2, 2, 2, 3, 3, 3),
  loc1 = c(77.5, 77.8, 81.2, 82.2, 80.6, 75.9, 77.6, 78.3, 81.5),
  loc2 = c(79.3, 74.2, 74.9, 77.5, 79.9, 80.1, 82.6, 80.3, 78.7)
)

library(tidyverse)
temps %>%
  rowid_to_column() %>%
  gather(loc, loc_val, starts_with("loc")) %>%
  mutate(round = round(loc_val)) %>%
  distinct(rainfall, rowid, round) %>%
  group_by(round) %>%
  summarise(mean = mean(rainfall), median = median(rainfall))
