library(tidyverse)
df <- read_table2(
  "SID Var1 Var2
4    A    2
3    A    2
4    A    3
3    A    3
1    A    4
1    B    2
3    B    2
4    B    4
4    B    4
3    B    2
2    C    2
2    C    2
4    C    4
2    C    4
3    C    3
1    D    5
2    D    5"
)

df %>%
  group_by(Var2) %>%
  mutate(SID_per_Var2 = n_distinct(SID)) %>%
  group_by(Var1, Var2) %>%
  mutate(SID_per_Var1Var2 = n_distinct(SID)) %>%
  ungroup() %>%
  add_count(Var1) %>%
  add_count(Var1, Var2) %>%
  mutate(
    Count.Excluding.Var1 = if_else(
      n > nn,
      SID_per_Var2 - SID_per_Var1Var2 + 1,
      0
    )
  ) %>%
  select(SID, Var1, Var2, Count.Excluding.Var1)
