library(tidyverse)
library(broom)
predictors <- select(mtcars, -mpg)

models <- predictors %>%
  map(function(col) {lm(mtcars$mpg ~ poly(col))}) %>%
  enframe("predictor", "model")

models %>%
  rowwise() %>%
  tidy(model)

library(tidyverse)
library(broom)
mtcars %>%
  gather(predictor, measure, -mpg) %>%
  group_by(predictor) %>%
  do(tidy(lm(mpg ~ measure, .)))
