library(tidyverse)
ggplot(iris, aes(x = Petal.Length, y = Petal.Width)) +
  theme_classic() +
  geom_point(
    mapping = aes(colour = Species),
    shape = 1,
    size = 3,
    stroke = 2,
    alpha = 5 / 6
    ) +
  geom_point(
    mapping = aes(fill = Sepal.Length, colour = NA),
    size = 2.88,
    alpha = 5 /6,
    shape = 21
  ) +
  scale_fill_gradient(low = "blue", high = "yellow")

library(viridis)
ggplot(iris, aes(x = Petal.Length, y = Petal.Width)) +
  theme_classic() +
  geom_point(
    mapping = aes(colour = Sepal.Length, shape = Species),
    size = 3,
    alpha = 5 / 6
  ) +
  scale_colour_viridis()
