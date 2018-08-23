library(tidyverse)
tbl <- structure(list(Year = c(2002L, 2002L, 2002L, 2002L, 2002L, 2002L, 2002L, 2002L, 2002L, 2003L, 2003L, 2003L, 2003L, 2003L, 2003L, 2003L, 2003L, 2003L), Category = c("A", "B", "C", "A", "B", "C", "A", "B", "C", "A", "B", "C", "A", "B", "C", "A", "B", "C"), Value = c(100L, 200L, 300L, 400L, 700L, 900L, 600L, 500L, 400L, 100L, 200L, 300L, 400L, 700L, 900L, 600L, 500L, 400L), Index = c(1L, 1L, 1L, 2L, 2L, 2L, 1L, 1L, 1L, 3L, 3L, 3L, 2L, 2L, 2L, 2L, 2L, 2L)), row.names = c(NA, -18L), class = c("tbl_df", "tbl", "data.frame"), spec = structure(list(cols = list(Year = structure(list(), class = c("collector_integer", "collector")), Category = structure(list(), class = c("collector_character", "collector")), Value = structure(list(), class = c("collector_integer", "collector")), Index = structure(list(), class = c("collector_integer", "collector"))), default = structure(list(), class = c("collector_guess", "collector"))), class = "col_spec"))

tbl %>%
  group_by(Year, Category, Index) %>%
  summarise(Value = sum(Value)) %>%
  arrange(Year, Index, Category)
