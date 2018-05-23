library(tidyverse)
set.seed(4321)
df <- matrix(rnorm(1000000), ncol = 1000) %>%
  as_tibble()

microbenchmark::microbenchmark(
  base = df[, 1001:1500] <- df[, 1:500] - df[, 501:1000],
  base2 = df %>% magrittr::inset(, 1001:1500, .[, 1:500] - .[, 501:1000]),
  map =  df %>% bind_cols(map2(.x = .[, 1:500], .y = .[, 501:1000], .f = ~.x - .y)),
  nomap = df %>% bind_cols(.[, 1:500] - .[, 501:1000]),
  do = df %>% do(.[, 1:500] - .[, 501:1000])
)
