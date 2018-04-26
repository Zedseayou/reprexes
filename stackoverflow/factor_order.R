library(tidyverse)
df <- read_table2(
"block  description
 1      enroll
 2      openemail
 1      enroll
 2      openemail
 1      motivated
 1      motivated
 1      motivated"
)

df %>%
  mutate(index = as.integer(factor(description, levels = unique(description))))
