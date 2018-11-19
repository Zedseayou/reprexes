library(tidyverse)
data <- tribble(
  ~Date,      ~Seq1, ~Component, ~Seq2,  ~X1,  ~X2,   ~X3,
  "01/01/18", 1,     "Smooth",   NA,     3.98,  2.75,  1.82,
  "01/01/18", 2,     "Smooth",   NA,     1.02,  0.02, -0.04,
  "01/01/18", 3,     "Smooth",   NA,     3.48,  3.06,  1.25,
  "01/01/18", 3,     "Bounce",   1,      2.01, -0.43, -0.52,
  "01/01/18", 3,     "Bounce",   2,      1.94,  1.53,  1.92)

smooths <- data %>%
  filter(Component == "Smooth") %>%
  gather(X, val, starts_with("X"))

bounces <- data %>%
  filter(Component == "Bounce") %>%
  gather(X, val, starts_with("X")) %>%
  left_join(smooths, by = c("Date", "Seq1", "X")) %>%
  mutate(val = val.x + val.y) %>%
  select(Date, Seq1, Component = Component.x, Seq2 = Seq2.x, X, val)

bounces %>%
  bind_rows(smooths) %>%
  spread(X, val)
