library(tidyverse)
data <- tibble(
  Plan = c("A","A","A","B","B","B","B"),
  Plan_Period = c(1,2,3,1,2,3,4),
  Plan_Elapsed_time = c(0.5,1,0.25,1,0.5,0.3,0.25),
  year = c(2016,2017,2018,2015,2016,2017,2018),
  Inflation = c(1.014,1.012,1.012,1.013,1.012, 1.080,1.020),
  Cost = c(10,20,30,40,40,50,60)
)

data %>%
  `colnames<-`(str_to_lower(colnames(.))) %>%
  mutate(deflate = inflation ^ plan_elapsed_time) %>%
  group_by(plan) %>%
  arrange(plan, desc(plan_period)) %>%
  mutate(
    cum_deflate = cumprod(deflate),
    real_cost = cost * cum_deflate
    ) %>%
  select(plan:cost, real_cost)
