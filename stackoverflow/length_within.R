dates<-data.frame(start=as.POSIXct(c("2010-04-03 03:02:38 UTC","2010-04-03 06:03:14 UTC","2010-04-20 03:05:52 UTC","2010-04-20 03:17:42 UTC","2010-04-21 03:09:38 UTC","2010-04-21 07:10:14 UTC","2010-04-21 08:12:52 UTC","2010-04-23 03:13:42 UTC","2010-04-23 03:25:42 UTC","2010-04-23 03:36:38 UTC","2010-04-23 08:58:14 UTC","2010-04-24 03:21:52 UTC","2010-04-24 03:22:42 UTC","2010-04-24 07:24:19 UTC","2010-04-24 07:55:19 UTC")),length=c(3600,300,900,3600,300,900,3600,300,900,3600,300,900,3600,300,900))

library(dplyr)
library(lubridate)

length_within <- function(tbl, interval_start, interval_end){
  intv_start = as.POSIXct(interval_start)
  intv_end = as.POSIXct(interval_end)
  tbl %>%
    mutate(
      end = start + length,
      counted_start = ifelse(start < intv_start, intv_start, start),
      counted_end = ifelse(end > intv_end, intv_end, end),
      seconds = counted_end - counted_start
    ) %>%
    filter(seconds >= 0) %>%
    summarise(total = sum(seconds)) %>%
    `[[` (1)
}

length_within(dates,"2010-04-02 00:00:00", "2010-04-21 09:00:00")
length_within(dates,"2010-04-23 03:15:00", "2010-04-24 08:00:00")
