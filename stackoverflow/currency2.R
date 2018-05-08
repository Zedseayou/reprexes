library(tidyverse)
x <- c("$1,000.00", "$500.00", "-$200.00")
x %>%
  str_replace("^-\\$(.*)$", "$-\\1") %>%
  parse_number()

x %>%
  str_remove("\\$") %>%
  parse_number()
