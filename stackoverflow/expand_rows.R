library(tidyverse)
tbl <- read_table2(
"  ID Time           Item
 S001   P1           1/2/
 S002   P1       2/10/7/9
 S003   P1 1/2/4/5/6/10/9
 S004   P1 1/2/5/6/10/7/9
 S005   P1     1/2/10/7/9
 S006   P1      2/5/6/7/9"
)

tbl %>% mutate(
  Item1 = as.integer(str_detect(Item, "(?<=/)1(?=/)"))
)

tbl %>%
  separate_rows(Item, sep = "/") %>%
  filter(Item != "") %>%
  mutate(present = 1) %>%
  spread(Item, present, sep = "") %>%
  mutate_all(function(x) replace(x, is.na(x), 0))
