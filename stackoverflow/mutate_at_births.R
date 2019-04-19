library(tidyverse)

pa2010 <- c(0, 0, 2, 5, 3, 6, 8, 2, 1, 1)
pa2009 <- c(0, 0, 2, 4, 3, 6, 8 ,2, 0, 0)
pa2008 <- c(0, 0, 1, 4, 3, 5, 8, 1, 0, 0)

Parity <- data.frame(pa2010, pa2009, pa2008)
Parity %>%
  mutate_at(
    .vars = vars(starts_with("pa")),
    .funs = ~ if_else(. >= 7, 7, .)
  ) %>%
  mutate_at(
    .vars = vars(starts_with("pa")),
    .funs = list(
      parity = ~ . %>%
        factor(levels = 0:7, labels = str_c("Parity ", 0:7)) %>%
        fct_recode("Parity 7+" = "Parity 7")
    )
  ) %>%
  rename_at(
    .vars = vars(ends_with("_parity")),
    .funs = . %>%
      str_remove("_parity") %>%
      str_c("p", .)
  )


  rowid_to_column(var = "woman_id") %>%
  gather(key = year_pa, value = children, -woman_id) %>%
  mutate(children = if_else(children >= 7, 7, children)) %>%
  spread(year_pa, children) %>%
  mutate_at(
    .vars = vars(starts_with)
  )

year_ppa = str_c("p", year_pa),
parity = children %>%
  factor(labels = str_c("Parity ", 0:7)) %>%
  fct_recode("Parity 7+" = "Parity 7")
