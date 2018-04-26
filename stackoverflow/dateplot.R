library(tidyverse)
A <- structure(list(start..yyyy.mm. = c(197901L, 197901L, 197901L,197901L, 197901L), X.yyyy.mm. = c(197901L, 197904L, 197908L,197902L, 197902L), duration = c(1L, 4L, 8L, 2L, 2L), area..km.2. = structure(c(1L,2L, 4L, 3L, 5L), .Label = c("46952.85", "c(125267.7, 72379.43, 72468.91, 13200.26)","c(19814.74, 39570.96)", "c(26513.05, 26513.05, 26513.05, 26513.05, 26513.05, 19898.57, 26513.05, 26513.05)","c(52291.77, 52291.77)"), class = "factor")), .Names = c("start..yyyy.mm.","X.yyyy.mm.", "duration", "area..km.2."), class = "data.frame", row.names = c(NA,-5L))

tbl <- A %>%
  mutate(start = seq.Date(as.Date("1979-01-01"), by = "year", length.out = 5)) %>%
  select(start, duration, area = area..km.2.) %>%
  rowid_to_column() %>%
  separate_rows(area) %>%
  filter(!area %in% c("c", ""))

indices <- seq(nrow(tbl)) %>%
  split(group_indices(tbl, rowid)) %>%
  map(~ c(.x, NA)) %>%
  unlist()

tbl <- tbl[indices, ] %>%
  fill(rowid, start, duration, area) %>%
  group_by(rowid) %>%
  mutate(
    date = seq.Date(
      from = first(start),
      by = "month",
      length.out = first(duration) + 1
    ),
    area = as.numeric(area)
  ) %>%
  ungroup()

ggplot(tbl) +
  geom_ribbon(aes(x = date, fill = factor(rowid), ymax = 1, ymin = 0))

ggplot(tbl) +
  geom_area(
    mapping = aes(x = date, y = area, fill = factor(rowid)),
    alpha = 0.3,
    position = "identity"
    ) +
  scale_x_date(limits = c(as.Date("1979-01-01"), Sys.Date()))
