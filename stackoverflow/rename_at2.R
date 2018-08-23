library(tidyverse)
iris %>%
  rename_at(vars(starts_with("Sepal"), funs(str_replace(., "(Sepal)\\.(.*)", "\\2\\.\\1"))))

sepal_renamer <- function(names){
  str_replace(names, "(Sepal)\\.(.*)", "\\2\\.\\1")
}
iris %>%
  rename_at(vars(starts_with("Sepal"), sepal_renamer))

iris %>% rename_all(funs(str_replace(., "(Sepal)\\.(.*)", "\\2\\.\\1"))) %>% colnames

iris %>%
  `colnames<-`(str_replace(colnames(.), "(Sepal)\\.(.*)", "\\2\\.\\1")) %>% colnames

iris %>%
  rename_at(vars(starts_with("Sepal"), ~ str_c(., "abc")))
