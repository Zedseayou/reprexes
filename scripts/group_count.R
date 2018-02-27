library(tidyverse)
tbl <- read_table2(
  "sample  deployment  density replicate   shell.num
A       A           L         1          1
A       A           L         1          1
A       A           L         1          2
A       A           L         2          1
A       A           L         2          2
B       B           L         1          1
B       B           L         1          2
B       B           L         2          1
B       B           L         2          2
A       C           M         1          2
A       C           M         1          2
A       C           M         1          3
A       C           M         2          1
A       C           M         2          1"
)

tbl %>%
  count(sample, deployment, density, replicate, shell.num)
