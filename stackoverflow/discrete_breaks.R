library(ggplot2)
library(ggthemes)

data <- data.frame(x = rep(seq(0, 500), 100), y = runif(501 * 10, -1, 1))

ggplot(data) +
  geom_tufteboxplot(aes(x = factor(x), y = y)) +
  scale_x_discrete(breaks = seq(0, 500, by = 25))
