library(tidyverse)
tbl <- tibble(
  id = 1:8,
  time = c("2017-05-12 18:34:20",
           "2017-05-12 18:37:07",
           "2017-05-12 18:37:10",
           "2017-05-12 18:37:59",
           "2017-05-12 18:38:40",
           "2017-05-12 18:40:40",
           "2017-05-12 18:40:49",
           "2017-05-12 18:43:40"
           )
)

tbl2 <- tbl %>%
  mutate(time = ymd_hms(time)) %>%
  mutate(separation = time - lag(time, default = 0)) %>%
  mutate(onemin = separation <= 60)

group_ids = 1
for (i in 2:nrow(tbl2)){
  if (tbl2$onemin[i] == FALSE){
    group_ids[i] <- group_ids[i - 1] +1
  } else
  group_ids[i] <- group_ids[i - 1]
}

tbl2 %>%
  bind_cols(., group = group_ids) %>%
  select(id, time, group)
