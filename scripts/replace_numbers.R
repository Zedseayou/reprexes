library(tidyverse)
clas <- c("1461CD_1.332C","1461CD_1.5C_242","1461CD_1.6CC_131")
df <- data.frame(clas)

df %>%
  mutate(clas = str_extract(clas, "1\\.\\d{1,2}"))
