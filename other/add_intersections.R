library(tidyverse)
test_df <- tibble(
  x = 1:5,
  a = c(1, 4, 2, 3, 5),
  b = c(2, 3, 5, 1, 4)
)

line_intersection <- function(row1, row2){
  x1 <- row1[1]; a1 <- row1[2]; b1 <- row1[3]
  x2 <- row2[1]; a2 <- row2[2]; b2 <- row2[3]
  if ((a1 > b1 & a2 > b2) | (a1 < b1 & a2 < b2)) {
    return(NULL)
  } else {
    d_xab <- row2 - row1
    dx <- d_xab[1]; da <- d_xab[2]; db <- d_xab[3]
    xp <- ((a1 - b1) / ((db / dx) - (da / dx))) + x1
    yp <- (db / dx) * (xp - x1) + b1
    return(c(xp, yp))
  }
}

add_intersections <- function(df, ...){
  cols <- enquos(...)
  names <- map_chr(cols, rlang::quo_name)
  rows <- df %>%
    select(!!!cols) %>%
    pmap(~ c(..1, ..2, ..3))
  intersections = map2(
    .x = rows[1:(length(rows) - 1)],
    .y = rows[2:length(rows)],
    .f = line_intersection
  ) %>%
    discard(is.null) %>%
    map(~ append(.x, .x[2])) %>%
    transpose %>%
    map(simplify) %>%
    set_names(names) %>%
    as_tibble
  df %>%
    bind_rows(intersections) %>%
    arrange(!!(cols)[[1]])
}

plot_between <- function(df, x_col, y_col1, y_col2){
  x <- enquo(x_col); y1 <- enquo(y_col1); y2 <- enquo(y_col2)
  line_plot <- df %>%
    gather(var, val, !!y1, !!y2) %>%
    ggplot() +
    geom_line(aes(x = !!x, y = val, colour = var), size = 0.1)

  ribbon_data <- df %>%
    add_intersections(!!x, !!y1, !!y2) %>%
    bind_rows(filter(., !!y1 == !!y2)) %>%
    arrange(!!x) %>%
    mutate(group = cumsum(!!x == lag(!!x, default = 0))) %>%
    group_by(group) %>%
    mutate(
      top = pmax(!!y1, !!y2),
      bot = pmin(!!y1, !!y2),
      pos = any(!!y1 < !!y2)
    ) %>%
    split(.$group)

  out_plot <- line_plot
  for (group in ribbon_data){
    out_plot <- out_plot +
      geom_ribbon(
        data = group,
        mapping = aes(x = !!x, ymax = top, ymin = bot, fill = pos),
        alpha = 0.5
      )
  }
  out_plot
}
plot_between(test_df, x, a, b)

economics_long %>%
  filter(variable %in% c("psavert", "unemploy")) %>%
  select(-value) %>%
  spread(variable, value01) %>%
  mutate(date = as.integer(date - as.Date("1967-07-01"))) %>%
  plot_between(date, psavert, unemploy)

library(sf)
test_sf <- test_df %>%
  gather(line, y, a, b) %>%
  st_as_sf(coords = c("x", "y")) %>%
  group_by(line) %>%
  summarise() %>%
  st_cast("LINESTRING")

intersections <- test_sf %>%
  st_intersection() %>%
  filter(st_is(., "MULTIPOINT"))
