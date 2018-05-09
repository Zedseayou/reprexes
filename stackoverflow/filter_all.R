m <- matrix(1:25, ncol = 5)
m[c(1, 6, 13, 25)] <- NA
df <- data.frame(m)
library(dplyr)
df %>%
  filter_all(any_vars(is.na(.)))