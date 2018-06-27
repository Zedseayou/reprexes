library(tidyverse)
df <-  tibble(
  year = c(rep(2013, 4), rep(2014, 4), rep(2015, 3)),
  quarter = c(rep(c("Q1", "Q2", "Q3", "Q4"), 2), c("Q1", "Q2", "Q3")),
  Miss = c(5, 3, 7, 4, 6, 5.7, 12, 15, 20, 33, 42),
  Meet = c(100-40-5, 100-37-3, 100-29-7,100-28-4,
           100-20-6, 100-29-5.7, 100-27-12, 100-25-15,
           100-13-20, 100-5-33, 100-12-42),
  Exceed = c(40, 37, 29, 28, 20, 29, 27, 25, 13, 5, 12)
)
footnote = "Data source: XYZ Dashboard; the total number of projects has increased over time from 230 in early 2013 to nearly 270 in Q3 2015."
textbox = "As of Q3 2015, more than 1/3\nof projects are missing goals"
title = "Goal attainment over time"
y_label = "% of total projects"

tbl <- df %>%
  gather("category", "value", Miss:Exceed) %>%
  mutate(
    quarter = parse_factor(quarter, levels = c("Q1", "Q2", "Q3", "Q4")),
    category = parse_factor(category, levels = c("Exceed", "Meet", "Miss"))
  )

ggplot(tbl, aes(x = quarter, y = value)) +
  theme_minimal() +
  geom_col(aes(fill = category)) +
  geom_text(
    data = . %>%
      mutate(
        text = str_c(value, "%"),
        text = case_when(
          category != "Miss"                        ~ "",
          year == 2013                              ~ "",
          year == 2014 & quarter %in% c("Q1", "Q2") ~ "",
          TRUE                                      ~ text
        )
      ),
    mapping = aes(label = text, y = value - 4),
    position = "stack",
    col = "white"
    ) +
  facet_wrap(~ year, strip.position = "bottom") +
  scale_fill_manual(values = c("#777777", "#A3A3A1", "#7F141A")) +
  scale_y_continuous(
    breaks = seq(0, 100, 10),
    labels = function(x) str_c(x, "%"),
    expand = c(0, 0)
    ) +
  labs(
    title = title,
    x = "",
    y = y_label,
    # subtitle = textbox,
    caption = footnote,
    fill = NULL
  ) +
  theme(
    text = element_text(colour = "#888888"),
    axis.line = element_line(colour = "#E3E3E3"),
    axis.title.y = element_text(hjust = 1),
    legend.justification = "left",
    legend.position = "top",
    panel.grid = element_blank(),
    plot.title = element_text(hjust = 0),
    plot.subtitle = element_text(hjust = 1),
    plot.caption = element_text(hjust = 0.5, size = 7.5, colour = "#D0D0D0"),
    strip.placement = "outside"
  ) +
  guides(fill = guide_legend(reverse = TRUE, keywidth = 0.6, keyheight = 0.6))
