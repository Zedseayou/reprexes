library(tidyverse)
tbl <- structure(list(WMA = c("20", "19", "19", "19", "18", "19", "20", "20", "20", "19"), Waterbody = c("02040201070010-01", "02040202060040-01", "02040202060050-01", "02040202060060-01", "02040202150070-01", "02040202030080-01", "02040201080010-01", "02040201080020-01", "02040201080030-01", "02040202070010-01"), Name = c("Back Creek (above Yardville-H Sq Road)", "Barton Run (above Kettle Run Road)", "Barton Run (below Kettle Run Road)", "Bear Swamp River", "Birch Creek", "Bisphams Mill Creek (below McDonalds Br)", "Blacks Creek (above 40d06m10s)", "Blacks Creek (Bacons Run to 40d06m10s)", "Blacks Creek (below Bacons Run)", "Bobbys Run"), DO = c("Insufficient Data", "Non-attaining", "Non-attaining", "Insufficient Data", "Attaining", "Attaining", "Attaining", "Attaining", "Attaining", "Insufficient Data"), `DO Trout` = c("N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A"), pH = c("Insufficient Data", "Non-attaining", "Non-attaining", "Insufficient Data", "Attaining", "Attaining", "Attaining", "Attaining", "Attaining", "Insufficient Data"), `Total Phosphorus` = c("Non-attaining", "Attaining", "Non-attaining", "Insufficient Data", "Insufficient Data", "Non-attaining", "Non-attaining", "Non-attaining", "Non-attaining", "Insufficient Data"), Nitrate = c("Attaining", "Attaining", "Attaining", "Insufficient Data", "Insufficient Data", "Attaining", "Attaining", "Attaining", "Attaining", "Insufficient Data"), `Total Suspended Solids` = c("Attaining", "Attaining", "Attaining", "Insufficient Data", "Insufficient Data", "Insufficient Data", "Attaining", "Attaining", "Non-attaining", "Insufficient Data"), `Total Dissolved Solids` = c("Insufficient Data", "Attaining", "Attaining", "Insufficient Data", "Insufficient Data", "Insufficient Data", "Attaining", "Attaining", "Attaining", "Insufficient Data"), Turbidity = c("Insufficient Data", "Attaining", "Attaining", "Insufficient Data", "Attaining", "Insufficient Data", "Attaining", "Attaining", "Attaining", "Insufficient Data"), `Unionized Ammonia` = c("Attaining", "Attaining", "Attaining", "Insufficient Data", "Attaining", "Insufficient Data", "Attaining", "Attaining", "Attaining", "Insufficient Data"), `Unionized Ammonia Trout` = c("N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A"), E.coli = c("Insufficient Data", "Attaining", "Attaining", "Attaining", "Attaining", "Attaining", "Attaining", "Non-attaining", "Non-attaining", "Attaining"), Enterococcus = c("N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A"), `Total Coliform` = c("N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A")), .Names = c("WMA", "Waterbody", "Name", "DO", "DO Trout", "pH", "Total Phosphorus", "Nitrate", "Total Suspended Solids", "Total Dissolved Solids", "Turbidity", "Unionized Ammonia", "Unionized Ammonia Trout", "E.coli", "Enterococcus", "Total Coliform"), row.names = c(NA, -10L), class = c("tbl_df", "tbl", "data.frame"))

with_imp <- tbl %>%
  mutate(
    Imp = pmap(., function(...) names(list(...))[which(c(...) == "Non-attaining")]),
    Imp = Imp %>%
      map(str_c, collapse = ",") %>%
      map_if(~ length(.) == 0, ~ NA_character_) %>%
      flatten_chr
    )
with_imp[, c(1:3, 17)]

with_imp <- tbl %>%
  mutate(
    Imp = pmap_chr(., function(...) {
      vec <- names(list(...))[which(c(...) == "Non-attaining")]
      if (length(vec) == 0) {
        return(NA_character_)
      } else {
        return(str_c(vec, collapse = ","))
      }
    })
  )
with_imp[, c(1:3, 17)]
