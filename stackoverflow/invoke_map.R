library(tidyverse)
f1 <- function(a, b, c) {a + b^c}
f2 <- function(x) {x * 2}
f3 <- function(y, z) {y * z}
p1 <- data_frame(
  a = c(2, 4, 5, 7, 8),
  b = c(1, 1, 2, 2, 2),
  c = c(.5, 5, 1, 2, 3)
)
p2 <- data_frame(x = c(1, 4))
p3 <- data_frame(
  y = c(2, 2, 2, 3),
  z = c(5, 4, 3, 2)
)
df <- data_frame(
  fun_id = c("f1", "f2", "f3"),
  params = list(p1, p2, p3),
  funs = list(f1, f2, f3)
)

df2 <- df %>%
  mutate(results = invoke_map(funs, params))
df2
df2$results
