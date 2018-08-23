EverybodyScores <- array(
  runif(2 * 3 * 5),
  dim = c(2, 3, 5),
  dimnames = list(Month = month.name[1:2], Class = LETTERS[1:3], StudentID = 1:5)
)
library(tidyverse)
EverybodyScores %>%
  as.tbl_cube(met_name = "Score") %>%
  as_tibble

EverybodyScores %>% dimnames

EverybodyScores %>%
  array_tree %>%
  set_names(dimnames(EverybodyScores)[[1]]) %>%
  modify_depth(1, ~ set_names(., dimnames(EverybodyScores)[[2]])) %>%
  modify_depth(2, ~ set_names(., dimnames(EverybodyScores)[[3]])) %>%
  as_tibble %>%
  str
