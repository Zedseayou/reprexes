library(tidyverse)
gear_levels <- c("tri" = 3, "quad" = 4, "six" = 6, `NA` = 8)
gear_recode <- as.list(as.character(gear_levels))
names(gear_recode) <- names(gear_levels)

mtcars %>%
  mutate_at(vars(gear), parse_factor, levels = gear_levels) %>%
  mutate_at(vars(gear), fct_recode, !!! gear_recode)
