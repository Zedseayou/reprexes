library(tidyverse)
library(broom)
set.seed(100)
tbl <- tibble(
  group_id = rep(1:3, each = 10),
  y1 = rnorm(30),
  y2 = runif(30),
  x1 = rnorm(30),
  x2 = runif(30)
)

tbl %>%
  group_by(group_id) %>%
  do(
    model1 = lm(y1 ~ x1 + x2, data = .),
    model2 = lm(y2 ~ x1 + x2, data = .)
  ) %>%
  tidy(model1)

tbl2 <- mutate(tbl, y2 = c(runif(20), rep(NA, 10)))

tbl2 %>%
  group_by(group_id) %>%
  do(
    model1 = lm(y1 ~ x1 + x2, data = .),
    model2 = lm(y2 ~ x1 + x2, data = .)
  ) %>%
  tidy(model1)

tbl2 %>%
  group_by(group_id) %>%
  do(
    model1 = lm(y1 ~ x1 + x2, data = .),
    model2 = try(
      lm(y2 ~ x1 + x2, data = .),
      silent = TRUE
    )
  ) %>%
  ungroup() %>%
  gather(model, lm, starts_with("model")) %>%
  mutate(error = map_lgl(lm, ~inherits(., "try-error"))) %>%
  filter(error == FALSE) %>%
  rowwise() %>%
  glance(lm) %>%
  ungroup() %>%
  complete(group_id = 1:3, model = c("model1", "model2"))

  left_join(
    select(., rowid),
    . %>%
      filter(error == FALSE) %>%
      rowwise() %>%
      glance(lm) %>%
      ungroup(),
    by = "rowid"
  )

  mutate_at(
    .vars = vars(starts_with("model")),
    .funs = function(col) {
      modify_if(
        .x = col,
        .p = function(cell) inherits(cell, "try-error"),
        .f = function(cell) NA
      )
    }
  ) %>%
   %>%
  rowwise() %>%
  glance(lm)
