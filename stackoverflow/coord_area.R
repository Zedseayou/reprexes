library(sf)

tbl <- readr::read_table2(
  "Point Latitude Longitude
  P1     24.53450    55.41547
  P2     24.52929    55.41913
  P3     24.52929    55.43241
  P4     24.54342    55.46566
  P5     24.55113    55.46241
  P6     24.55545    55.47364
  P7     24.56041    55.47109
  P8     24.55841    55.46529
  P9     24.55867    55.46521
  P10     24.54863    55.43838
  P11     24.54712    55.43917
  P12     24.54085    55.42715
  P13     24.54043    55.42712
  P1     24.53450    55.41547"
)

tbl[, c(3,2)] %>%
  as.matrix() %>%
  list() %>%
  st_polygon() %>%
  st_sfc() %>%
  st_set_crs(4326) %>%
  st_area()
