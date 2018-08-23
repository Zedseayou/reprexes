library(tidyverse)
lookup <- tibble(
    emp_id = c("001", "002", "003", "004", "005"),
    mgr_id = c("002", "004", "004", "005", NA)
  )

input <- lookup %>%
  select(emp_id) %>%
  mutate(command_chain = emp_id, current_join = emp_id)

join_once <- function(df) {
  df %>%
    left_join(lookup, by = c("current_join" = "emp_id")) %>%
    mutate(
      command_chain = map2(command_chain, mgr_id, ~ c(.x, .y)),
      current_join = mgr_id
    ) %>%
    select(-mgr_id)
}

join_all <- function(df) {
  output <- df
  while (!all(is.na(output$current_join))) {
    output <- join_once(output)
  }
  return(output)
}

output <- join_all(input)
output %>%
  mutate(
    command_chain = map(command_chain, ~ discard(.x, is.na)),
    cc_as_string = map_chr(command_chain, ~ str_c(.x, collapse = ","))
    ) %>%
  select(-current_join)
