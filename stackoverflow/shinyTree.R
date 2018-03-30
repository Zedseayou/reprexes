library(tidyverse)
tbl <- tibble(
  "region" = c(paste("region", rep(1:3, each=4))),
  "area" = c(paste("area", rep(1:6, each=2))),
  "name" = c(paste("name",1:12))
)

tbl %>%
  mutate(name = str_c("'", name, "'=''")) %>%
  group_by(region, area) %>%
  summarise(names = str_c(name, collapse = ", ")) %>%
  mutate(area = str_c("'", area, "' = list(", names, ")")) %>%
  summarise(areas = str_c(area, collapse = ", ")) %>%
  mutate(region = str_c("'", region, "' = list(", areas, ")")) %>%
  summarise(liststr = str_c(region, collapse = ", ")) %>%
  mutate(liststr = str_c("list(", liststr, ")")) %>%
  `[[`(1)

makelist <- function(parent, child) str_c("'", parent, "' = list(", child, ")")
collapse <- function(level) str_c(level, collapse = ", ")

tbl %>%
  mutate(name = str_c("'", name, "'=''")) %>%
  group_by(region, area) %>%
  summarise(names = collapse(name)) %>%
  mutate(area = makelist(area, names)) %>%
  summarise(areas = collapse(area)) %>%
  mutate(region = makelist(region, areas)) %>%
  summarise(regions = collapse(region)) %>%
  mutate(liststr = str_c("list(", regions, ")")) %>%
  `[[`(1)
