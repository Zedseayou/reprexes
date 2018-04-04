library(tidyverse)
single <- read_table2("Mat         Price
A           1029.90
B            568.52
C            497.12
D            573.50
E            217.92")
double <- read_table2("Mat1  Mat2        Price
A      C         1529.61
A      D         1623.49
A      E         1325.86
B      C         1050.64
B      D         1146.65
B      E         849.02
C      D         999.42
C      E         700.03
D      E         776.41")
triple <- read_table2("Mat1  Mat2   Mat3     Price
B      C      D     1564.98
B      C      E     1267.30
C      D      E     1350.45
B      D      E     1202.33")

total <- tibble(
  rename(single, one = Mat),
  unite(double, "two", Mat1, Mat2),
  unite(triple, "three", Mat1:Mat3)
)

combos <- tibble(
  x = single$Mat %>% `length<-`(9),
  y = unite(double, "two", Mat1, Mat2, sep = "")$two,
  z = unite(triple, "three", Mat1:Mat3, sep = "")$three %>% `length<-`(9)
) %>%
  complete(x, y, z) %>%
  unite("xyz", x, y, z, sep = "", remove = FALSE)

