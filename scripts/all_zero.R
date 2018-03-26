dat <- structure(list(`A-XXX` = c(1.51653275922944, 0.077037240321129,
                                  0), `fBM-XXX` = c(2.22875185527511, 0, 0), `P-XXX` = c(1.73356698481106,
                                                                                         0, 0), `vBM-XXX` = c(3.00397859609183, 0, 0)), .Names = c("A-XXX",
                                                                                                                                                   "fBM-XXX", "P-XXX", "vBM-XXX"), row.names = c("BATF::JUN_AHR",
                                                                                                                                                                                                 "BATF::JUN_CCR9", "BATF::JUN_IL10"), class = "data.frame")

library(tidyverse)
dat %>%
  rownames_to_column() %>%
  bind_cols(all_zero = pmap_lgl(., function(rowname, ...) all(list(...) == 0))) %>%
  filter(all_zero == FALSE) %>%
  `rownames<-`(.$rowname) %>%
  select(-rowname, -all_zero)
