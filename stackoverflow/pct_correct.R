library(tidyverse)
tbl <- tibble(
  id = c(1, 1, 1, 1, 1, 2, 2),
  pressed = c("78", "78", "78", "83", "83", "78", "78"),
  correct = c("different", "different", "different", "same", "same", "different", "same")
)

tbl %>%
  mutate(correct = recode(correct, same = "78", different = "83")) %>%
  group_by(id) %>%
  summarise(pct_correct = mean(pressed == correct) * 100)
