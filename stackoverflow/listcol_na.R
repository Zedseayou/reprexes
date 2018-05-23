library(tidyverse)
df <- tibble(x = c(1, 2, NA), y = c("a", NA, "b"), z = list(1:5, rep(NA,10), 10:20))

df1 <- df %>%
  replace_na(list(x = 0, y = "0")) %>%
  mutate(z = map(z, replace_na, 0))
df1$z
