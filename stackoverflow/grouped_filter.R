df <- structure(list(Stock = structure(c(1L, 1L, 1L, 2L, 2L, 2L, 3L, 3L, 3L, 4L, 4L, 4L), .Label = c("AAA", "BBB", "CCC", "DDD"), class = "factor"), Date = structure(c(17632, 17633, 17634, 17632, 17633, 17634, 17632, 17633, 17634, 17632, 17633, 17634), class = "Date"), Price = c(5L, 6L, 7L, 10L, 9L, 9L, 6L, 6L, 6L, 10L, 30L, 50L), Market.Cap = c(1000L, 1300L, 1600L, 1600L, 1000L, 1000L, 600L, 600L, 600L, 400L, 1000L, 2000L)), .Names = c("Stock", "Date", "Price", "Market.Cap"), row.names = c(NA, -12L), class = "data.frame")

library(tidyverse)
df %>%
  group_by(Stock) %>%
  filter(!any(Market.Cap > 1500 & Date == as.Date("2018-04-11")))

df %>%
  group_by(Stock) %>%
  mutate(keep = !any(Market.Cap > 1500 & Date == as.Date("2018-04-11"))) %>%
  filter(keep == TRUE)
