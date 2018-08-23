library(tidyverse)

df <- structure(list(trial = 1:10, answer = structure(c(9L, 2L, 4L, 7L, 1L, 5L, 3L, 6L, 8L, 10L), .Label = c("Best way to waste money", "He ran out of money, so he had to stop playing poker", "I go to work", "Lets all be unique together until we realise we are all the same", "Roy travels to Africa", "She borrowed the book from him many years ago and did not returned it yet", "She did her best to help him", "Students did not cheat on the test, for it was not the right thing to do", "The stranger officiates the meal", "We have a lot of rain in June"), class = "factor"), given = structure(c(10L, 3L, 6L, 8L, 4L, 2L, 1L, 7L, 9L, 5L), .Label = c("", "He is in Africa Roy", "He lost money because he had played poker", "Instrument to waste money and time", "It was raining in June", "People are unique until they try to fit in", "She borrowed the book from the library and forgot to return it", "She did her very best to help him out", "Students know not to cheat", "The guests ate the meal"), class = "factor")), class = "data.frame", row.names = c(NA, -10L))

format_str <- function(string) {
  string %>%
    str_to_lower %>%
    str_remove_all("[:punct:]") %>%
    str_split(" ")
}

df %>%
  mutate(
    similarity = map2_dbl(
      .x = format_str(answer),
      .y = format_str(given),
      .f = ~ length(intersect(.x, .y)) / length(.x)
    )
  ) %>%
  as_tibble
