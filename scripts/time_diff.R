library(tidyverse)
library(lubridate)
tbl <- read_table2(
  "sq_id trialnumber trialdate trialtime
22640  2          07/13/17   8:45
22640  1          06/11/17  11:24
22641  1          06/12/17   9:37
22653  1          06/20/17  11:50
22658  2          07/13/17   9:20
22658  1          06/14/17  10:12"
)

tbl %>%
  mutate(date_time = mdy_hms(str_c(trialdate, trialtime))) %>%
  select(sq_id, trialnumber, date_time) %>%
  spread(trialnumber, date_time, sep = "_") %>%
  mutate(time_gap = trialnumber_2 - trialnumber_1) %>%
  select(sq_id, time_gap)
