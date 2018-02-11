# https://stackoverflow.com/questions/48695398/r-data-table-add-column-as-function-of-another-data-table
library(tidyverse)
library(lubridate)
start_date <- ymd_hms(x = "2017-01-31 17:00:00") # lubridate parsers
end_date <- ymd_hms(x = "2017-02-01 09:00:00")

all_dates <- tibble(seq(start_date, end_date, "min")) # tibble swap for data.table

colnames(all_dates) <- c("Bin")

start_times <- sample(seq(start_date,end_date,"min"), 100)
offsets <- sample(seq(60,7200,60), 100)
end_times <- start_times + offsets
input_data <- tibble(
  start_times,
  end_times,
  intvl = interval(start_times, end_times) # Add interval column
  )

all_dates %>%
  mutate(BinCount = map_int(.$Bin, ~ sum(. %within% input_data$intvl)))
