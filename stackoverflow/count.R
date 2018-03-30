df <- data.frame(CustomerID    = c(1, 1, 1, 2, 2, 2),
                 Year = c(2012,2012,2013, 2014, 2015, 2016))
library(dplyr)
df %>%
  group_by(CustomerID) %>%
  summarise(yr_avg = n() / (max(Year) - min(Year) + 1))

df %>%
  group_by(CustomerID, Year) %>%
  summarise(count=n()) %>%
  summarise(AvgPerYear=mean(count))
