library(tidyverse)
tbl <- structure(list(condition = c(5L, 0L, 3L, 8L, 3L, 8L, 3L, 5L, 5L, 5L, 0L, 3L, 0L, 8L, 3L, 3L, 5L, 3L, 0L, 0L), movedur = c(0.935, 1.635, 0.905, 0.875, 1.06, 1.11, 1.83, 1.06, 1.385, 1.56, 1.335, 0.88, 1.03, 1.3, 1.23, 1.21, 1.71, 1, 1.365, 1)), row.names = c(NA, -20L), class = c("tbl_df", "tbl", "data.frame"), spec = structure(list(cols = list(condition = structure(list(), class = c("collector_integer", "collector")), movedur = structure(list(), class = c("collector_double", "collector"))), default = structure(list(), class = c("collector_guess", "collector"))), class = "col_spec"))

tbl %>%
  complete(condition = 0:8) %>%
  ggplot() +
  geom_violin(aes(x = condition, y = movedur, fill = factor(condition)))



