data <- structure(list(Teacher = structure(c(1L, 1L, 1L, 1L, 1L, 1L,
                                     1L, 1L, 1L, 1L, 1L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L
), .Label = c("Please.rate.teacher:.JOHN.DOE .Overall.rating.for.teacher",
              "Please.rate.teacher: Jane.Doe.Overall.rating.for.teacher"), class = "factor"),
Overall_Rating = c(5L, 4L, 5L, 4L, 4L, 5L, 4L, 4L, 4L, 4L,
                   3L, 5L, 4L, 4L, 3L, 4L, 4L, 4L, 4L, 4L, 4L, 3L)), .Names = c("Teacher",
                                                                                "Overall_Rating"), class = "data.frame", row.names = c(NA, -22L
                                                                                ))

library(tidyverse)
data %>%
  mutate(
    Teacher = Teacher %>%
      str_remove_all("Please.rate.teacher:|.Overall.rating.for.teacher") %>%
      str_replace_all("\\.", " ") %>%
      str_trim() %>%
      str_to_title()
  ) %>%
  `[[`(1) %>%
  unique()


Data_clean <- data %>%
  mutate(Teacher = as.character(Teacher),
         Teacher = gsub("Please.rate.teacher|.Overall.rating.for.teacher|[:]", "", Teacher),
         Teacher = gsub("[.]", " ", Teacher),
         Teacher = trimws(Teacher),
         Teacher = tolower(Teacher), Teacher = tools::toTitleCase(Teacher))

unique(Data_clean$Teacher)
