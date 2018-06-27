DF1 <- data.frame(
  Gender = factor(c("Male", "Female", "Female", "Female", "Male", "Male")),
  Wealth = factor(c("Rich", "Poor", "Rich", "Poor", "Rich", "Poor")),
  Education = factor(c("College", "College", "HS", "College", "HS", "HS"))
)

library(tidyverse)
DF2 <- DF1 %>%
  mutate_at(
    vars(Wealth, Education),
    funs(factor(str_c(str_to_upper(Gender), ": ", .)))
    )
DF2 %>% as_tibble()
