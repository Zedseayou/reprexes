library(tidyverse)

stringColumn = c(
  "50m 26.50 26.50 100m 53.82 27.32",
  NA,
  "50m 25.83 25.83 100m 52.99 27.16",
  "25m 12.46 12.46 50m 26.26 13.80 75m 40.02 13.76 100m 53.48 13.46",
  NA,
  "25m 11.72 11.72 50m 25.33 13.61 75m 39.15 13.82 100m 52.55 13.40",
  "50m 27.20 27.20 100m 56.38 29.18 150m 1:26.39 30.01 200m 1:56.16 29.77"
)

c <- stringColumn %>%
  str_split(" (?=\\d+?m)") %>%
  tibble(strings = .) %>%
  rowid_to_column(var = "stringid") %>%
  unnest(strings) %>%
  separate(strings, c("measurement", "totaltime", "timeatcurrentpoint"), sep = " ") %>%
  select(-timeatcurrentpoint) %>%
  spread(measurement, totaltime)
