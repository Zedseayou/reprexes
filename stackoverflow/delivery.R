library(tidyverse)
tbl <- tibble(
  soldto = c("123456","122456","123456","122456","124560","125560"),
  shipto = c("123456","122555","122456","124560","122560","122456"),
  issuedate = as.Date(c("2017-01-01","2017-01-02","2017-01-01","2017-01-02","2017-01-01","2017-01-01")),
  method = c("Ground","Ground","Ground","Air","Ground","Ground"),
  delivery = c("000123","000456","000123","000345","000456","000555")
)

tbl %>%
  group_by(soldto, shipto, method) %>%
  summarise(uniques = n_distinct(delivery))
