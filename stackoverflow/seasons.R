library(tidyverse)
library(lubridate)
data <- tibble(month = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))

data %>%
  mutate(
    season = fct_collapse(
      .f = month,
      Spring = c("Mar", "Apr", "May"),
      Summer = c("Jun", "Jul", "Aug"),
      Autumn = c("Sep", "Oct", "Nov"),
      Winter = c("Dec", "Jan", "Feb")
    )
  )
