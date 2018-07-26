t <- c("The adds fundamental principle”, The discriminatory a")
library(stringr)
t %>%
  str_extract_all(".{3}|.{0,2}$") %>%
  `[[`(1) %>%
  str_c(collapse="\n") %>%
  writeLines()
