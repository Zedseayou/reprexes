library(tidyverse)
library(microbenchmark)

gtim13 <- function(n) {
  s <- as.character(n)
  check.sum <- 0
  for (i in 1:nchar(s)) {
    digit <- substr(s, nchar(s) - i + 1, nchar(s) - i + 1)
    check.sum <- check.sum + as.numeric(digit) * ifelse(i %% 2, 1, 3)
  }
  10 - check.sum %% 10
}

gtim13Challenger <- function(n) {
  n <- as.integer(n)
  len <- as.integer(ceiling(log10(n)))
  digs <- vapply(0L:(len - 1L), function(x) (n %/% as.integer(10^x) %% 10L), 1L, USE.NAMES = FALSE)
  if (len > 1L)
    digs[seq.int(2L,len,2L)] <- digs[seq.int(2L,len,2L)] * 3L
  10L - sum(digs) %% 10L
}

gtim13_vec <- function(x) {
  d <- x %% 10
  for(i in 1:7) {
    d <- d +(x%/% 10^i %% 10) * c(1,3)[1+i%%2]
  }
  d
  10-(d%%10)
}

gtim13_tidy <- function(n) {
  check_sum <- function(x) {
    ones <- as.integer(str_sub(x, 1, 1))
    twos <- as.integer(str_sub(x, 2, 2))
    check_sum <- 10 - (sum(ones * twos) %% 10)
    return(check_sum)
  }

  n %>%
    str_pad(width = 12, side = "left", pad = "0") %>%
    str_extract_all(pattern = ".{2}") %>%
    map_dbl(check_sum)
}

num <- sample(1:1000000, 100000, T)
system.time(vapply(num, gtim13, 0))
system.time(vapply(num, gtim13Challenger, 0))
system.time(gtim13_vec(num))
system.time(gtim13_tidy(num))
