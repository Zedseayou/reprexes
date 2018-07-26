library(tidyverse)
ram <- read_table2(
  "ABMD        ACAD       ALGN        ALNY        ANIP      ASCMA        AVGO        CALD        CLVS       CORT
0.03794643 0.296774194 0.13009009  0.32219178  0.13008130 0.02857604  0.13014640 -0.07929515  0.23375000  0.5174825
0.14982079 0.006633499 0.00255102 -0.01823456 -0.05755396 0.07659708 -0.04333138  0.04066986 -0.04457953 -0.2465438"
)
summary <- ram %>%
  gather(colname, value) %>%
  group_by(colname) %>%
  summarise_at(.vars = vars(value), .funs = funs(mean = mean, sum = sum, max = max)) %>%
  arrange(desc(sum))
summary
ram[summary$colname]
