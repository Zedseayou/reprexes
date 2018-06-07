library(tidyverse)
original <- tibble(
  ref = c("A", "A", "B", "A"),
  site = c("S1", "S2", "S1", "S1")
)

original %>%
  distinct() %>%
  group_by(site) %>%
  mutate(refcount = str_c("ref", row_number())) %>%
  spread(refcount, ref)
