library(tidyverse)
df <- tibble(
  Name = c("Patï¿½nt", "Patï¿½nt"),
  Type = c("ï¿½de", "ï¿½de"),
  Role = c("ïn", "ïn")
)

df %>%
  mutate_at(
    .vars = vars(everything()),
    .funs = ~ str_replace(., pattern = "ï¿½nt", replacement = "ent")
  ) %>%
  mutate_at(
    .vars = vars(everything()),
    .funs = ~ str_replace(., pattern = "ï¿½de", replacement = "ide")
  ) %>%
  mutate_at(
    .vars = vars(everything()),
    .funs = ~ str_replace(., pattern = "ïn", replacement = "in")
  )
