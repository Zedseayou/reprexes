library(tidyverse)
df <- structure(list(name = c("Kanye West", "Chris Evans", "Robert Jr", "Bruce Wayne", "Peter Parker", "Steven Strange", "Danny rand", "Daniel Fisher", "Rob Son", "Son Bob", "Chun Li", "Ching Do", "Ping Pong", "Michael Jackson", "Rich Brian", "Ryan Gosling", "Nathan Nguyen", "Justin Bieber"), group = c(1L, 1L, 1L, 2L, 2L, 2L, 2L, 2L, 3L, 3L, 3L, 3L, 3L, 4L, 4L, 4L, 4L, 4L)), class = c("tbl_df", "tbl", "data.frame"), row.names = c(NA, -18L))
df %>%
  mutate(
    to_judge = map_int(
      .x = group,
      .f = ~ sample(
        x = unique(group)[unique(group) != .x],
        size = 1
      )
    )
  )
