library(dplyr)
library(broom)

df <- tribble(
  ~year, ~country, ~value,
  2001, "France", 55,
  2002, "France", 53,
  2003, "France", 31,
  2004, "France", 10,
  2005, "France", 30,
  2006, "France", 37,
  2007, "France", 54,
  2008, "France", 58,
  2009, "France", 50,
  2010, "France", 40,
  2011, "France", 49,
  2001, "USA", 55,
  2002, "USA", 53,
  2003, "USA", 64,
  2004, "USA", 40,
  2005, "USA", 30,
  2006, "USA", 39,
  2007, "USA", 55,
  2008, "USA", 53,
  2009, "USA", 71,
  2010, "USA", 44,
  2011, "USA", 40
)

rmod <- df %>%
  group_by(country) %>%
  do(fitModels = lm("value ~ year", data = .))

rmod %>%
  augment(fitModels)
