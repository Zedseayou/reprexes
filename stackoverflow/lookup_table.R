item1 <- c(NA, 1, NA, 4)
item2 <- c(NA, 2, NA, 3)
item3 <- c(NA, 3, NA, NA)
item57 <- c(NA, 4, 4, 1)

mydata <- data.frame(item1, item2, item3, item57)

#Lookup values based on item score
lookup <- data.frame(score = 1:4, value=c(6, 7, 8, 10))

library(tidyverse)
mydata %>%
  rowid_to_column(var = "participant") %>%
  gather(items, score, starts_with("item")) %>%
  left_join(lookup) %>%
  gather(coltype, val, score:value) %>%
  unite(colname, coltype, items) %>%
  spread(colname, val)
