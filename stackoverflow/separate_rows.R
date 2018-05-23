library(tidyverse)
df <- read_table2(
  "cca2    ccn3    cca3    borders
  AX      248     ALA
  AL      8       ALB     MNE,GRC,MKD,UNK
  AD      20      AND     FRA,ESP
  AT      40      AUT     CZE,DEU,HUN,ITA,LIE,SVK,SVN,CHE
  BE      56      BEL     FRA,DEU,LUX,NLD"
)

df %>%
  separate_rows(borders, sep = ",") %>%
  group_by(cca2) %>%
  mutate(b = row_number()) %>%
  spread(b, borders, sep = "")
