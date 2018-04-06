library(tidyverse)
library(lubridate)
tbl <- tibble(
  ID1 = rep(1:1000, each= 5*365),
  year = rep(rep(2000:2004, each = 365), times = 1000),
  day = rep(1:365, times = 1000*5),
  x= runif(365*1000*5)
)

tictoc::tic("")
doys <- tibble(
  day = rep(1:365),
  date = seq.Date(ymd("2001-1-1"), ymd("2001-12-31"), by = 1),
  month = month(date),
  biweek = case_when(
    mday(date) <= 15 ~ (month * 2) - 1,
    mday(date) > 15  ~ month * 2
  )
)
tbl_out2 <- left_join(tbl, select(doys, -date), by = "day")
tictoc::toc()
tbl_out2
tbl_out2[55:65, ]
