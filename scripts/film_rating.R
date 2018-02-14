library(tidyverse)
library(magrittr)
tidy_cr <- cr %>%
  select(-Mean, -Pearson, -PearsonABS) %>%
  gather("film", "rating", -User) %>%
  rename(user = User) %>%
  group_by(user) %>%
  mutate(mean = mean(rating, na.rm = TRUE)) %>%
  ungroup()

top_recs <- function(tbl, person, n){
  films_not_seen <- tbl %>%
    filter(user == person & is.na(rating)) %>%
    extract2("film")
  persons_ratings <- tbl %>%
    filter(user == person) %>%
    extract2("rating")
  correlations <- tbl %>%
    group_by(user) %>%
    mutate(
      pearson = cor(rating, persons_ratings, use = "complete.obs"),
      pearson_abs = abs(pearson)
    ) %>%
    ungroup()
  recommendations <- correlations %>%
    filter(film %in% films_not_seen) %>%
    group_by(film) %>%
    summarise(
      score = sum((rating - mean) * pearson, na.rm = TRUE) /
        (sum(pearson_abs) - 1)
    ) %>%
    mutate(score = score + mean(persons_ratings, na.rm = TRUE)) %>%
    arrange(desc(score)) %>%
    head(n)
}
top_recs(tidy_cr, "Bernard", 8) %>% print()


v_films_not_seen <- tidy_cr %>%
  filter(user == "Victoria" & is.na(rating)) %>%
  magrittr::extract2("film")

v_persons_ratings <- tidy_cr %>%
  filter(user == "Victoria") %>%
  magrittr::extract2("rating")

v_correlations <- tidy_cr %>%
  group_by(user) %>%
  mutate(
    pearson = cor(rating, v_persons_ratings, use = "complete.obs"),
    pearson_abs = abs(pearson)
  ) %>%
  ungroup()

v_recommendations <- v_correlations %>%
  filter(film %in% v_films_not_seen) %>%
  group_by(film) %>%
  summarise(
    score = sum((rating - mean) * pearson, na.rm = TRUE) /
      (sum(pearson_abs) - 1)
            ) %>%
  mutate(score = score + mean(v_persons_ratings, na.rm = TRUE)) %>%
  arrange(desc(score)) %>%
  head(5)
