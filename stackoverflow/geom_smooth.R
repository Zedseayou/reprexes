set.seed(10)
start_date <- as.Date('2000-01-01')
end_date <- as.Date('2000-01-10')


Data <- data.frame(
  id = rep((1:1000),10),
  group = rep(c("A","B"), 25),
  x = sample(1:100),
  y = sample(c("1", "0"), 10, replace = TRUE),
  date = as.Date(
    sample(as.numeric(start_date):
             as.numeric(end_date), 1000,
           replace = T), origin = '2000-01-01'))

library(tidyverse)
Data %>%
  mutate(treated = factor(group)) %>%
  mutate(date = as.POSIXct(date)) %>% #convert date to date
  group_by(treated, date) %>% #group
  summarise(prop = sum(y=="1")/n()) %>% #calculate proportion
  ggplot() +
  theme_classic() +
  geom_smooth(aes(x = date, y = prop, color = treated), se = F) +
  geom_point(aes(x = date, y = prop, color = treated)) +
  geom_vline(xintercept = as.POSIXct("2000-01-05 12:00 GMT"), color = 'black', lwd = 1)

Data %>%
  mutate(treated = factor(group)) %>%
  mutate(y = ifelse(y == "0", 0, 1)) %>%
  mutate(date = as.POSIXct(date)) %>% #convert date to date
  ggplot() +
  theme_classic() +
  geom_smooth(aes(x = date, y = y, color = treated), method = "loess") +
  geom_vline(xintercept = as.POSIXct("2000-01-05 12:00 GMT"), color = 'black', lwd = 1)
