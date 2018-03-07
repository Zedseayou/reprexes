df1 <- structure(list(dummy1 = c(0L, 1L, 0L, 0L), dummy2 = c(1L, 0L,
                                                             1L, 0L), dummy3 = c(0L, 0L, 0L, 1L), ed1 = c(1, 0, 1, 0), ed2 = c(0,
                                                                                                                               1, 0, 1), id = c(1, 2, 3, 4)), .Names = c("dummy1", "dummy2",
                                                                                                                                                                         "dummy3", "ed1", "ed2", "id"), row.names = c(NA, -4L), class = "data.frame")
library(tidyverse)
df1 %>%
  mutate_at(vars(dummy1:dummy3, ed1:ed2), ~ ifelse(. == 0, NA, .)) %>%
  gather("dummy", "present", dummy1:dummy3, na.rm = TRUE) %>%
  gather("ed", "present2", ed1:ed2, na.rm = TRUE) %>%
  select(-present, -present2)
