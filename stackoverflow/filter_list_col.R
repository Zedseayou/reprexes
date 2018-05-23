library(tidyverse)
vec1 <- c("A", "B")
vec2 <- c("A", "B", "C")

df3 <- structure(list(A = c("X", "Y"), data = list(structure(list(B = c(4L, 9L)), .Names = "B", row.names = c(NA, -2L), class = c("tbl_df", "tbl", "data.frame")), structure(list(B = c(5L, 2L, 8L, 2L)), .Names = "B", row.names = c(NA, -4L), class = c("tbl_df", "tbl", "data.frame"))), C = list(c("A", "B"), c("A", "B", "C"))), class = c("tbl_df", "tbl", "data.frame"), row.names = c(NA, -2L), .Names = c("A", "data", "C"))

veclist <- list(vec1, vec2)
df3 %>%
  mutate(vec = match(C, veclist)) %>%
  unnest(data) %>%
  filter(vec == 1 & B < 5 | vec == 2 & B > 4) %>%
  nest(B) %>%
  mutate(C = map(vec, ~ veclist[[.]])) %>%
  as.data.frame()
