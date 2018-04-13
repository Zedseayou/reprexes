mock <- data.frame(person = seq(from=1, to=20),
                   group = rep(1:5, times=1, each=4),
                   baseline = rep(c(4, 6), times=2, each=1),
                   baselineStart = lubridate::ymd(rep(c("2018-06-04",
                                             "2018-07-02",
                                             "2018-07-30",
                                             "2018-09-03",
                                             "2018-10-01"),
                                           times=1,
                                           each=4)
                   ),
                   postBaseline = c(rep(20, 4),
                                    rep(20, 4),
                                    rep(20, 4),
                                    rep(20, 4),
                                    rep(c(18, 16), 2)
                   )
)

library(tidyverse)
full <- mock %>%
  mutate(obs = 1) %>%
  complete(person, obs = 1:(max(postBaseline) + 6)) %>%
  fill(group, baseline, baselineStart, postBaseline) %>%
  mutate(
    date = baselineStart + (7 * (obs - 1)),
    pb_dummy = ifelse(obs <= baseline, 0, 1)
  ) %>%
  filter(obs <= (baseline + postBaseline)) %>%
  select(person, group, date, obs, pb_dummy)

full[21:30, ]
