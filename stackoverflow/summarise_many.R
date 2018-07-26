library(tidyverse)

my_dataframe <- structure(list(id = c(10138L, 9466L, 9360L, 9360L), firstName = c("Alex", "Quincy", "Luke", "Luke"), lastName = c("Abrines", "Acy", "Babbitt", "Babbitt"), currentInjuryPlayingProbability = c(NA_character_, NA_character_, NA_character_, NA_character_), teamId = c(96L, 84L, 91L, 92L), teamAbbreviation = c("OKL", "BRO", "ATL", "MIA"), fg2PtAtt = c(70L, 73L, 57L, 2L), fg3PtAtt = c(221L, 292L, 111L, 45L), minSeconds = c(67637L, 81555L, 34210L, 8676L)), row.names = c(NA, -4L), class = c("tbl_df", "tbl", "data.frame"))

my_dataframe %>%
  group_by_at(.vars = vars(id:lastName)) %>%
  {left_join(
    summarise_at(., vars(teamId:teamAbbreviation), ~ str_c(., collapse = ",")),
    summarise_at(., vars(fg2PtAtt:minSeconds), mean)
  )}

my_dataframe %>%
  rename_at(vars(id:lastName), ~ str_c("group_", .)) %>%
  rename_at(vars(teamId:teamAbbreviation), ~ str_c("paste_", .)) %>%
  rename_at(vars(fg2PtAtt:minSeconds), ~ str_c("mean_", .)) %>%
  group_by_at(vars(starts_with("group"))) %>%
  summarise_all(funs(mean, str_c(., collapse = ","))) %>%
  select_if(vars(matches("^group|")))
