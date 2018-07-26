library(dplyr)
df <- data.frame(
  Check = c(1, 1, 2, 3, 4, 4, 5, 5, 5),
  Item = c("A", "B", "B", "A", "A", "C", "B", "A", "D")
)
df %>%
  group_by(Check) %>%
  summarise(a_and_b = all(c('A', 'B') %in% Item))
