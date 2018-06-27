library(tidyverse)
tbl <- read_csv(
"date_bom ,   pmsector1, recommendation, sec_returns
2005-01-01, Apartment HB,            BUY, -0.98328013
2005-01-01, Apartment HB,           HOLD,  0.39360700
2005-01-01, Apartment HB,           SELL, -1.10071321
2005-01-01, Apartment LB,            BUY, -0.07363028
2005-01-01, Apartment LB,           HOLD,  0.02747529
2005-01-01, Apartment LB,           SELL,  0.32811229"
)

tbl %>%
  # filter(recommendation %in% c("BUY", "SELL")) %>%
  spread(recommendation, sec_returns) %>%
  group_by(date_bom, pmsector1) %>%
  summarise(recommendation = "SPREAD", sec_returns = BUY - SELL)
