library(tidyverse)
dates <- tibble(date = c('2017-12-17', '2017-12-28', '2018-01-03', '2018-01-19'))

wk_start <- function(date){
  wk_st <- date
  wday(wk_st, week_start = 1) <- 1
  return(wk_st)
}

dates %>%
  mutate(date = ymd(date)) %>%
  mutate(year = year(date),
         week = week(date)
         ) %>%
  mutate(start_of_wk = wk_start(date))

dates %>%
  mutate(c_year = year(date),
         c_week = week(date),
         s_create_wk = as.Date(str_c(c_year, c_week, "1", sep = "-"), "%Y-%W-%u")
         )
