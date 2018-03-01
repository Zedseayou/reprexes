library(maps)
library(mapdata)
maps::map(
  database = "worldHires",
  regions = c("uk", "ireland"),
  xlim = c(-12, 2),
  ylim = c(49, 59),
  col = "gray90",
  fill = TRUE
  )
