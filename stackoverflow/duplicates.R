library(tidyverse)
library(microbenchmark)

opt1 <- function(df, ignore) {
  ignore = enquo(ignore)
  x <- df %>% select(-!!ignore)
  dups <- x[x %>% duplicated(), ]
  answer <- iris %>% semi_join(dups)
}

opt2 <- function(df, ignore) {
  index <-  which(colnames(df) == ignore)
  df[duplicated(df[-index]) | duplicated(df[-index], fromLast = TRUE), ]
}

opt3 <- function(df, ignore){
  ignore <-  enquo(ignore)
  df %>%
    group_by_at(vars(-!!ignore)) %>%
    filter(n() > 1)
}


microbenchmark(
  opt1 = suppressMessages(opt1(iris, Petal.Width)),
  opt2 = opt2(iris, "Petal.Width"),
  opt3 = opt3(iris, Petal.Width)
)
