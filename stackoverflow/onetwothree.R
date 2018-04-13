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

# Create vectors of letter groups
ones <- single$Mat
twos <- str_c(double$Mat1, double$Mat2)
threes <- str_c(triple$Mat1, triple$Mat2, triple$Mat3)

# Create vector of permutations of ABCDE
options <- ones %>%
  gtools::permutations(5, 5, .) %>%
  as_tibble() %>%
  unite("option", V1:V5, sep = "") %>%
  `[[`(1)

# Create table with prices to join combinations onto
lookup <- bind_rows(
 single %>% mutate(rowcomb = Mat),
 double %>% unite(rowcomb, Mat1:Mat2, remove = FALSE, sep = ""),
 triple %>% unite(rowcomb, Mat1:Mat3, remove = FALSE, sep = "")
) %>%
  select(rowcomb, price = Price)

# Get all possible combinations of letter groups that could make five letters
combinations <- bind_rows(
  crossing(ones, ones, ones, ones, ones),
  crossing(ones, ones, ones, twos),
  crossing(ones, ones, threes),
  crossing(ones, twos, twos),
  crossing(twos, threes)
) %>%
  mutate_all(~ replace_na(., "")) %>%
  unite("string", ones:twos1, sep = "", remove = FALSE) %>%
  filter(string %in% options) %>% # Remove any that have repeated letters
  # Add column with the number of elements in each combination
  bind_cols(groupings = pmap_int(.[, -1], function(...) sum(c(...) != ""))) %>%
  bind_cols( # Add column that lets us remove different permutations of the same element combinations
    row = .[, 2:9] %>%
      pmap(function(...) c(...)) %>%
      map_chr(~str_c(str_sort(.), collapse = "_"))
  ) %>%
  distinct(row, .keep_all = TRUE) %>%
  rowid_to_column(var = "comb_id") # 29 final combinations

total_price <- combinations %>%
  gather("table", "letter", ones:twos1) %>%
  left_join(lookup, by = c("letter" = "rowcomb")) %>%
  group_by(comb_id) %>%
  summarise(total_price = sum(price, na.rm = TRUE))

output <- left_join(combinations, total_price, by = "comb_id") %>%
  mutate(end_price = total_price + 500 * groupings) %>%
  select(comb_id, row, groupings, end_price)

output

