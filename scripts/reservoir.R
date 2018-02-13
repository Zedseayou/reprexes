library(tidyverse)
set.seed(123)
dat <- tibble(
  day = 1:100,
  demand = sample(0:17, size = 100,replace = T),
  supply = sample(2:9, size = 100,replace = T)
  )

balance <- dat$supply - dat$demand
reservoir <-  rep(200, nrow(dat))
reservoir[1] <- reservoir[1] + balance[1]
for (day in 2:nrow(dat)){
  reservoir[day] <- reservoir[day - 1] + balance[day]
}

out <- dat %>%
  bind_cols(balance =  balance, reservoir = reservoir) %>%
  mutate(net_deficit = ifelse(reservoir >= 0, 0, reservoir))
out[61:70, ]
