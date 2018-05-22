library(tidyverse)
library(lubridate)
tibble(datetime = "1-Feb-05 12:00:00 AM") %>%
  mutate(
    datetime = dmy_hms(datetime),
    year = year(datetime),
    month = month(datetime)
    )


