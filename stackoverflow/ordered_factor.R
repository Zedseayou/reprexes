library(tidyverse)
ranks <- c("Srg", "Lt", "Maj", "Col", "Gen")
set.seed(12345)
some_soldiers <- tibble(
  soldier = sample(ranks, 5)
)
some_soldiers

some_soldiers %>%
  mutate(
    soldier = parse_factor(soldier, levels = ranks, ordered = TRUE),
    superior = map(soldier, ~ ranks[which(ranks > .x)])
  ) %>%
  unnest()
