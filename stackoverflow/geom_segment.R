library(tidyverse)
db4 <- data.frame(
  Rate = c(8, 4, 5, 5, 5, 4, 8, 7, 18, 15, 9, 8, 17, 19, 11, 11),
  Phase = c("A", "A", "A", "A", "A", "A", "A", "A", "B", "B", "B", "B", "B", "B", "B", "B"),
  Occasions = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
)

medians <- db4 %>%
  group_by(Phase) %>%
  summarise(
    y = median(Rate),
    x_start = min(Occasions),
    x_end = max(Occasions)
    )

ggplot(data = db4, aes(x = Occasions, y = Rate, color = Phase)) +
  geom_point() +
  geom_line() +
  geom_segment(
    data = medians,
    mapping = aes(x = x_start, xend = x_end, y = y, yend = y)
    ) +
  geom_vline(
    mapping = aes(xintercept = median(Occasions)),
    linetype = "dashed",
    color = "blue",
    size = 0.5
    ) +
  labs(x = "Occasions", y = "Ratings") +
  scale_colour_hue(labels = c("Baseline", "Intervention"))
