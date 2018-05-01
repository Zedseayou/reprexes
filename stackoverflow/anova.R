library(tidyverse)
tbl <- read_table2(
  "id  number  value
1   1       2
  1   2       1
  1   3       4
  2   1       4
  2   2       3
  2   3       4"
)

tbl %>%
  group_by(number) %>%
  do(anova(lm(value ~ number, data = .)))

library(broom)
tbl %>%
  group_by(number) %>%
  do(tidy(anova(lm(value ~ number, data = .))))