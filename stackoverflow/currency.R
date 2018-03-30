text <- "Odebrecht has admitted to paying $29 million in bribes to public officials in Peru between 2005 and 2014 in exchange for $12.5 billion in contracts."

library(stringr)
text %>%
  str_extract_all("\\S*? (?=(million|billion))", simplify = TRUE) %>%
  str_trim()
