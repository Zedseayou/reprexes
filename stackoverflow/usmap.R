library(tidyverse)
library(sf)
library(fiftystater)
library(ggrepel)
tbl <- structure(list(state = c("AK", "AL", "AR", "AZ", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "IA", "ID", "IL", "IN", "KS", "KY", "LA", "MA", "MD", "ME", "MI", "MN", "MO", "MS", "MT", "NC", "ND", "NE", "NH", "NJ", "NM", "NV", "NY", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VA", "VT", "WA", "WI", "WV", "WY", "DC"), subs = c(43L, 373L, 604L, 431L, 157L, 524L, 682L, 178L, 594L, 395L, 76L, 492L, 597L, 686L, 282L, 27L, 560L, 528L, 309L, 306L, 101L, 139L, 414L, 280L, 22L, 548L, 82L, 675L, 684L, 598L, 66L, 653L, 541L, 636L, 530L, 332L, 21L, 469L, 341L, 456L, 278L, 153L, 499L, 700L, 223L, 222L, 305L, 20L, 321L, 232L, 107L), income = c(81360L, 36595L, 51963L, 47673L, 56776L, 61959L, 37456L, 64224L, 56211L, 25183L, 44677L, 78116L, 35134L, 85910L, 81341L, 52409L, 75060L, 55098L, 56239L, 84138L, 37589L, 50006L, 88730L, 71527L, 34506L, 76364L, 89672L, 79442L, 42263L, 73869L, 65454L, 80625L, 60519L, 35125L, 60869L, 64727L, 86541L, 75562L, 50824L, 44414L, 26103L, 32962L, 61337L, 48314L, 25417L, 35721L, 34247L, 86608L, 64030L, 61089L, 37934L), party = c(0, 0, 1, 0.5, 1, 0, 0, 0.5, 0, 1, 0, 0.5, 0.5, 1, 1, 1, 0, 0, 0, 0, 1, 1, 0.5, 0, 0.5, 0.5, 1, 0, 0.5, 0, 1, 0, 1, 0, 0.5, 1, 1, 0, 0.5, 0.5, 1, 0.5, 0, 0.5, 0.5, 0, 0, 0, 1, 1, 0.5)), row.names = c(NA, -51L), class = c("tbl_df", "tbl", "data.frame"), spec = structure(list(cols = list(state = structure(list(), class = c("collector_character", "collector")), subs = structure(list(), class = c("collector_integer", "collector")), income = structure(list(), class = c("collector_integer", "collector")), party = structure(list(), class = c("collector_double", "collector"))), default = structure(list(), class = c("collector_guess", "collector"))), class = "col_spec"))

names_abbs <- tibble(state.abb, state.name) %>%
  mutate(state.name = str_to_lower(state.name)) %>%
  add_row(state.abb = "DC", state.name = "district of columbia")

sf_fifty <- st_as_sf(fifty_states, coords = c("long", "lat")) %>%
  group_by(id, piece) %>%
  summarize(do_union = FALSE) %>%
  st_cast("POLYGON") %>%
  ungroup() %>%
  left_join(names_abbs, by = c("id" = "state.name")) %>%
  left_join(tbl, by = c("state.abb" = "state")) %>%
  mutate(
    party = factor(party, labels = c("Republican", "Unknown", "Democrat")),
    lon = map_dbl(geometry, ~st_centroid(.x)[[1]]),
    lat = map_dbl(geometry, ~st_centroid(.x)[[2]])
  )

labels <- sf_fifty %>%
  mutate(area = st_area(geometry)) %>%
  group_by(state.abb) %>%
  top_n(1, area) %>%
  mutate(text = str_c(str_to_title(id), "\n", subs, " subs, $", income))

ggplot(sf_fifty) +
  theme_minimal() +
  geom_sf(aes(fill = party)) +
  coord_sf(datum = NA) +
  geom_label_repel(
    data = labels,
    mapping = aes(label = text, x = lon, y = lat),
    size = 2
    ) +
  scale_fill_brewer(
    type = "diverging",
    palette = "RdYlBu",
    name = "Political Affiliation Based on 2016 Election"
    ) +
  theme(
    legend.position = "bottom",
    axis.title = element_blank()
    )

ggplot(labels, aes(x = income, y = subs)) +
  theme_minimal() +
  geom_point(aes(colour = party), size = 3) +
  scale_colour_discrete(name = "Political Affiliation Based on 2016 Election") +
  geom_text_repel(aes(label = state.abb)) +
  theme(legend.position = "bottom")


