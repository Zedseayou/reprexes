library(tidyverse)
mspec <- list(
  tibble(x = c(60, 26, 3), y = c(32, 37, 4)),
  tibble(x = c(6, 10), y = c(14, 3))
)

mspec %>%
  imap(~ mutate(.x, index = .y)) %>%
  bind_rows()
