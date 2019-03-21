library(tidyverse)
x <- list(
  p1 = list(type = "A", score = list(c1 = 10, c2 = 8, c3 = data.frame(a = 1, b = 3, c = 5))),
  p2 = list(
    type = "B", score = list(c1 = 9, c2 = 9, c3 = data.frame(a = 2, b = 2)),
    p3 = list(type = "B", score = list(c1 = 9, c2 = 7, c3 = data.frame(a = 2, b = 2)))
  )
)

remove_dataframes <- function(input_list) {
  current_list <- input_list
  current_depth <- vec_depth(current_list)
  # current_depth <- max_depth
  while (current_depth > 1) {
    current_list <- modify_depth(
      .x = current_list,
      .depth = current_depth,
      .f = ~ discard(., is.data.frame),
      .ragged = TRUE
    )
  current_depth <- current_depth - 1
  }
  return(current_list)
}

x %>%
  remove_dataframes %>%
  glimpse

vec_depth(x)

vec = 1:2
modify(vec, ~ . + 1L)
vec
