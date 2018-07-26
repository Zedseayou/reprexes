library(tidyverse)
data <- structure(list(`2010 - Both Sexes - 0` = 163753, `2010 - Male - 0` = 83878, `2010 - Female - 0` = 79875, `2011 - Both Sexes - 0` = 161923, `2011 - Male - 0` = 83134, `2011 - Female - 0` = 78789, `2010 - Both Sexes - 1` = 163043, `2010 - Male - 1` = 83174, `2010 - Female - 1` = 79869, `2011 - Both Sexes - 1` = 163342, `2011 - Male - 1` = 83472, `2011 - Female - 1` = 79870), row.names = c(NA, -1L), class = c("tbl_df", "tbl", "data.frame"))

data %>%
  gather(year_sex_age, population) %>%
  separate(year_sex_age, c("year_sex", "age"), sep = " - (?=0|1)") %>%
  spread(year_sex, population)
