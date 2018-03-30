library(tidyverse)
z1 <- matrix(101:104, nrow = 2, ncol = 2)
z2 <- matrix(201:204, nrow = 2, ncol = 2)
z3 <- matrix(301:304, nrow = 2, ncol = 2)
z4 <- matrix(401:404, nrow = 2, ncol = 2)
z5 <- matrix(501:504, nrow = 2, ncol = 2)
z6 <- matrix(601:604, nrow = 2, ncol = 2)
z7 <- matrix(701:704, nrow = 2, ncol = 2)
z8 <- matrix(801:804, nrow = 2, ncol = 2)
z9 <- matrix(901:904, nrow = 2, ncol = 2)
z10 <- matrix(1001:1004, nrow = 2, ncol = 2)

# Combine all matrices into a single list
za <- list(z1, z2, z3, z4, z5, z6, z7, z8, z9, z10)

quant_mat <- function(list, p){
  dim = ncol(list[[1]]) * nrow(list[[1]])
  list %>%
    flatten_int() %>%
    matrix(ncol = dim, byrow = TRUE) %>%
    as_tibble() %>%
    map_dbl(quantile, probs = p) %>%
    matrix(ncol = ncol(list[[1]]))
}

quant_mat(za, 0.975)
quant_mat(za, 0.025)
