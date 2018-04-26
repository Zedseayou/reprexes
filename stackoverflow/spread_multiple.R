library(tidyverse)
tbl <- read_table2(
  "Yr    Geo     Obs1  Obs2
  2001  Dist1    1     3
  2002  Dist1    2     5
  2003  Dist1    4     2
  2004  Dist1    2     1
  2001  Dist2    1     3
  2002  Dist2   .9     5
  2003  Dist2    6     8
  2004  Dist2    2    .2"
)

tbl %>%
  gather("obsnum", "obs", Obs1, Obs2) %>%
  unite(colname, Geo, obsnum, sep = "") %>%
  spread(colname, obs) %>%
  `colnames<-`(str_to_lower(colnames(.)))
