set.seed(1)
named_vec <- quantile(rnorm(1000), c(0.05, 0.1, 0.25, 0.5, 0.75, 0.9, 0.95))
named_vec

library(tidyverse)
bench::mark(
  enframe(named_vec) %>% spread(name, value),
  as_tibble(matrix(named_vec, nrow = 1, dimnames = list(NULL, names(named_vec)))),
  data.frame(matrix(named_vec, nrow = 1)) %>% `names<-`(names(named_vec)),
  as.data.frame(matrix(named_vec, nrow = 1)) %>% `names<-`(names(named_vec)),
  as.data.frame(matrix(named_vec, nrow = 1, dimnames = list(NULL, names(named_vec)))),
  as.data.frame(t(x = named_vec)))
)

tbl <- tibble(
  n = 1:100,
  qt = map(n, ~ quantile(rnorm(.), c(0.05, 0.1, 0.25, 0.5, 0.75, 0.9, 0.95)))
)

f1 <- function(vec) enframe(vec) %>% spread(name, value)
f2 <- function(vec) as_tibble(matrix(vec, nrow = 1, dimnames = list(NULL, names(vec))))
f3 <- function(vec) data.frame(matrix(vec, nrow = 1)) %>% `names<-`(names(vec))
f4 <- function(vec) as.data.frame(matrix(vec, nrow = 1)) %>% `names<-`(names(vec))
f5 <- function(vec) as.data.frame(matrix(vec, nrow = 1, dimnames = list(NULL, names(vec))))
f6 <- function(vec) as.data.frame(t(x = vec))

bench::mark(
  a = tbl %>% mutate(qt = map(qt, f1)) %>% unnest(qt),
  b = tbl %>% mutate(qt = map(qt, f2)) %>% unnest(qt),
  c = tbl %>% mutate(qt = map(qt, f3)) %>% unnest(qt),
  d = tbl %>% mutate(qt = map(qt, f4)) %>% unnest(qt),
  e = tbl %>% mutate(qt = map(qt, f5)) %>% unnest(qt),
  f = tbl %>% mutate(qt = map(qt, f6)) %>% unnest(qt),
  g = tbl %>% unnest_wider(qt)
)
