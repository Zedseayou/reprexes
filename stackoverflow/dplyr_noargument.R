library(tidyverse)
test <- tibble(
  A = c(1:5,1:5),
  B = c(1,2,1,2,3,3,3,3,3,3),
  C = c(1,1,1,1,2,3,4,5,4,3)
)

# begin function, set default for group var to NULL.
prop_tab <- function(df, column, group) {

  col_name <- enquo(column)
  group_name <- enquo(group)

  # if group_by var is not supplied, then:
  if(!missing(group)) {
    temp <- df %>%
      select(!!col_name, !!group_name) %>%
    group_by(!!group_name) %>%
    summarise(Percentages = 100 * length(!!col_name) / nrow(df))

  } else {
    # if group_by var is null, then...
    temp <- df %>%
      select(!!col_name) %>%
      group_by(col_name = !!col_name) %>%
      summarise(Percentages = 100 * length(!!col_name) / nrow(df))

  }

  temp
}

test %>% prop_tab(column = C)  # works

test %>% prop_tab(column = A, group = B)
