library(tidyverse)
library(broom)
ds <- data.frame(
  income = rnorm(100, mean = 1000, sd = 200),
  happiness = rnorm(100, mean = 6, sd = 1),
  health = rnorm(100, mean = 20, sd = 3),
  sex = c(0, 1),
  faculty = c(0, 1, 2, 3)
)
ds %>%
  gather(dv_name, dv_value, income:health) %>%
  group_by(dv_name) %>%
  do(tidy(lm(dv_value ~ sex + faculty, data = .)))
