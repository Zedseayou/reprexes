# https://stackoverflow.com/questions/50427928/split-strings-into-smaller-ones-to-create-new-rows-in-a-data-frame-in-r
posts_sentences <- data.frame(
  "element_id" = c(1, 1, 2, 2, 2), "sentence_id" = c(1, 2, 1, 2, 3),
  "sentence" = c("You know, when I grew up, I grew up in a very religious family, I had the same sought of troubles people have, I was excelling in alot of ways, but because there was alot of trouble at home, we were always moving around", "Im at breaking point.I have no one to talk to about this and if I’m honest I think I’m too scared to tell anyone because if I do then it becomes real.I dont know what to do.", "I feel like I’m going to explode.", "I have so many thoughts and feelings inside and I don't know who to tell and I was going to tell my friend about it but I'm not sure.", "I keep saying omg!it's too much"),
  "sentence_wc" = c(60, 30, 7, 20, 7), stringsAsFactors = FALSE
)

library(tidyverse)
library(tokenizers)
split_too_long <- function(df, regexp, max_length) {
  df %>%
    mutate(wc = count_words(sentence)) %>%
    pmap(function(...) tibble(...)) %>%
    map_if(
      .p = ~ .$wc > max_length,
      .f = ~ separate_rows(., sentence, sep = regexp)
      ) %>%
    bind_rows() %>%
    mutate(wc = count_words(sentence)) %>%
    filter(wc != 0)
}

posts_sentences %>%
  group_by(element_id) %>%
  summarise(sentence = str_c(sentence, collapse = ".")) %>%
  ungroup() %>%
  split_too_long("[\\.\\?\\!] ?", 15) %>%
  split_too_long(", ?(?=[:upper:])", 15) %>%
  split_too_long("and ?(?=[:upper:])", 15) %>%
  group_by(element_id) %>%
  mutate(
    sentence = str_trim(sentence),
    sentence_id = row_number()
  ) %>%
  select(element_id, sentence_id, sentence, wc)
