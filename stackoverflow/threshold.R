library(tidyverse)
library(lubridate)
thresholds <- economics %>%
  mutate(
    pctile = ntile(unemploy, 100),
    year = year(date)
    ) %>%
  group_by(year) %>%
  summarise(
    q95 = sum(pctile >= 95L),
    q99 = sum(pctile >= 99L)
    )
arrange(thresholds, desc(q95))
