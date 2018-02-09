library(tidyverse)
x <- as.tibble(cbind(
    Grace_neu_wrong = c(1:4),
    Grace_acc_wrong = c(1:4),
    Grace_att_wrong = c(1:4),
    Grace_int_wrong = c(1:4)
  ))

names(x) <- str_replace(names(x), "(.*)_(.*)_(.*)", "\\2\\3_\\1")
x
