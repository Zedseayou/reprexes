library(tidyverse)
df <- data.frame(
  Pct_F = c(40, 50, 60, 70, 80, 90),
  Pct_B = c(50, 60, 70, 80, 90, 95),
  Time = c("Pre", "Pre", "Pre", "Post", "Post", "Post"),
  Variable = c("Var1", "Var2", "Var3", "Var1", "Var2", "Var3")
)

ggplot(df, aes(x = Variable)) +
  geom_col(aes(y = Pct_F, fill = Time), width = 0.5, position = "dodge") +
  geom_line(aes(y = Pct_B, group = Time, colour = Time), size = 2, position = position_dodge(0.5)) +
  scale_y_continuous(limits = c(0, 100)) +
  coord_flip() +
  labs(title = "Test Chart", x = "", y = "Percent", caption = "(Note: Bars refer to Pct_F and lines refer to Pct_B)")

ggplot(df, aes(x = Variable)) +
  # geom_col(aes(y = Pct_F, fill = Time), width = 0.5, position = "dodge") +
  geom_line(aes(y = Pct_B, group = Time, colour = Time))
