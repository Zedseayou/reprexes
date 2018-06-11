df <- structure(list(type = structure(c(1L, 1L, 1L, 2L, 2L, 3L, 3L, 3L), .Label = c("rna", "dna", "protein"), class = "factor"), value = c(1, 2, 3, 20, 30, -9.6, 300, 1000), test = list(c(0, 12), 2, 3, 4, 5, 6, 7, c(20, 1))), row.names = c(NA, -8L), class = "data.frame")

library(tidyverse)
df %>%
  arrange(desc(map_dbl(test, max)))
