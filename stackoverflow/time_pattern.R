item_time <- c(
  "pink dress july noon", "shirt september morning",
  "purple dress april", "tall purple shoes february"
)

time <- c(
  "january", "january night", "february", "march", "april", "may",
  "may morning", "june", "july", "july noon", "august", "september",
  "september morning", "october", "november", "december"
)

library(stringr)
pattern <- time %>%
  str_c(collapse = "|") %>%
  str_c("^.*(?= (", ., "))")

item_time %>%
  str_extract(pattern)
