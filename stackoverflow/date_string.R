library(stringr)
library(lubridate)
string <- "<13>1 2018-04-18T10:29:00.581243+10:00 KOI-QWE-HUJ vmon 2318 - -  Some Description..."
string %>%
  str_extract("\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}") %>%
  ymd_hms()
