library(tidyverse)
df <- read_table(
"Apples        Oranges       Bananas       ServiceGood       ShortTime
Excellent     Terrible      Average       Somewhat agree    Somewhat agree
Excellent                   Above Average Strongly agree    Somewhat agree
Above Average Terrible      Below Average                   Somewhat disagree
Excellent     Average       Below Average Meh               Strongly disagree
Below Average Terrible      Above Average Somewhat agree    Meh"
)

df %>%
  mutate_all(~ str_replace(., "^$", NA_character_)) %>%
  mutate_all(
    .funs = ~ as.integer(recode(
      .x = .,
      "Terrible"      = 1,
      "Below Average" = 2,
      "Average"       = 3,
      "Above Average" = 4,
      "Excellent"     = 5,
      "Strongly disagree" = 1,
      "Somewhat disagree" = 2,
      "Meh"               = 3,
      "Somewhat agree"    = 4,
      "Strongly agree"    = 5
    ))
  )
