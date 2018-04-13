library(tidyverse)
ts <- economics %>%
  mutate_at(vars(psavert, pce, unemploy), ~ `attributes<-`(scale(.), NULL)) %>%
  mutate_at(vars(psavert, pce, unemploy), ~ RcppRoll::roll_mean(., 5, fill = NA)) %>%
  select(date, psavert, pce, unemploy)

pts <- ts %>%
  mutate(diff = abs(pce - unemploy)) %>%
  arrange(diff)
head(pts, 3)

ggplot(ts %>% gather(type, value, psavert:unemploy)) +
  geom_line(aes(x = date, y = value, col = type)) +
  annotate("text", x = pts$date[2], y = pts$pce[2] - 0.1, label = "^")
