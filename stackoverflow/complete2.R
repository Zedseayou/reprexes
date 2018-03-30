dd <- read.table(text="
164.91 0
                 164.96 32
                 165.01 0
                 165.11 0
                 165.16 4
                 166.16 0")

library(tidyr)
dd %>%
  complete(
    V1 = seq(min(V1), max(V1), by = 0.01),
    fill = list(V2 = 0)) %>%
  as.data.frame()
