df = data.frame(val=c(4,2,6,3,4,5),
                algo=c("A","A","A","C","C","C"),
                id=c("james","james","james",
                     "james","james","james"))
library(tidyverse)
df %>%
  group_by(id, algo) %>%
  mutate(rn = row_number()) %>%
  spread(algo, val, sep = ".") %>%
  select(-rn)
