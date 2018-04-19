library(tidyverse)
library(broom)
library(betareg)
library(segmented)

tbl <- structure(list(map_score = c(
  145L, 156L, 158L, 159L, 162L, 164L,
  165L, 167L, 169L, 170L, 172L, 173L, 174L, 175L, 176L, 177L, 178L,
  179L, 180L, 181L, 182L, 183L, 184L, 185L, 186L, 187L, 188L, 189L,
  190L, 191L, 192L, 193L, 194L, 195L, 196L, 197L, 198L, 199L, 200L,
  201L, 202L, 203L, 204L, 205L, 206L, 207L, 208L, 209L, 210L, 211L,
  212L, 213L, 214L, 215L, 216L, 217L, 218L, 219L, 220L, 221L, 222L,
  223L, 224L, 225L, 226L, 227L, 228L, 229L, 230L, 232L, 233L, 243L
), mean = c(
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.0833333333333333, 0.0714285714285714,
  0, 0, 0.0769230769230769, 0.0833333333333333, 0, 0, 0, 0, 0,
  0.142857142857143, 0.0476190476190476, 0.222222222222222, 0.222222222222222,
  0.16, 0.263157894736842, 0.285714285714286, 0.375, 0.260869565217391,
  0.5, 0.473684210526316, 0.545454545454545, 0.588235294117647,
  0.428571428571429, 0.705882352941177, 0.727272727272727, 0.6,
  0.6, 0.692307692307692, 0.75, 0.666666666666667, 0.625, 0.333333333333333,
  0.666666666666667, 1, 1, 1, 1, 1, 1, 1, 1, 1
)), .Names = c(
  "map_score",
  "mean"
), row.names = c(NA, -72L), class = c(
  "tbl_df", "tbl",
  "data.frame"
), spec = structure(list(cols = structure(list(map_score = structure(list(), class = c(
  "collector_integer",
  "collector"
)), mean = structure(list(), class = c(
  "collector_double",
  "collector"
))), .Names = c("map_score", "mean")), default = structure(list(), class = c(
  "collector_guess",
  "collector"
))), .Names = c("cols", "default"), class = "col_spec"))

seg <- tibble(
  method = "segmented",
  mean = tbl$mean,
  map_score = tbl$map_score,
  .fitted = segmented(
    obj = lm(mean ~ map_score, data = tbl),
    seg.Z = ~ map_score,
    psi = c(170, 220)
  ) %>%
    predict()
)
preds <- tbl %>%
  do(
    linear = lm(mean ~ map_score, data = .),
    square = lm(
      formula = mean ~ map_score + map_score2,
      data = mutate(., map_score2 = map_score ^ 2)
    ),
    # logit = glm(mean ~ map_score, family = binomial(link = "logit"), data = .),
    beta = betareg(
      formula = mean ~ map_score,
      data = mutate(., mean = (mean * (n() - 1) + 0.5) / n())),
    loess = loess(mean ~ map_score, data = .)
  ) %>%
  gather("method", "model", everything()) %>%
  rowwise() %>%
  augment(model) %>%
  ungroup() %>%
  bind_rows(seg)

ggplot(preds, aes(x = map_score)) +
  geom_point(aes(y = mean)) +
  geom_line(
    data = mutate(
      .data = preds,
      .fitted = case_when(
        .fitted > 1 ~ 1,
        .fitted < 0 ~ 0,
        TRUE ~ .fitted
      )
    ),
    mapping = aes(y = .fitted, colour = method),
    size = 1.5
  )

tibble(
  x = seq(0.499, 0.501, by = 0.0001)
) %>%
  mutate(y = (x * (n() - 1) + 0.5) / n()) %>%
  ggplot() +
  geom_line(aes(x = x, y = y), col = "red") +
  geom_line(aes(x = x, y =x), col = "blue")

preds %>%
  select(method, mean, map_score, .fitted) %>%
  mutate(
    .fitted = case_when(
      .fitted > 1 ~ 1,
      .fitted < 0 ~ 0,
      TRUE ~ .fitted
    )
  ) %>%
  mutate(rmse = (.fitted - mean) ^ 2) %>%
  group_by(method) %>%
  summarise(rmse = sqrt(mean(rmse)))

#> Warning: Removed 72 rows containing missing values (geom_point).

#' ![](file663033255806_reprex_files/figure-markdown_strict/reprex-body-1.png)

#' Created on 2018-04-19 by the [reprex package](http://reprex.tidyverse.org) (v0.2.0).
