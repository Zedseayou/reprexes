df.txt <- data.frame(col.of.tex= character(9), stringsAsFactors = FALSE)
j <- seq(from = 1, to = 9, by = 3)
for(i in seq(j)) {
  df.txt[j[i],] <- paste0("No.Abstract", i)
  df.txt[j[i]+1,] <- paste0("Title.Abstract", i)
  df.txt[j[i]+2,] <- paste0("Abstract", i)
}

library(tidyverse)
df.txt %>%
  mutate(group_id = rep(1:3, each = 3)) %>%
  group_by(group_id) %>%
  summarise(group = str_c(col.of.tex, collapse = "_")) %>%
  separate(group, c("No.Abstract", "Title.Abstract", "Abstract"), sep = "_")
