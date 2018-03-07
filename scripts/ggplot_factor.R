library(tidyverse)
HPF <- bind_rows(region, region2) %>%
  mutate(region = factor(region))

ggplot(data = HPF) +
  geom_line(aes(x=date, y= BaseCumulative, colour = region), na.rm = FALSE) +
  theme_light()
