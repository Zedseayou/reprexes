library(tidyverse)
library(lubridate)
tbl <- read_table2(
  "country date1 date2
  1    03/01/2012    05/01/2012
  2    05/04/2012    12/10/2012
  3    07/12/2012    20/03/2012
  4    04/02/2012    24/12/2012"
)

tbl %>%
  gather(event, date, date1:date2) %>%
  mutate(date = dmy(date)) %>%
  complete(country, date = seq.Date(min(date), max(date), 1)) %>%
  mutate(
    event = str_remove_all(event, "date"),
    has_event = ifelse(is.na(event), 0, 1)
    ) %>%
  spread(event, has_event, sep = "") %>%
  mutate_at(vars(event1:event2), replace_na, 0) %>%
  mutate(
    year = year(date),
    month = month(date),
    day = day(date)
  ) %>%
  select(country, year:day, event1:event2)
