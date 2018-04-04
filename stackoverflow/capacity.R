library(tidyverse)
df <- data.frame(year = c(2013, 2014, 2015, 2016),
                 number = c(100, 120, 125, 140),
                 capacity = c(125, 125, 150, 150))

ggplot(
  data = df %>%
    arrange(year) %>%
    add_row(year = max(.$year) + 1, capacity = last(.$capacity)),
  mapping = aes(x = year, y = number)
) +
  geom_col(width= 0.75) +
  geom_step(aes(y = capacity, x = year - 0.5), color = "red", size = 2)
