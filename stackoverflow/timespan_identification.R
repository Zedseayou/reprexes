library(tidyverse)
library(lubridate)
pres <- data.frame(pres = c("Ronald Reagan", "George H. W. Bush",
                            "Bill Clinton", "George W. Bush",
                            "Barack Obama", "Donald Trump"),
                   inaugdate = structure(c(4037, 6959, 8420, 11342, 14264,
                                           17186), class = "Date"))

events <- data.frame(event = c("Challenger explosion", "Chernobyl explosion",
                               "Hurricane Katrina", "9-11"),
                     date = structure(c(5871, 5959, 13024, 11576), class = "Date"))

pres2 <- pres %>%
  mutate(
    presidency = interval(inaugdate, lead(inaugdate, default = today())),
    pres = as.character(pres)
  )
events %>%
  mutate(pres = map_chr(date, ~ pres2$pres[which(. %within% pres2$presidency)]))
