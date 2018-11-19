library(tidyverse)

df <- tibble::tribble(
  ~name, ~life_expectancy,          ~poverty, ~household_income,
  "New Haven", 78.0580437642378, 0.264221051111753,  42588.7592521085,
  "New York", 12.349685329, 0.324067934, 32156.230974623
)

rounded <- df %>%
  select(life_expectancy, poverty, household_income) %>%
  map2_dfc(
    .y = c(1, 2, 0),
    .f = ~ round(.x, digits = .y)
  )
df %>%
  select(-life_expectancy, -poverty, -household_income) %>%
  bind_cols(rounded)


modify2_at <- function(.x, .y, .at, .f) {
  modified <- .x[.at] %>%
    map2(.y, .f)
  .x[.at] <- modified
  return(.x)
}

df %>%
  modify2_at(
    .y = c(1, 2, 0),
    .at = c("life_expectancy", "poverty", "household_income"),
    .f = ~ round(.x, digits = .y)
  )
