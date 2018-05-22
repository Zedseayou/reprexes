library(tidyverse)
data <- mtcars %>%
  bind_rows(
    mtcars %>% mutate(year = 2005),
    mtcars %>% mutate(year = 2006)
    ) %>%
  group_by(year) %>%
  mutate(rank = dense_rank(desc(mpg)))

combos <- cross_df(list(
  year = 2005:2006,
  gear = 3:5,
  start = seq(1, 100, by = 5)
  ))

combos %>%
  mutate(
    rank_range = map(start, ~ .x:(.x + 4)),
    filtered = pmap(
      .l = list(year, gear, rank_range),
      .f = ~ data %>%
        filter(gear == ..2, year == ..1) %>%
        filter(rank %in% ..3)
        )
    )
