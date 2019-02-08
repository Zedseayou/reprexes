library(tidyverse)
bin_boundaries <- function(tbl, n_bins, x_var, y_var, ...) {
  x_var <- enquo(x_var)
  y_var <- enquo(y_var)
  bin_bounds <-  seq(
    from = min(pull(tbl, !!x_var)),
    to = max(pull(tbl, !!x_var)),
    length.out = n_bins + 1)
  bounds_tbl <- tbl %>%
    mutate(bin_group = ntile(!!x_var, n_bins)) %>%
    group_by(bin_group) %>%
    summarise(!!y_var := mean(!!y_var)) %>%
    mutate(bin_start = bin_bounds[1:n_bins], bin_end = bin_bounds[2:(n_bins + 1)])
  geom_segment(
    data = bounds_tbl,
    mapping = aes(
      x = bin_start, y = !!y_var,
      xend = bin_end, yend = !!y_var
    ),
    ...
  )
}

ggplot(midwest) +
  geom_point(aes(x = percollege, y = percbelowpoverty)) +
  bin_boundaries(midwest, 10, percollege, percbelowpoverty, colour = "red", size = 1)