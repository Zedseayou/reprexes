my_letters <- c("A", "B", "C", "D")
n_vectors <- 100
indexes_vectors <- seq_len(n_vectors)

mtx <- sapply(
  indexes_vectors,
  function(i) sample(my_letters, n_vectors, replace = TRUE)
)
rownames(mtx) <- indexes_vectors

df <- as.data.frame(t(combn(indexes_vectors, m = 2))) %>%
  `colnames<-`(c("index_1", "index_2"))

library(tidyverse)
microbenchmark(
  "original" = {
    df_old <- df
    for (l in my_letters) {
      # cat(l, "\n")
      df_old[, l] <- apply(
        df_old[, 1:2], 1,
        function(ids) {
          sum(mtx[ids[1], ] == mtx[ids[2], ] &
                mtx[ids[1], ] == l, na.rm = TRUE)
        }
      )
    }
  },
  "map2_int" = {
    mtx_tbl <- mtx %>%
      t() %>%
      as.character() %>%
      tibble(
        row = rep(1:n_vectors, each = n_vectors),
        letters = .
      ) %>%
      nest(letters, .key = "letters")
    df_new <- df %>%
      as_tibble() %>%
      left_join(mtx_tbl, by = c("index_1" = "row")) %>%
      left_join(mtx_tbl, by = c("index_2" = "row")) %>%
      rename(row_1 = letters.x, row_2 = letters.y) %>%
    bind_cols(
      A = map2_int(.$row_1, .$row_2, ~ sum(.x == "A" & .x == .y)),
      B = map2_int(.$row_1, .$row_2, ~ sum(.x == "B" & .x == .y)),
      C = map2_int(.$row_1, .$row_2, ~ sum(.x == "C" & .x == .y)),
      D = map2_int(.$row_1, .$row_2, ~ sum(.x == "D" & .x == .y))
    )
  },
  "function" = {
    count_rowpairs <- function(matrix, df, letters){
      my_letters <- letters
      df_old <- df
      for (l in my_letters) {
        df_old[, l] <- apply(
          df_old[, 1:2],
          1,
          function(ids) {
            sum(matrix[ids[1], ] == matrix[ids[2], ] &
                  matrix[ids[1], ] == l, na.rm = TRUE)
          }
        )
      }
      df_old
    }
    count_rowpairs(mtx, df, my_letters)
  }
)

cppFunction()

count_rowpairs <- function(matrix, df, letters){
  my_letters <- letters
  df_old <- df
  for (l in my_letters) {
    for (r in 1:nrow(df)){
      df
    }

    df_old[, l] <- apply(
      df_old[, 1:2],
      1,
      function(ids) {
        sum(matrix[ids[1], ] == matrix[ids[2], ] &
              matrix[ids[1], ] == l, na.rm = TRUE)
      }
    )
  }
  df_old
}
