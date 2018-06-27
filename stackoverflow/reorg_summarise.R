library(tidyverse)
foo <- read_table2(
  "Col1 Col2 Col3 Col4
1    6   10   60
2    7   20   70
3    8   30   80
4    9   40   90
5   10   50  10"
)

bar <- foo %>%
  summarise_at(
    .vars = vars(Col1, Col3),
    .funs = funs(mean, min)
  ) %>%
  gather(stat, value) %>%
  separate(stat, into = c("Col", "Func")) %>%
  spread(Col, value)
bar
