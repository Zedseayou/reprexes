library(stringr)
addresses <- c("14615 SE CREEKSIDE DRIVE", "14615 NW CREEKSIDE DRIVE", "14615 SE SEASIDE DRIVE", "14615 SE TANWELL DRIVE")

addresses %>%
  str_to_title %>%
  str_replace(" (N|S)(e) ", " \\1E ") %>%
  str_replace(" (N|S)(w) ", " \\1W ")
