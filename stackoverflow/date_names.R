pdb <- tools::CRAN_package_db()
subset<-pdb[,c(1,17)]
ipck<-as.vector(installed.packages()[,1])
pdbCleaned <- subset[subset$Package %in% ipck, ]
pdbCleaned$Author

Authors <-gsub("[\r\n]", "", pdbCleaned$Author)
Authors <-gsub("\\[.*?\\]", "", Authors)
Authors <-gsub("\\(.*?\\)", "", Authors)
Authors <-gsub("<.*>", "", Authors)
Authors <-gsub("))", "", Authors)
Authors <-gsub("(?<=[\\s])\\s*|^\\s+|\\s+$", " ", Authors)
Authors

library(tidyverse)
authors <- installed.packages(fields = "Author") %>%
  as_tibble() %>%
  select(package = Package, author = Author)

authors %>%
  mutate(
    author = str_replace_all(author, "(\\[|\\(|<).*(\\]|\\)|>)", ""),
    author = str_replace_all(author, "[:space:]*(,|and)[:space:]*", ","),
    author = str_trim(author)
  )
