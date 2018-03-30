library(tidyverse)
df0 <- tibble(x = 1:3, y = rnorm(3))
df1 <- tibble(x = 1:3, y = rnorm(3))
df2 <- tibble(x = 1:3, y = rnorm(3))

animalFrames <- tibble(animals = c('sheep', 'cow', 'horse'),
                       frames = list(df0, df1, df2))

animalFrames %>%
  walk2(
    .x = .$animals,
    .y = .$frames,
    .f = ~ write_csv(.y, str_c("test_", .x, ".csv"))
  )

library(magrittr)
animalFrames %$%
  walk2(
    .x = animals,
    .y = frames,
    .f = ~ write_csv(.y, str_c("test_", .x, ".csv"))
  )
