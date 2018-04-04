library(tidyverse)
library(sf)
mls <- st_sfc(st_multilinestring(list(
  matrix(runif(n = 10), ncol = 2),
  matrix(runif(n = 10, min = 1, max = 2), ncol = 2)
  )))
mls

st_cast(mls, "LINESTRING")
