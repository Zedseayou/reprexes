library(stringr)
head(words)
head(words[str_detect(words, "^.{5}$")])
