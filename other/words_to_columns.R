library(tidyverse)

fives <- sentences %>%
  `[`(str_count(., "\\s") == 5)
name_bind <- function(strings) {
  wordlist <- strings %>% str_split("\\s") %>% map(~ set_names(., c("W1", "W2", "W3", "W4", "W5", "W6")))
  bind_rows(!!!wordlist)
}
bench::mark(
  name_bind(fives),
  fives %>% enframe(name = NULL) %>% separate(value, into = c("W1", "W2", "W3", "W4", "W5", "W6"), "\\s"),
  fives %>%
    str_split("\\s") %>%
    transpose() %>%
    map(unlist) %>%
    set_names(c("W1", "W2", "W3", "W4", "W5", "W6")) %>%
    as_tibble(),
  fives %>%
    str_split("\\s") %>%
    map_dfr(~ as.data.frame(matrix(., nrow = 1, dimnames = list(NULL, c("W1", "W2", "W3", "W4", "W5", "W6")))))
)

unnest_vec1 <- function(tbl, column, colnames) {
  column <- enquo(column)
  tbl %>%
    rowid_to_column %>%
    unnest(!!column) %>%
    group_by(rowid) %>%
    mutate(cn = colnames) %>%
    spread(cn, !!column) %>%
    ungroup() %>%
    select(-rowid)
}

unnest_vec2 <- function(tbl, column, colnames) {
  column <- enquo(column)
  tbl %>%
    mutate(!!column := map(
      .x = !!column,
      .f = . %>%
        `names<-`(colnames) %>%
        enframe %>%
        spread(name, value))
    ) %>%
    unnest(!!column)
}

unnest_vec3 <- function(tbl, column, colnames) {
  column <- enquo(column)
  tbl %>%
    mutate(!!column := map(
      .x = !!column,
      .f = . %>%
        matrix(nrow = 1, dimnames = list(NULL, colnames)) %>%
        as.data.frame(stringsAsFactors = FALSE))
    ) %>%
    unnest(!!column)
}

unnest_vec4 <- function(tbl, column, colnames) {
  column <- enquo(column)
  tbl %>%
    mutate(!!column := map(
      .x = !!column,
      .f = . %>%
        str_c(collapse = "_")
    )) %>%
    separate(!!column, into = colnames, sep = "_")
}

unnest_vec5 <- function(tbl, column, colnames) {
  column <- enquo(column)
  suppressMessages(
    out_tbl <- tbl %>%
      unnest_wider(!!column)
  )
  names(out_tbl)[(ncol(out_tbl) - length(colnames) + 1):(ncol(out_tbl))] <- colnames
  return(out_tbl)
}

unnest_vec5(fives_tbl, sentences, c("W1", "W2", "W3", "W4", "W5", "W6"))

fives_tbl <- tibble(sentences = fives %>% str_split("\\s"))
bench::mark(
  v1 = unnest_vec1(fives_tbl, sentences, c("W1", "W2", "W3", "W4", "W5", "W6")),
  v2 = unnest_vec2(fives_tbl, sentences, c("W1", "W2", "W3", "W4", "W5", "W6")),
  v3 = unnest_vec3(fives_tbl, sentences, c("W1", "W2", "W3", "W4", "W5", "W6")),
  v4 = unnest_vec4(fives_tbl, sentences, c("W1", "W2", "W3", "W4", "W5", "W6")),
  v5 = unnest_vec5(fives_tbl, sentences, c("W1", "W2", "W3", "W4", "W5", "W6"))
)

fives_tbl %>%
  unnest_wider(sentences)
