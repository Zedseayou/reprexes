df <- structure(list(V1 = structure(c(10L, 4L, 7L, 5L, 3L, 1L, 8L, 11L, 12L, 9L, 2L, 6L), .Label = c("BRA_AC_A6IX", "BRA_BH_A18F", "BRA_BH_A18V", "BRA_BH_A1ES", "BRA_BH_A1FE", "BRA_BH_A6R8", "BRA_E2_A15A", "BRA_E2_A15K", "BRA_E2_A1B4", "BRA_EM_A15E", "BRA_LQ_A4E4", "BRA_OK_A5Q2"), class = "factor"), V2 = structure(c(2L, 3L, 5L, 3L, 3L, 5L, 3L, 4L, 1L, 4L, 2L, 2L), .Label = c("Level ii", "Level iia", "Level iib", "Level iiia", "Level iiic"), class = "factor"), V3 = structure(c(1L, 1L, 1L, 2L, 2L, 2L, 3L, 3L, 3L, 3L, 3L, 4L), .Label = c("amira", "boro", "car", "dim"), class = "factor")), class = "data.frame", row.names = c(NA, -12L))

library(tidyverse)
df %>%
  select(-V1) %>%
  count(V2, V3) %>%
  spread(V3, n, fill = 0L)
