mat <- matrix(
 c(T, F, F, T, F, T, T, T, F, F, T, F, F, T, T, T, T, T, F, F, T, F, F, T, F),
 ncol = 5,
 byrow = TRUE,
 dimnames = list(NULL, LETTERS[1:5])
)

library(dplyr)
mat %>%
  as_tibble %>%
  group_by_all %>%
  tally %>%
  ungroup


x <- function(arg1, arg2){
  list(args(x))
}
args(x)
