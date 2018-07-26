library(tidyverse)
files <- list.files(pattern="\\.csv$")

df_list <- map(files, read_csv2)
names(df_list) <- str_remove(files, "\\.csv$")
