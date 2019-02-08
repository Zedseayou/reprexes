library(tidyverse)
tbl <- read_table2(
  "group variable               value
  1     fishers_here         100
1     money_per_fisher     2000
1     unnecessary_variable 10
2     fishers_here         140
2     money_per_fisher     8000
2     unnecessary_variable 304
3     fishers_here         10
3     money_per_fisher     9000"
)
tbl %>%
  spread(variable, value) %>%
  mutate(total_money_in_group = money_per_fisher * fishers_here) %>%
  gather(variable, value, -group)
