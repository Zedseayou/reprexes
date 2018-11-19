library(tidyverse)
run_model1 <- function(df, dep_str, ...){
  groupers <- enquos(...)
  formula <- dep_str %>% str_c("~ cty") %>% as.formula()
  df %>%
    group_by(!!!groupers) %>%
    do(model = lm(formula, data = .))
}

run_model2 <- function(df, formula, ...){
  groupers <- enquos(...)
  formula <- enexpr(formula)
  df %>%
    group_by(!!!groupers) %>%
    do(model = lm(!!formula, data = .))
}

run_model1(mpg, "hwy", cyl)
run_model2(mpg, hwy ~ cty, cyl)



run_model3 <- function (df, dep_str, ...) {
  dep_str <- ensym(dep_str)
  groupers <- enquos(...)
  formula <- dep_str %>% str_c("~ cty") %>% as.formula()
  df %>%
    group_by(!!!groupers) %>%
    # do(model = lm(formula, data = .)) %>%
    mutate(copy = !!dep_str)
}



run_model3(mpg, hwy, cyl)

fun <- function(arg){
  arg <- ensym(arg)
}
fun(abc)
