library(tidyverse)
tbl <- tribble(
  ~one, ~two, ~three, ~type,
  "x", "x", "", "chocolate",
  "x", "", "", "vanilla",
  "x", "x", "", "strawberry"
) %>%
  mutate_at(vars(one:three), function(x) ifelse(x == "", NA_character_, x)) %>%
  gather(key = "number", value = "x", one:three) %>%
  rowid_to_column() %>%
  spread(key = number, value = x) %>%
  arrange(type) %>%
  filter(!(is.na(one) & is.na(two) & is.na(three))) %>%
  select(one, two, three, type) %>%
  print()
