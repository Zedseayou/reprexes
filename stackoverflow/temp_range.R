library(tidyverse)

set.seed(2346)
dat <- data.frame(
  index = rep(c("dex111", "dex112", "dex113", "dex114", "dex115"), each = 30),
  year = 1980:2009,
  region = rep(c("Berlin", "Stuttgart", "Böblingen", "Wartburgkreis", "Eisenach"), each = 30),
  ln_gdp_percapita = sample.int(40, 150, replace = TRUE),
  ln_gva_agr_perworker = sample.int(45, 150, replace = TRUE),
  temperature = sample.int(50, 150, replace = TRUE),
  recipitation = sample.int(60, 150, replace = TRUE)
)

stats <- dat %>%
  group_by(region) %>%
  summarise(
    ln_gdp = mean(ln_gdp_percapita),
    range_max = max(temperature),
    range_min = min(temperature),
    decade_80s = mean(temperature[which(year %in% 1980:1989)]),
    decade_00s = mean(temperature[which(year %in% 2000:2009)])
  ) %>%
  gather(decade, mean, decade_80s, decade_00s)

ggplot(stats, aes(x = ln_gdp)) +
  geom_point(aes(y = mean, colour = decade)) +
  geom_linerange(aes(ymin = range_min, ymax = range_max)) +
  ggrepel::geom_text_repel(
    data = . %>% filter(decade == "decade_00s"),
    mapping = aes(y = mean, label = region)
    )
