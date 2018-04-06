library(tidyverse)
read_char <- function(char){
  assertthat::assert_that(char %in% c("A", "9", " ", ""), msg = "Invalid template")
  if (char == "A"){
    sample(LETTERS, 1)
  } else if (char == "9"){
    sample(0:9, 1)
  } else if (char == " "){
    " "
  } else if (char == ""){
    ""
  }
}

make_postcode <- function(templates){
  templates %>%
    str_split_fixed(pattern = "", n = Inf) %>%
    t() %>%
    as_tibble() %>%
    map_chr(., ~ str_trim(str_c(map_chr(., read_char), collapse = "")))
}

make_postcode("A9 9AA")
make_postcode(c("A9 9AA","A9 9AA","A9A 9AA"))
make_postcode("B2 194")

test = stringi::stri_rand_strings(10000, sample(5:9, 1), pattern = "[A9\\ ]")
profvis(
a <- make_postcode(test)
)

stringi::str_replace_all_fixed()
