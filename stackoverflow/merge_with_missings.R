library(tidyverse)
df1 <- structure(list(ID = 1:5, hello = c(NA, NA, 10L, 4L, NA), world = c(NA, NA, 8L, 17L, NA), hockey = c(7L, 2L, 8L, 5L, 3L), soccer = c(4L, 5L, 23L, 12L, 43L)), row.names = c(NA, -5L), class = c("tbl_df", "tbl", "data.frame"), spec = structure(list(cols = list(ID = structure(list(), class = c("collector_integer", "collector")), hello = structure(list(), class = c("collector_integer", "collector")), world = structure(list(), class = c("collector_integer", "collector")), hockey = structure(list(), class = c("collector_integer", "collector")), soccer = structure(list(), class = c("collector_integer", "collector"))), default = structure(list(), class = c("collector_guess", "collector"))), class = "col_spec"))
df2 <- structure(list(ID = 1:5, hello = c(2L, 5L, NA, NA, 9L), world = c(3L, 1L, NA, NA, 7L), football = c(43L, 24L, 2L, 5L, 12L), baseball = c(6L, 32L, 23L, 15L, 2L)), row.names = c(NA, -5L), class = c("tbl_df", "tbl", "data.frame"), spec = structure(list(cols = list(ID = structure(list(), class = c("collector_integer", "collector")), hello = structure(list(), class = c("collector_integer", "collector")), world = structure(list(), class = c("collector_integer", "collector")), football = structure(list(), class = c("collector_integer", "collector")), baseball = structure(list(), class = c("collector_integer", "collector"))), default = structure(list(), class = c("collector_guess", "collector"))), class = "col_spec"))

df1 %>%
  bind_rows(df2) %>%
  gather(variable, value, -ID, na.rm = TRUE) %>%
  spread(variable, value)
