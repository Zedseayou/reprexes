library(tidyverse)
tbl <- read_table2(
  "Site_Id    name    Phone
150        dan     916-654-8585
150        sasha     916-654-8794
150        Sam     916-654-8589
161        Jeff    916-654-8255
161        Danny    916-654-8535
120        Ali     916-654-8575"
)

spread_var <- function(df, var){
  var <- enquo(var)
  varname <- str_to_title(quo_name(var))
  df %>%
    mutate(!! varname := row_number()) %>%
    spread(!! varname, !! var, sep = "_")
}

test <- function(input){
  var <- input
  var2 <- enquo(input)
  var3 <- quo(input)
  print(input)
  print(var)
  print(var2)
  print(var3)
}
for (i in vars){
  test(i)
}


out <- tbl %>%
  magrittr::set_colnames(str_to_lower(colnames(.))) %>%
  group_by(site_id) %>%
  mutate(Name = row_number(), Phone = row_number())
for (i in colnames(out)[2:ncol(tbl)]){
  out <- spread_var(out, i)
}

cols_to_add <- matrix(nrow = nrow(tbl), ncol = ncol(tbl) - 1) %>%
  `colnames<-`(str_to_title(colnames(tbl)[2:ncol(tbl)]))

tbl %>% bind_cols(cols_to_add)

tbl %>%
  magrittr::set_colnames(str_to_lower(colnames(.))) %>%
  bind_cols(
    colnames(.) %>%
      )
  group_by(site_id) %>%
  mutate(Name = row_number(), Phone = row_number()) %>%
  spread(Name, name, sep = "_") %>%
  spread(Phone, phone, sep = "_") %>%
  summarise_at(vars(Name_1:Phone_3), function(x) x[which(!is.na(x))[1]])


  tibble(colnames(tbl))
