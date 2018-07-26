library(tidyverse)
mpg2 <- arrange(mpg, desc(manufacturer))

ggplot(mpg2) +
  geom_point(aes(x = cty, y = hwy, colour = manufacturer))

ggplot(mpg2) +
  geom_point(
    mapping = aes(
      x = cty,
      y = hwy,
      colour = factor(manufacturer, levels = unique(manufacturer))
    )
  )
