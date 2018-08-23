library(tidyverse)
tbl <- read_table2(
"iso    year  theft robbery burglary theft_price robbery_price burglary_price
ALB    2003   3694     199      874        32.9          115           49.3
ALB    2004   3694     199      874        38.2          134           57.3
ALB    2005   3694     199      874        42.8          150           64.2
ALB    2006   3450     164      779        47.0          165           70.5
AUS    2003 722334   14634   586266       408.4         1427          612.4
AUS    2004 636717   14634   512551       481.3         1683          721.2
AUS    2005 598700   14634   468558       536.7         1877          804.5
AUS    2006 594111   14634   433974       564.8         1973          846.5"
)
tidy_tbl <- tbl %>%
  gather(crime_type, measure, -iso, - year) %>%
  mutate(
    measure_type = if_else(str_detect(crime_type, "_price$"), "price", "count"),
    crime_type = str_remove(crime_type, "_price")
    ) %>%
  spread(measure_type, measure) %>%
  mutate(product = count * price)
tidy_tbl

tidy_tbl %>%
  gather(measure_type, measure, count:product) %>%
  unite("colname", crime_type, measure_type) %>%
  spread(colname, measure)
