library(tidyverse)
states <- tibble(state = c("AK", "AZ", "AR", "CA", "NY"))
partial_url <- tibble(part = c("part1", "part2"))
url_parts <- tibble(urlpart = c("urlpart1", "urlpart2"))
year <- tibble(year = 2007:2010)
filetype <- tibble(filetype = c("csv", "txt", "tar"))

urls <- bind_cols(
  states = states[[1]] %>% factor() %>% head(2),
  partial_url = partial_url[[1]] %>% factor() %>% head(2),
  url_parts = url_parts[[1]] %>% factor() %>% head(2),
  year = year[[1]] %>% factor() %>% head(2),
  filetype = filetype[[1]] %>% factor() %>% head(2)
  ) %>%
  complete(states, partial_url, url_parts, year, filetype) %>%
  unite("middle", states, url_parts, year, sep = "_") %>%
  unite("end", middle, filetype, sep = ".") %>%
  unite("url", partial_url, end, sep = "/") %>%
  mutate(url = str_c("http://", url))
