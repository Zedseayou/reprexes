l1 <- list(list("62010"), list("79110"), list("69202"), list("96040"), list("90010"), list("59200"), list("43320"), list("90020"), list("46220"), list("90030"), list("70220"), list("86909"), list("58110"), list("82990"), list("45110"), list("45201"), list("68203"), list("46720"), list("46510"), list("95290"), list("85510"), list("68204"), list("41200"), list("74900"), list("59120"), list("13921"), list("96090"), list("74102"), list("96022"), list("70210"))

library(tidyverse)

tbl <- l1 %>%
  map_chr(~.[[1]]) %>%
  tibble(n5 = .)

tbl %>%
  mutate(
    n2 = str_sub(n5, 1, 2),
    n3 = str_sub(n5, 1, 3),
    n4 = str_sub(n5, 1, 4)
  ) %>%
  arrange(n5) %>%
  nest(n4, .key = n4) %>%
  `[[`("n4")


l45 <- list(list("6201", list("62010")), list("7911", list("79110")), list("6920", list("69202", "69201")), list("9604", list("96040")), list("9001", list("90010")), list("5920", list("59200")))


get_uniques <- function(master_list){

  return(unique(strings))
}

make_parents <- function(master_list){
  strings <- master_list %>%
    flatten() %>%
    keep(is.character) %>%
    map_chr(~ .)
  nchar <- length(strings[1])
  parents <- strings %>%
    str_sub(1, nchar - 1) %>%
    unique()


  parent_list <- parents %>%
    map()

}

l45 %>% modify_depth(2, ~ map(., .f ~ .)) %>% str

get_uniques(l1)

to_sublist <- function(string_list){
  string <- string_list[[1]]

  if (nchar(string) == 2){
    return(string_list)
  } else {
    substring <- substr(string, 1, nchar(string) - 1)
    sublist <- list(substring, string_list)
    return(to_sublist(sublist))
  }
}

unique_4

eg1 <- list(
  list("12345"),
  list("12340"),
  list("12300"),
  list("12000"),
  list("10000")
  )
eg2 <- list(
  list("1234", list("12345", "12340")),
  list("1230", list("12300")),
  list("1200", list("12000")),
  list("1000", list("10000"))
  )
eg3a <- list(
  list("123", list("1234", list("12345", "12340"), "1230", list("12300"))),
  list("120", list("1200", list("12000"))),
  list("100", list("1000", list("10000")))
  )
eg3b <- list(
  list("123", list("1234", "1230", list("12345", "12340", "12300"))),
  list("120", list("1200", list("12000"))),
  list("100", list("1000", list("10000")))
)
str(eg1)
str(eg2)
str(eg3a)
str(eg3b)
