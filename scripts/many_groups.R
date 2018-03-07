library(tidyverse)
tbl <- read_table2(
  "Age      Gender  CarType     Group   Education
  46        Male      Sedan     1        BS
  37        Male      SUV       1        MS
  47      Female      Sedan     2        PhD
  20        Male      SUV       2        HS
  41        Male      SUV       1        MS
  52        Male      Sedan     2        MS"
)

tbl %>%
  add_count(Group, Gender) %>%
  add_count(Group, CarType) %>%
  add_count(Group, Education) %>%
  group_by(Group, Gender) %>%
  mutate(., mAge = mean(Age)) %>%
  mutate(Gender2 = str_c("mean_age_", Gender)) %>%
  spread(Gender, n) %>%
  spread(Gender2, mAge) %>%
  spread(CarType, nn) %>%
  spread(Education, nnn) %>%
  group_by(Group) %>%
  summarise_at(vars(-Age), function(x) median(x, na.rm = TRUE)) %>%
  mutate_at(vars(-starts_with("mean_age_")), function(x) replace_na(x, 0))
