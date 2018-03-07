library(tidyverse)
tbl <- read_csv(
  "Participant,ImageName,GazeOrder,,,,,,,,,,,,,,,,,,,,,,,,,,
Person1, fiveobjectsrandom3.jpg, A, A, S, S, P, X, N, N, R,,,,,,,,,,,,,,,,,,
Person2, fiveobjectsrandom2.jpg, S, S, S, S, R, R, P, R,,,,,,,,,,,,,,,,,,,
Person3, fiveobjectsrandom4.jpg, N, N, S, S, R, R, R, A, P, P, "
)

tidy_tbl <- tbl %>%
  gather("colname", "letter", -Participant, -ImageName, na.rm = TRUE) %>%
  mutate(
    colname = ifelse(colname == "GazeOrder", "X3", colname),
    gaze_order = as.integer(str_sub(colname, 2, -1)) - 2
  ) %>%
  count(gaze_order, letter) %>%
  complete(gaze_order, letter, fill = list(n = 0))

ggplot(tidy_tbl) +
  geom_line(aes(x = gaze_order, y = n, colour = letter)) +
  scale_x_continuous(breaks = 1:10) +
  scale_colour_discrete(name = "Letter") +
  labs(
    x = "Gaze Order",
    y = "Count",
    title = "Count of letters by gaze order"
    )
