library(tidyverse)
tbl <- iris %>%
  select(-Species) %>%
  slice(1:26) %>%
  mutate(id = LETTERS) %>%
  `colnames<-`(c("col1", "col2", "col3", "col4", "id"))

tbl %>%
  mutate_at(vars(col2:col4), funs(abs(col1 - .))) %>%
  rename_at(vars(col2:col4), ~ str_c("col1_", .))
