library(tidyverse)
my_list_of_lists <- list(
  c(147, 313, 337, 546),
  c(35, 135, 281, 283, 325, 326, 357),
  c(311, 334, 403, 427, 436, 507, 520, 566, 595, 632)
)

number_to_select <- c(1, 1, 2)

selected_vals <- map2(
  .x = my_list_of_lists,
  .y = number_to_select,
  .f = function(x,y) base::sample(x, y)
  )
print(selected_vals)
