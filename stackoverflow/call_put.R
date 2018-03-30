library(tidyverse)
tbl <- read_table2(
  "Type  Name     Strike  Maturity    Nominal
  Call  Amazon    10     10/12/2018  1000
  Put   Amazon    10     10/12/2018  1000
  Call  Ebay      8      2/8/2018    800
  Put   Ebay      8      2/8/2018    500
  Call  Facebook  5      5/5/2018    900
  Call  Google    2      23/4/2018   250
  Put   Google    2      23/4/2018   350
  Call  Microsoft 2      19/3/2018   250
  Put   Microsoft 2.5    19/3/2018   350
  Put   Ebay      8      2/8/2018    100"
)

tbl %>%
  mutate(actual = ifelse(Type == "Call", Nominal, -Nominal)) %>%
  group_by(Name, Strike, Maturity) %>%
  summarise(Net = sum(actual)) %>%
  filter(Net != 0) %>%
  mutate(
    Type = ifelse(Net > 0, "Call", "Put"),
    Net = abs(Net)
    )
