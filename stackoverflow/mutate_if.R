funct_change <- function(x, max_value){
  max(x, na.rm = TRUE) > max_value
}
library(dplyr)
mtcars %>% mutate_if(function(x) funct_change(x, 30), as.character) %>% glimpse()
mtcars %>% mutate_if(~ funct_change(., 30), as.character) %>% glimpse()
