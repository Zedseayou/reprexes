paste2 <- function(x, y, sep = ".") paste(x, y, sep = sep)

library(purrr)
letters[1:4] %>%
  map_chr(
    .x = 2:length(.),
    .f = function(index) reduce2(
      .x = .[1:index],
      .y = c("-", ".", "-")[1:(index - 1)],
      .f = paste2
    )
  )
