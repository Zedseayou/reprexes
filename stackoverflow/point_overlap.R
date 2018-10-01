library(ggplot2)
library(maps)
scenario <- subset(map_data("state"), region %in% c(
  "arizona", "new mexico", "texas", "oklahoma",
  "kansas", "missouri", "louisiana", "arkansas", "colorado", "nebraska"
))
set.seed(12345)
locations <- data.frame(
  LONG = runif(10, -115, -90),
  LAT = runif(10, 25, 40)
)

ggplot(data = scenario) +
  geom_polygon(
    mapping = aes(x = long, y = lat, group = group),
    fill = "palegreen",
    color = "black"
    ) +
  coord_fixed(1.3) +
  geom_point(
    data = locations,
    mapping = aes(x = LONG, y = LAT),
    fill = NA,
    size = 64,
    shape = 1
    )
