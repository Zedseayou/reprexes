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

ones <- single$Mat
twos <- str_c(double$Mat1, double$Mat2)
threes <- str_c(triple$Mat1, triple$Mat2, triple$Mat3)

options <- ones %>%
  gtools::permutations(5, 5, .) %>%
  as_tibble() %>%
  unite("option", V1:V5, sep = "") %>%
  `[[`(1)

combinations <- bind_rows(
  crossing(ones, ones, ones, ones, ones),
  crossing(ones, ones, ones, twos),
  crossing(ones, ones, threes),
  crossing(ones, twos, twos),
  crossing(twos, threes)
) %>%
  mutate_all(~ replace_na(., "")) %>%
  unite("string", ones:twos1, sep = "", remove = FALSE) %>%
  filter(string %in% options) %>%
  bind_cols(
    row = .[, 2:9] %>%
      pmap(function(...) c(...)) %>%
      map_chr(~str_c(str_sort(.), collapse = "_"))
  ) %>%
  distinct(row, .keep_all = TRUE) %>%
  select(ones:twos1)

b <- combinations %>%
  rowid_to_column(var = "comb_id") %>%
  gather("table", "letter", ones:twos1)




