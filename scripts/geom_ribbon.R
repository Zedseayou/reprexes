library(tidyverse)
plot_data <- tbl %>%
  filter(p.value < 0.05)
ggplot(plot_data) +
  theme_bw() +
  geom_ribbon(aes(x = time, ymin = p.value, ymax = 0.05)) +
  scale_y_reverse()
