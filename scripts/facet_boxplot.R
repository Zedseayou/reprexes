tbl <- read_table2(
  "pp crossingtype  km  type ID
  0     Complete  80.0  DCC  10
  1     Complete  80.0  DCC   4
  0  Exploration  80.0  DCC  49
  1  Exploration  80.0  DCC   4
  0     Complete 144.0  DWC 235
  1     Complete 144.0  DWC  22
  0  Exploration 144.0  DWC 238
  1  Exploration 144.0  DWC  18
  1  Exploration  84.0   PC  40
  0     Complete 107.0   PC  43
  1     Complete 107.0   PC  22
  0  Exploration 107.0   PC 389"
)

tbl <- read_table2("C:/Users/Calum You/Downloads/figshare.txt") %>%
  mutate(pp = factor(pp))

ggplot(data = tbl %>% filter(crossingtype == '"Exploration"')) +
  geom_boxplot(aes(x = pp, y = ID)) +
  facet_wrap(~type)
