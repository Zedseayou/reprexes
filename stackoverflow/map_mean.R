library(tidyverse)
set.seed(12345)
testlist <- list(
  list(mu = rnorm(15), rooti = rnorm(15)),
  list(mu = rnorm(15), rooti = rnorm(15)),
  list(mu = rnorm(15), rooti = rnorm(15)),
  list(mu = rnorm(15), rooti = rnorm(15)),
  list(mu = rnorm(15), rooti = rnorm(15))
)
str(testlist[1:2])

testlist %>%
  imap_dfr(.f = ~ tibble(index = .y, mu_mean = mean(.x$mu, na.rm = TRUE)))
