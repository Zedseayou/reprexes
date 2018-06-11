library(tidyverse)
set.seed(9876)
eg <- tibble(
  year = rep(2001:2010, each = 100),
  id = rep(1:100, times = 10),
  SAT1_var1 = rnorm(1000),
  SAT1_var2 = rnorm(1000),
  SAT1_var3 = rnorm(1000),
  SAT2_var1 = rnorm(1000),
  SAT2_var2 = rnorm(1000),
  SAT2_var3 = rnorm(1000),
  SAT3_var1 = rnorm(1000),
  SAT3_var2 = rnorm(1000),
  SAT3_var3 = rnorm(1000)
)
eg

eg %>%
  gather(key = "measurement", value = "value", -year, -id) %>%
  separate(measurement, into = c("source", "variable"), sep = "_") %>%
  spread(variable, value)
