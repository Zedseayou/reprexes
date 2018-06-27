library(tidyverse)
df <- structure(list(V1 = c("Date", "Equip", "x1", "x2", "x3"), V2 = c(
  "12/16/18",
  "a", "1", "3", "5"
), V3 = c("12/17/18", "b", "2", "4", "6")), class = "data.frame", .Names = c(
  "V1",
  "V2", "V3"
), row.names = c(NA, -5L))

df %>%
  t() %>%
  `colnames<-`(.[1, ]) %>%
  `[`(-1, ) %>%
  as_tibble() %>%
  gather("metric", "value", x1:x3) %>%
  arrange(Date, Equip, metric)
