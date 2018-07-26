Mydata <- data.frame(
  attr = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10),
  type = c(1, 3, 1, 1, 1, 5, 1, 1, 8, 1)
)
split(Mydata, cumsum(Mydata$type != 1))
