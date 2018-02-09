library(tidyverse, quietly = TRUE)
v <- c(0.09199,0.0981,0.101,0.10002,0.0927273,0.1,0.091,0.099,0.105,0.1,0.1,0.1,0.1,0.100821,0.09)
c <- c(0,0,0,0,0.0927273,0,0,0,0,0,0,0,0,0.100821,0)

tbl <- tibble(c, v) %>% rowid_to_column()

is_v_lower <- function(rowid, c, v){
  if (c <= 0){
    return(NA)
  } else if (v > min(tbl$v[(rowid + 1):nrow(tbl)])) {
    min_index = which.min(tbl$v[(rowid + 1):nrow(tbl)])
    later_rowid = tbl$rowid[(rowid + 1):nrow(tbl)]
    return(later_rowid[min_index])
  } else {
    return(0)
  }
}

output <- pmap_chr(tbl, is_v_lower)

new_tbl <- bind_cols(tbl, lower_v_index = output) %>% print()
