remove_up_to <- function(df, colname){
  col_i <- which(colnames(df) == colname) - 1
  df[-(1:col_i)]
}

library(tidyverse)
remove_up_to(mpg, "cyl")
mpg %>% select(cyl:tidyselect::last_col())
