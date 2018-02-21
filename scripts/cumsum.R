library(tidyverse)
df <- read_table2(
  "sep-2016  oct-2016    nov-2016  dec-2016   jan-2017
  70        153            NA        28        19
  57         68            73       118        16
  29         NA            19        32        36
 177         36             3        54        53"
)

df %>%
  rowid_to_column() %>%
  gather("month", "value", -rowid) %>%
  arrange(rowid) %>%
  group_by(rowid) %>%
  mutate(
    value = replace_na(value, 0),
    status = cumsum(value)
    ) %>%
  gather("vartype", "number", value, status) %>%
  mutate(colname = ifelse(vartype == "value", month, str_c("status-", month))) %>%
  select(rowid, number, colname) %>%
  spread(colname, number)
