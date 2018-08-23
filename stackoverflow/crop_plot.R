library(tidyverse)
library(lubridate)
cal <- tribble(
  ~sport,   ~reg,          ~year_end,    ~year_begin, ~reg_end,       ~pst_end,
  "nfl",    "2017-09-07",  "2017-12-31", "2017-01-01" ,"2017-01-01",   "2017-02-05",
  "nba",    "2017-10-18",  "2017-12-31", "2017-01-01" ,"2017-04-13",   "2017-06-19",
  "mlb",    "2017-04-02",  "2017-10-04", "2017-10-04" ,"2017-10-04",   "2017-11-02",
  # don't want to designate a pst season for ncaa_fb.
  "ncaa_fb","2017-08-26",  "2017-12-31", "2017-01-01" ,"2017-01-10",   "2017-01-10",
)
cal
cal <- tribble(
  ~sport,   ~reg_begin,   ~reg_end,     ~pst_begin,   ~pst_end,
  "nfl",    "2016-09-07", "2017-01-01", "2017-01-01", "2017-02-05",
  "nba",    "2016-10-18", "2017-04-13", "2017-04-13", "2017-06-19",
  "mlb",    "2017-04-02", "2017-10-04", "2017-10-04", "2017-11-02",
  "ncaa_fb","2016-08-26", "2017-01-10", NA,            NA,
)
cal_plot <- cal %>%
  gather(colname, date, -sport) %>%
  separate(colname, c("season", "begin_end"), sep = "_") %>%
  mutate(date = ymd(date)) %>%
  spread(begin_end, date) %>%
  mutate(
    interval = interval(begin, end),
    crosses = ymd("2017-01-01") %within% interval,
    begin = map2(
      .x = begin, .y = crosses
      .p = ~ .x
    )
    # end = map2(end, interval, ~if_else(
    #   ymd("2016-12-31") %within% .y, c(ymd("2016-12-31"), .x), .x
    # ))
  )
cal_plot
  mutate(
    date2 = case_when(
      year(date) == 2016 & begin_end == "begin",
    )


  )
begin_wrap = if_else(year(begin) == 2016, ymd("2017-01-01"), as.Date(NA)),
end_wrap = if_else(year(begin) == 2016, )
cal_plot

ggplot(cal_plot, aes(x = sport)) +
  geom_linerange(aes(ymin = begin, ymax = end, colour = season), size = 5) +
  scale_colour_manual(values = c("#ED3752", "#324D5C")) +
  theme_bw()
