library(tidyverse)
library(lubridate)
tbl <- tibble(
  day = seq.Date(ymd("2016-01-01"), ymd("2017-01-01"), by = 1)
) %>%
  mutate(temp = rnorm(nrow(.), mean = 0, sd = 15))

ggplot(tbl) +
  geom_line(aes(x = day, y = temp), color="#D55E00") +
  scale_x_date(date_breaks = "1 month", date_labels = "%d-%b", expand = c(0,0))


ggplot() +
  geom_line(
    mapping = aes(    x=clim2016$timestep,
    y=clim2016$Mean_Temp),
                   color="#D55E00", fill="#0072B2")+ylim(-30,30)+
  (scale_x_datetime(labels = date_format("%d-%b"),
                    limits = c(as.POSIXct("2016-01-01"),
                               as.POSIXct("2016-12-31")),expand = c(0,0),
                    date_breaks="months"))


clim <- ggplot() +
  geom_line(
    aes(x=clim2016$timestep, y=clim2016$Mean_Temp),
    color="#D55E00",
    fill="#0072B2"
    ) +
  ylim(-30,30) +
  scale_x_datetime(
    labels = date_format("%d-%b"),
    limits = c(as.POSIXct("2016-01-01"), as.POSIXct("2016-12-31")),
    expand = c(0,0),
    date_breaks="months")
