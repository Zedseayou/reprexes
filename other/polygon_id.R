library(tidyverse)
library(sf)
load("~/Downloads/ann.withvisits.Rds")
ann.withvisits %>%
  mutate(polygon_groups = st_equals(.) %>% map_chr(~str_c(., collapse = ","))) %>%
  group_by(polygon_groups) %>%
  summarise(total_june_18 = sum(june18_visits))



eqgeo <- lapply(st_geometry(ann.withvisits$polygon_wkt), st_equals, st_geometry(ann.withvisits$polygon_wkt))
index <- lapply(eqgeo, unlist)
rows  <- Map(function(x,y) rep(x, length(y)),
             as.list(1:nrow(ann.withvisits)), index)
rowindex <- data.frame(x = unlist(rows),
                       y = unlist(index))
ann.withvisits$geometry_id <- NA
ann.withvisits$geometry_id[rowindex$y] <- rowindex$x
