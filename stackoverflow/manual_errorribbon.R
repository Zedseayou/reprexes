library(tidyverse)
set.seed(12345)
eat <- sample(1:7, size = 30, replace = T)
df <- data.frame(
  Condition = rep(c(0, 1), each = 15),
  time = c(1, 2, 3, 4, 5),
  eat = eat
)
df$Condition <- as.factor(df$Condition)

ggplot(df, aes(x = time, y = eat, fill = Condition)) +
  geom_point(size = 4, shape = 21, colour = "black") +
  stat_summary(geom = "ribbon", fun.data = mean_se, alpha = 0.2) +
  stat_summary(
    mapping = aes(colour = Condition),
    geom = "line",
    fun.y = mean,
    show.legend = FALSE
    )
