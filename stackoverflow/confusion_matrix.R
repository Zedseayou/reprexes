library(caret)
library(tidyverse)
data("GermanCredit")
cm <- confusionMatrix(GermanCredit$Class, sample(GermanCredit$Class))

cm$table %>%
  data.frame() %>%
  mutate(Prediction = factor(Prediction, levels = c("Good", "Bad"))) %>%
  group_by(Reference) %>%
  mutate(
    total = sum(Freq),
    frac = Freq / total,
    frac_fill = if_else(Prediction == Reference, Freq / total, 1 - (Freq / total))
    ) %>%
  ggplot(aes(Prediction, Reference, fill = frac_fill)) +
  geom_tile() +
  geom_text(aes(label = str_c(Freq, ", ", round(frac * 100), "%")), size = 8) +
  scale_fill_gradient(low = "#ea4434", high = "#badb33") +
  scale_x_discrete(position = "top") +
  geom_tile(color = "black", fill = "black", alpha = 0)
