library(tidyverse)
tbl <- structure(list(Crop_1 = c("Potato", "Potato"), Crop_2 = c("Onion", "Sugarbeet"), Crop_3 = c("Sugarbeet", "Grassclover"), Crop_4 = c("Grassclover", "Potato"), Crop_5 = c("Cabbage", "Cabbage"), Crop_6 = c("Potato", "Onion"), Crop_7 = c("Wheat", "Carrot"), Crop_8 = c("Carrot", "Wheat")), class = "data.frame", row.names = c(NA, -2L))

pair_crops <- function(crop_row) {
  crop_set <- as.character(crop_row)
  n_crops <- length(crop_set)
  if (n_crops %% 2 == 1) {
    stop("Odd number of crops!")
  } else if (n_crops %% 4 == 0) {
    starts <- sort(c(seq.int(1, n_crops, 4), seq.int(2, n_crops, 4)))
  } else {
    starts <- sort(c(1:3,seq.int(7, n_crops, 4), seq.int(8, n_crops, 4)))
  }
  ends <- setdiff(1:n_crops, starts)
  tibble(
    pair = str_c(crop_set[starts], "-", crop_set[ends]),
    name = str_c("Pair_", 1:length(starts))
  ) %>%
    spread(name, pair)
}

tbl %>%
  rowid_to_column %>%
  nest(-rowid, .key = "crop") %>%
  mutate(pairs = map(crop, pair_crops)) %>%
  unnest()

