library(tidyverse)

evolve_sentence <- function(sentence, arg2) {
  chars <- str_split(sentence, "") %>% pluck(1)
  if (runif(1) > 0.5) {
    chars[sample(1:length(chars), 1)] <- sample(chars, 1)
  }
  sentence <- str_c(chars, collapse = "")
  words <- str_split(sentence, " ") %>% pluck(1)
  if (runif(1) > 0.9) {
    words[sample(1:length(words), 1)] <- sample(words, 1)
  }
  sentence <- str_c(words, collapse = " ")
  sentence
}

tbl_evolve <- tibble(iteration = 1:500, text = "This sentence is changing")
for (i in 2:500) {
  tbl_evolve$text[i] <- evolve_sentence(tbl_evolve$text[i - 1])
}
tbl_evolve %>%
  distinct(text, .keep_all = TRUE)
