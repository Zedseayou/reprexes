library(tidyverse)
library(magrittr)
library(sf)
hospital <- tibble(
  longitude = c(80.15998, 72.89125, 77.65032, 77.60599),
  latitude = c(12.90524, 19.08120, 12.97238, 12.90927)
  )
people <- tibble(
  longitude = c(72.89537, 77.65094, 73.95325, 72.96746, 77.65058,
                77.66715, 77.64214, 77.58415, 77.76180, 76.65470,
                76.65480, 76.65490, 76.65500, 76.65560, 76.65560),
  latitude = c(19.07726, 13.03902, 18.50330, 19.16764, 12.90871,
               13.01693, 13.00954, 12.92079, 13.02212, 12.81447,
               12.81457, 12.81467, 12.81477, 12.81487, 12.81497)
  )

hospital_sf <- hospital %>%
  st_as_sf(coords = c("longitude", "latitude")) %>%
  st_set_crs(4326) %>%
  st_transform(3395)

people_sf <- people %>%
  st_as_sf(coords = c("longitude", "latitude")) %>%
  st_set_crs(4326) %>%
  st_transform(3395)

distances <- st_distance(people_sf, hospital_sf) %>%
  as.numeric() %>%
  matrix(15, 4) %>%
  as_tibble()

distances %>%
  mutate_at(vars(V1:V4), function (x) x > 2000) %>%
  bind_cols(
    .,
    within_2km = pmap_lgl(
      list(.data$V1, .data$V2, .data$V3, .data$V4),
      all(..1, ..2, ..3, ..4)
    )
  )
