library(tidyverse)
tbl <- structure(list(ColumnA = c("A1", "A2", "B1", "B2", "B3", "B4", "C1", "C2", "C3"), ColumnB = c(10L, 10L, 3L, 3L, 3L, 3L, 6L, 6L, 6L), ColumnC = c("A2", "A1", "B2,B3,B4", "B1,B3,B4", "B1,B2,B4", "B1,B2,B3", "C2,C3", "C1,C3", "C1,C2")), problems = structure(list(row = 9L, col = "ColumnC", expected = "", actual = "embedded null", file = "literal data"), row.names = c(NA, -1L), class = c("tbl_df", "tbl", "data.frame")), row.names = c(NA, -9L), class = c("tbl_df", "tbl", "data.frame"), spec = structure(list(cols = list(ColumnA = structure(list(), class = c("collector_character", "collector")), ColumnB = structure(list(), class = c("collector_integer", "collector")), ColumnC = structure(list(), class = c("collector_character", "collector"))), default = structure(list(), class = c("collector_guess", "collector"))), class = "col_spec"))

tbl %>%
  left_join(
    tbl %>% select(-ColumnC) %>% nest(ColumnA)
  ) %>%
  mutate(
    data = flatten(data),
    output = map2(data, ColumnA, ~ setdiff(.x, .y)),
    output = map_chr(output, ~ str_c(., collapse = ","))
    )
