avg <- c(24, 20, 29, 17, 22, 21)
sd <- c(5, 4, 5, 3, 3, 3.6)
sims <- 1000
df <- data.frame(avg, sd, sims)

library(tidyverse)
probs <- c(0.05, 0.5, 0.95)
probs <- seq(0.01, 0.99, 0.01)
quantile_tbl <- function(sims, avg, sd, probs) {
  rnorm(sims, avg, sd) %>%
    quantile(probs) %>%
    round(2) %>%
    enframe() %>%
    spread(name, value)
}
df %>%
  mutate(quantiles = pmap(select(., sims, avg, sd), ~quantile_tbl(..1, ..2, ..3, probs))) %>%
  unnest()
