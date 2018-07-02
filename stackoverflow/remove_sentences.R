text = c(
  "Section 1 Blah blah blah",
  "Random sentence.",
  "Section 2 Blah blah blah",
  "Random sentence.",
  "Section 564 of the blah blah blah.",
  "Section 578 of the blah blah blah had",
  "the following requirements."
)

library(stringr)

remove_sentences <- function(strings){
  lower <- str_which(strings, "^[:lower:]")
  no_next_lower <- strings[-(lower - 1)]
  str_subset(no_next_lower, "[^\\.]$")
}

text %>%
  remove_sentences %>%
  writeLines
