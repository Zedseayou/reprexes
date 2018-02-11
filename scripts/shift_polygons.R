library(tidyverse)
library(sf)
library(USAboundaries)

# Define regions
padd1 <- c("CT", "ME", "MA", "NH", "RI", "VT", "NJ", "NY", "PA")
padd2 <- c("IL", "IN", "MI", "OH", "WI", "IA", "KS", "MN", "MO", "NE", "ND",
           "SD")
padd3 <- c("DE", "FL", "GA", "MD", "NC", "SC", "VA", "DC", "WV", "AL", "KY",
           "MS", "TN", "AR", "LA", "OK", "TX")
padd4 <- c("AK", "CA", "HI", "OR", "WA", "AZ", "CO", "ID", "MT", "NV", "NM",
           "UT", "WY")

us_map <- us_states() %>%
  select(state_abbr)

cities <- read_csv(here::here("data", "cities.csv")) %>%
  mutate(Long = -Long) %>%
  st_as_sf(coords = 3:2) %>%
  st_set_crs(4326) %>%
  rename(state_abbr = StateAbbr)

combined <- rbind(us_map, cities) %>%
  filter(!(state_abbr %in% c("AK", "HI", "PR"))) %>%
  mutate(
    region = case_when(
      state_abbr %in% padd1 ~ "PADD 1: East Coast",
      state_abbr %in% padd2 ~ "PADD 2: Midwest",
      state_abbr %in% padd3 ~ "PADD 3: Gulf Coast",
      state_abbr %in% padd4 ~ "PADD 4: West Coast"
    )
  )

eastc <- combined %>%
  filter(region == "PADD 1: East Coast") %>%
  st_set_geometry(., .$geometry + c(5, 0))
mwest <- combined %>%
  filter(region == "PADD 2: Midwest") %>%
  st_set_geometry(., .$geometry + c(0, 0))
gulfc <- combined %>%
  filter(region == "PADD 3: Gulf Coast") %>%
  st_set_geometry(., .$geometry + c(0, -3))
westc <- combined %>%
  filter(region == "PADD 4: West Coast") %>%
  st_set_geometry(., .$geometry + c(-10, -2))

ggplot(data = rbind(eastc, mwest, gulfc, westc)) +
  theme_bw() +
  geom_sf(aes(fill = region))
