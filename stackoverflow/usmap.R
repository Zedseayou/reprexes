library(tidyverse)
library(usmap)
tbl <- structure(list(state = c("AK", "AL", "AR", "AZ", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "IA", "ID", "IL", "IN", "KS", "KY", "LA", "MA", "MD", "ME", "MI", "MN", "MO", "MS", "MT", "NC", "ND", "NE", "NH", "NJ", "NM", "NV", "NY", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VA", "VT", "WA", "WI", "WV", "WY", "DC"), subs = c(43L, 373L, 604L, 431L, 157L, 524L, 682L, 178L, 594L, 395L, 76L, 492L, 597L, 686L, 282L, 27L, 560L, 528L, 309L, 306L, 101L, 139L, 414L, 280L, 22L, 548L, 82L, 675L, 684L, 598L, 66L, 653L, 541L, 636L, 530L, 332L, 21L, 469L, 341L, 456L, 278L, 153L, 499L, 700L, 223L, 222L, 305L, 20L, 321L, 232L, 107L), income = c(81360L, 36595L, 51963L, 47673L, 56776L, 61959L, 37456L, 64224L, 56211L, 25183L, 44677L, 78116L, 35134L, 85910L, 81341L, 52409L, 75060L, 55098L, 56239L, 84138L, 37589L, 50006L, 88730L, 71527L, 34506L, 76364L, 89672L, 79442L, 42263L, 73869L, 65454L, 80625L, 60519L, 35125L, 60869L, 64727L, 86541L, 75562L, 50824L, 44414L, 26103L, 32962L, 61337L, 48314L, 25417L, 35721L, 34247L, 86608L, 64030L, 61089L, 37934L), party = c(0, 0, 1, 0.5, 1, 0, 0, 0.5, 0, 1, 0, 0.5, 0.5, 1, 1, 1, 0, 0, 0, 0, 1, 1, 0.5, 0, 0.5, 0.5, 1, 0, 0.5, 0, 1, 0, 1, 0, 0.5, 1, 1, 0, 0.5, 0.5, 1, 0.5, 0, 0.5, 0.5, 0, 0, 0, 1, 1, 0.5)), row.names = c(NA, -51L), class = c("tbl_df", "tbl", "data.frame"), spec = structure(list(cols = list(state = structure(list(), class = c("collector_character", "collector")), subs = structure(list(), class = c("collector_integer", "collector")), income = structure(list(), class = c("collector_integer", "collector")), party = structure(list(), class = c("collector_double", "collector"))), default = structure(list(), class = c("collector_guess", "collector"))), class = "col_spec"))

tbl %>%
  mutate(party = factor(party, labels = c("Republican", "Unknown", "Democrat"))) %>%
  plot_usmap(data = ., values = "party") +
  geom_text()
  scale_fill_discrete(name = "Political Affiliation Based on 2016 Election") +
  theme(legend.position = "right")

plot_usmap(data = tbl, values = "party") +
  scale_fill_discrete(
    name = "Political Affiliation Based on 2016 Election",
    label = scales::comma
    ) +
  theme(legend.position = "right")
