library(tidyverse)
tbl <- read_table2(
  "In1   In2    In3     In4
0
0     0
0.125 0.125 0
0     0     0.125   0"
)

vec <- c(0.125, 0.25, 0.625, 0.25)

tbl %>%
  map_dfc(~ . / vec) %>%
  as.matrix() %>%
  `rownames<-`(colnames(.))
