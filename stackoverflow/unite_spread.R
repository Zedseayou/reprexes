SurvDate <- as.Date(c('2018-11-1','2018-11-1','2018-11-1', '2018-11-3', '2018- 
11-3'))
Area <- c('AF','BB','CT', 'DF', 'BB')
People <- c(6, 3, 0, 12, 32)
ObsTime <- (c('8:51','8:59','9:13', '9:24', '9:30'))
p <- data.frame(SurvDate, Area, People, ObsTime, stringsAsFactors = FALSE)

library(tidyverse)
p %>%
  unite(vals, People, ObsTime) %>%
  spread(Area, vals) %>%
  mutate_at(
    .vars = vars(-SurvDate),
    .funs = funs(
      Time = str_extract(., "(?<=_).*$"),
      Area = str_extract(., "^.*(?=_)")
      )
  ) %>%
  filter(!is.na(SurvDate)) %>%
  select(SurvDate,  matches("_")) %>%
  select(SurvDate, order(colnames(.)))