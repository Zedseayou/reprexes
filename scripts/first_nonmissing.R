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

tbl %>%
  magrittr::set_colnames(str_to_lower(colnames(.))) %>%
  group_by(site_id) %>%
  mutate(Name = row_number(), Phone = row_number()) %>%
  spread(Name, name, sep = "_") %>%
  spread(Phone, phone, sep = "_") %>%
  summarise_at(vars(Name_1:Phone_3), function(x) x[which(!is.na(x))[1]])
