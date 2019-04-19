library(tidyverse)
text <- c("df ggh a a h h a  qq",
          "       aa  hh  ab qt",
          " fggh   aa hh  a    ")
read_fwf(text, fwf_empty(text))

locations <- text %>%
  str_locate_all("\\s") %>%
  map(~.[, 1]) %>%
  reduce(intersect)

widths <- c(1, locations, str_length(text[1])) %>% diff()

read_fwf(text, fwf_widths(widths))
