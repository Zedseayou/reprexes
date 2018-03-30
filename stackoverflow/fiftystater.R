library(tidyverse)
library(fiftystater)
library(viridis)

tbl <- state.x77 %>%
  as_tibble(rownames = "state") %>%
  bind_cols(state_name = state.abb) %>%
  rename(value_x = Income) %>%
  select(state_name, value_x)

state_abbs <- tibble(state = str_to_lower(state.name), abb = state.abb)

tbl_m <- left_join(tbl, state_abbs, by = c("state_name" = "abb")) %>%
  rename(id = state)

ggplot(tbl_m) +
  geom_map(map = fifty_states, aes(map_id = id, fill = value_x)) +
  expand_limits(x = fifty_states$long, y = fifty_states$lat) +
  coord_map() +
  geom_text(
    data = fifty_states %>%
      group_by(id) %>%
      summarise(lat = mean(c(max(lat), min(lat))),
                long = mean(c(max(long), min(long)))) %>%
      mutate(state = id) %>%
      left_join(tbl_m, by = c("state" = "id")),
    aes(x = long, y = lat, label = value_x )
    ) +
  scale_fill_viridis() +
  scale_x_continuous(breaks = NULL) +
  scale_y_continuous(breaks = NULL) +
  labs(x = "", y = "") + theme(legend.position = "bottom",
                               panel.background = element_blank())
