library(stringr)
strings <- c("TwoWords", "ThreeWordsTogether", "Three Words Apart",
             "FourWordsTogetherHere", "MiDdleCaps")

strings %>%
  str_replace_all("([a-z])([A-Z])", "\\1 \\2")
