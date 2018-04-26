library(tidyverse)
library(arrangements)
set.seed(100)
tbl <- tibble(
  start = c("Berlin", "Munich", "Paris", "Barcelona"),
  end = c("Munich", "Paris", "Barcelona", "Rome"),
  val = rnorm(4)
) %>%
  slice(sample(1:nrow(.), nrow(.))) %>%
  rowid_to_column()
tbl

row_orders <- permutations(nrow(tbl)) %>%
  as_tibble() %>%
  unite(order, remove = FALSE) %>%
  nest(-order) %>%
  mutate(data = map(data, as.integer))

sample_orders <- row_orders
sample_tbl <- tbl

while (nrow(sample_orders) > 1) {
  keep_together <- sample_tbl %>%
    mutate(
      nrc = lead(start) == end,
      nrc = replace_na(nrc, FALSE),
      cumsum = cumsum(lag(nrc, default = FALSE) == FALSE)
      ) %>%
    group_by(cumsum) %>%
    summarise(row_groups = str_c(rowid, collapse = "_")) %>%
    filter(str_length(row_groups) > 1) %>%
    `[[`("row_groups")
  sample_orders <- sample_orders %>%
    filter(str_detect(order, keep_together))
  sample_tbl <- tbl %>%
    slice(sample_orders$data[[sample(1:nrow(sample_tbl), 1)]])
}
print(sample_tbl)
