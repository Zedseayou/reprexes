library(tidyverse)
actors <- tibble(
  name = c('John Doe','Peter Gynn','Jolie Hope'),
  age = c(26 , 32, 56),
  postcode = c('4011', '5600', '7700')
  )
edge <- tibble(
  from = c('John Doe','John Doe','John Doe', 'Peter Gynn', 'Peter Gynn', 'Jolie Hope'),
  to = c('John Doe', 'John Doe', 'Peter Gynn', 'Jolie Hope', 'Peter Gynn', 'Frank Smith')
)

edge %>%
  filter(from != to)

edge %>%
  gather("to_from", "name", from, to) %>%
  distinct(name) %>%
  full_join(actors)
