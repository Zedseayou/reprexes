library(tidyverse)
df <- airquality %>%
  as_tibble() %>%
  magrittr::set_colnames(str_to_lower(colnames(.))) %>%
  mutate(date = as.Date(str_c("1973-", month, "-", day)))

ggplot(df) +
  geom_line(aes(x = date, y = temp)) +
  geom_ribbon(
    data = filter(df, date < as.Date("1973-07-01") & date > as.Date("1973-06-01")),
    mapping = aes(x = date, ymax = temp, ymin = 55)
    )

