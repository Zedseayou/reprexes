library(tidyverse)
my_col <- c("Thursday, Mar 29, 2018", "Regular Season Wins\n\t\t\n                  Arizona Diamondbacks\n\t\t\t\n\t\t\t  Regular Season Wins\n\t\t\t  Arizona Diamondbacks\n\t\t\t  Must play 160 games for action.",
  "Regular Season Wins", "Arizona Diamondbacks\n\t\t\t\n\t\t\t  Regular Season Wins\n\t\t\t  Arizona Diamondbacks\n\t\t\t  Must play 160 games for action.",
  "07:00 PM", "07:00 PM", "Regular Season Wins\n\t\t\n                  Atlanta Braves\n\t\t\t\n\t\t\t  Regular Season Wins\n\t\t\t  Atlanta Braves\n\t\t\t  Must play 160 games for action.",
  "Regular Season Wins", "Atlanta Braves\n\t\t\t\n\t\t\t  Regular Season Wins\n\t\t\t  Atlanta Braves\n\t\t\t  Must play 160 games for action."
)

tbl <- tibble(col = my_col)
tbl %>%
  slice(seq(from = 4, to = nrow(.), by = 5)) %>%
  mutate(teams = str_extract(col, "^.*(?=\\n)")) %>%
  select(teams)

teams <- my_col[seq(from = 4, to = length(my_col), by = 5)] %>%
  str_extract("^.*(?=\\n)") %>%
  print()
