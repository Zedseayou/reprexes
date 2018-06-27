df <- structure(list(clusters = c(1L, 3L, 2L, 1L, 3L), tag = structure(c(3L, 4L, 2L, 1L, 5L), .Label = c("bat|hat|dog", "cat|bat|dog", "cat|hat|dog", "cat|hat|hog", "rat|mat|hog"), class = "factor")), class = "data.frame", row.names = c(NA, -5L))

library(tidyverse)
df %>%
  separate_rows(tag, sep = "\\|") %>%
  add_count(clusters) %>%
  group_by(clusters, tag) %>%
  summarise(prop = first(n()) / first(n) * 3)
