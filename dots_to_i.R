x <- c(
  ".. ........ .......    ",
  "... ........ .......          ",
  ". ..... .......  . .. ... .... ",
  ".. ..... ...........  ....      "
)
library(stringr)
dots_to_i <- function(chr){
  pat_p <- "(?<=(^| )\\.{3})\\."
  pat_i <- "(?<=i)\\."
  while (any(str_detect(chr, pat_p)) | any(str_detect(chr, pat_i))){
    chr <- chr %>%
      str_replace_all(pat_p, "i") %>%
      str_replace_all(pat_i, "i")
  }
  return(chr)
}
dots_to_i(x)

dots_to_i2 <- function(chr){
  pattern <- "(?<=(^| )\\.{3})\\."
}

x %>%
  str_replace_all("(?<=\\.{3})(\\S+?)", "i")
