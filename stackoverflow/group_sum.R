library(tidyverse)
df <- structure(list(Date = c("12/15/2016", "12/15/2016", "12/15/2016", "12/15/2016", "12/15/2016", "12/15/2016", "12/15/2016", "12/15/2016", "12/19/2016", "12/19/2016", "12/19/2016", "12/19/2016", "12/19/2016", "12/19/2016", "12/19/2016", "12/19/2016", "12/19/2016", "12/19/2016", "12/19/2016", "12/06/2016", "12/06/2016", "12/06/2016", "12/06/2016", "12/06/2016", "12/06/2016", "12/06/2016", "12/06/2016", "12/06/2016", "12/06/2016", "12/06/2016", "12/06/2016"), Amount = c(2300L, 2300L, 2300L, 2300L, 2300L, 2300L, 2300L, 2300L, 2300L, 2300L, 2300L, 2300L, 2300L, 2300L, 2300L, 2300L, 2300L, 2300L, 2300L, 2300L, 2300L, 2300L, 2300L, 2300L, 2300L, 2300L, 2300L, 2300L, 2300L, 2300L, 2300L)), row.names = c(NA, -31L), class = c("tbl_df", "tbl", "data.frame"), spec = structure(list(cols = list(Date = structure(list(), class = c("collector_character", "collector")), Amount = structure(list(), class = c("collector_integer", "collector"))), default = structure(list(), class = c("collector_guess", "collector"))), class = "col_spec"))

df %>%
  group_by(Date) %>%
  summarise(amount_sum = sum(Amount))
