library(tidyverse)
library(lubridate)
df <- structure(list(hour = structure(c(1533546000, 1533549600, 1533553200, 1533556800, 1533560400, 1533564000, 1533567600, 1533571200, 1533574800), class = c("POSIXct", "POSIXt"), tzone = "Europe/London"), associate_count = c(2L, 2L, 2L, 1L, 2L, 2L, 2L, 1L, 1L), minutes_covered = c(37, 60, 42, 56, 60, 60, 60, 52, 0)), row.names = c(NA, -9L), class = c("tbl_df", "tbl", "data.frame"))

my_complete <- function(df, start_date, end_date){
  start_hour <- str_c(start_date, " 00:00:00") %>% ymd_hms
  end_hour <- str_c(end_date, " 00:00:00") %>% ymd_hms
  df %>%
    complete(
      hour = seq(from = start_hour, to = end_hour, by = "hour"),
      fill = list(associate_count = 0L, minutes_covered = 0)
    )
}
my_complete(df, "2018-08-06", "2018-08-07")
