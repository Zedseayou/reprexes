library(tidyverse)
gene_list <- list(
  data.frame(
    patient= c(1,2,3),
    Diagnosis= c("AD","Control", "AD"),
    Eigen_gene= c(1.1, 2.3, 4.3),
    geneA= c(1,1,1),
    geneC= c(2,1,3),
    geneB= c(2,39,458)
  ),
  data.frame(
    patient= c(1,2,3),
    Diagnosis= c("AD","Control", "AD"),
    Eigen_gene= c(1.1, 2.3, 4.3),
    geneF= c(1,1,1),
    geneE= c(2,1,3),
    geneH= c(2,39,458)
  ),
  data.frame(
    patient= c(1,2,3),
    Diagnosis= c("AD","Control", "AD"),
    Eigen_gene= c(1.1, 2.3, 4.3),
    geneT= c(1,1,1),
    geneZ= c(2,1,3)
  )
)

output <- gene_list %>%
  imap_dfr(~ tibble(set_index = .y, gene = colnames(.x[4:ncol(.x)])))
output
