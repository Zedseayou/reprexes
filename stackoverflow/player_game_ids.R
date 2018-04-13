library(tidyverse)
df1 <- tibble(
  name = c("Ted","Bill","James","Randy","Mark","Jimmy","Eric","Allen"),
  team = c("Hawks","Tigers","Bears","Tigers","Lions","Bears","Hawks","Lions")
)
df2 <- tibble(
  name = c("Ted","Bill","Mark","Jimmy","Eric","James","Allen","Randy","Bill","James","Mark"),
  team = c("Hawks","Tigers","Lions","Bears","Hawks","Bears","Lions","Tigers","Tigers","Bears","Lions"),
  game_id = c("21","23","28","21","21","21","29","22","22","32","42")
)

df2 %>%
  add_count(team, game_id) %>%
  left_join(add_count(df1, team), by = c("name", "team")) %>%
  mutate(game_id = ifelse(n.x == n.y, game_id, NA)) %>%
  select(name:game_id)
