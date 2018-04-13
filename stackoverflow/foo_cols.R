library(tidyverse)
dt <- tibble(foo = c(c('a=a1|b=b1'),c('a=a2|b=b2|c=c2'),c('a=a3|d=d3')))
tibble(a=c('a1','a2','a3'),b=c('b1','b2',NA),c=c(NA,'c2',NA),d=c(NA,NA,'d3'))

dt %>%
  mutate(foo = str_split(foo, pattern = "\\|")) %>%
  rowid_to_column() %>%
  unnest() %>%
  separate(foo, into = c("col", "val"), sep = "=") %>%
  spread(col, val)
