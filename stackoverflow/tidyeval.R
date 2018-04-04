x <- data.frame(a = c(10, 20, 30, 0), b = c(1, 2, 3, 0), c = c(1, 2, 3, 0), d = c(8, 16, 24, 0))

library(dplyr)
div_cols <- function(data, numerators, denominator){
  numers <- enquo(numerators)
  denom <- rlang::sym(denominator)

  x %>%
    mutate_at(
      vars(one_of(!!numers)),
      funs(
        ifelse(
          test = !!denom > 0,
          yes = round(. / !!denom * 100, 2),
          no = 0
        )
      )
    )
}

div_cols(x, c("b", "c", "d"), "a")
