library(tidyverse)
tbl <- read_table2(
  "pollutant air_quality_idx    air_quality_cat air_quality_cat_idx
  PM2.5,PM10,OZONE         28,6,24     Good,Good,Good               1,1,1
  PM2.5,PM10,OZONE         28,5,25     Good,Good,Good               1,1,1
  OZONE,PM2.5,PM10         26,23,4     Good,Good,Good               1,1,1
  OZONE,PM2.5,PM10         26,23,3     Good,Good,Good               1,1,1
  OZONE,PM2.5,PM10         27,22,3     Good,Good,Good               1,1,1
  OZONE,PM2.5,PM10         27,24,2     Good,Good,Good               1,1,1
  PM2.5,PM10,OZONE         50,4,27     Good,Good,Good               1,1,1
  PM2.5,PM10,OZONE         54,4,22 Moderate,Good,Good               2,1,1
  PM2.5,PM10,OZONE         56,5,22 Moderate,Good,Good               2,1,1
  PM2.5,PM10,OZONE         60,5,28 Moderate,Good,Good               2,1,1",
  col_types = "cccc"
)

separated <- tbl %>%
  separate(pollutant, c("pol1", "pol2", "pol3"), sep = ",") %>%
  separate(air_quality_idx, c("aqi1", "aqi2", "aqi3"), sep = ",") %>%
  separate(air_quality_cat, c("aqc1", "aqc2", "aqc3"), sep = ",") %>%
  separate(air_quality_cat_idx, c("aci1", "aci2", "aci3"), sep = ",")

output <- bind_rows(
  separated %>%
    select(ends_with("1")) %>%
    set_names(c("pol", "aqi", "aqc", "aci")),
  separated %>%
    select(ends_with("2")) %>%
    set_names(c("pol", "aqi", "aqc", "aci")),
  separated %>%
    select(ends_with("3")) %>%
    set_names(c("pol", "aqi", "aqc", "aci"))
)
