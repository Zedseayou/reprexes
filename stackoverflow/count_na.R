library(tidyverse)
df <- data.frame(
  Q1 = c("Yes", "No", "Yes", "No", "Yes", "Yes", "Yes"),
  Q1a = c("AAA", NA, "AAA", NA, "ABC", "DDD", "EEE"),
  Q1b = c("BBB", NA, NA, NA, "BCD", NA, "AAA"),
  Q1c = c(NA, NA, NA, NA, "EFG", NA, "AAA")
)

df %>%
  mutate(
    count_non_na = pmap(
      .l = list(Q1a, Q1b, Q1c),
      .f = function(...) sum(!rlang::are_na(c(...)))
    )
  )
