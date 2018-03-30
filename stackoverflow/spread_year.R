library(tidyverse)
tbl <- read_table2(
  "Date     Item     ShopCode     Price     BasePrice     Location
201101    Top           1       3.99          3.99          101
  201101    Top           1       3.99          3.99          101
  201101    Top           4      22.99         25.00          333
  201102    Top           2       8.99         14.00          978
  201102    Top           4      22.99         25.00          333
  201103    Top           2       8.99         14.00          978
  201103    Top           1       3.99          3.99          101
  201104    Top           5      40.00         40.00          541
  201104    Top           1       2.99          3.99          101
  201104    Top           4      22.99         25.00          333"
  )

tbl %>%
  distinct() %>%
  bind_cols(., group = group_indices(., ShopCode, BasePrice, Location)) %>%
  spread(Date, Price) %>%
  mutate(Top = str_c(Item, group)) %>%
  select(Top, everything(), -ShopCode, -BasePrice, - Location, -group, - Item)
