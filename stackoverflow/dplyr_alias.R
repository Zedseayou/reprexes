library(tidyverse)
alias = quo(cust)
alias2 = quo(class)

df <- data_frame(cust = c("A", "B", "A", "C", "B"), class = c(1, 2, 3, 4, 7))
df %>%
  group_by(!!alias) %>%
  summarise(test = max(!!alias2))

max_summary <- function(df, group_col, max_col) {
  alias <- enquo(group_col)
  alias2 <- enquo(max_col)
  df %>%
    group_by(!!alias) %>%
    summarise(test = max(!!alias2))
}
max_summary(df, cust, class)
