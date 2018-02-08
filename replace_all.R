metadata_list <- list(structure(list(X1 = c("Station Name: Roches_Point", "Station Height: 40 M",
                           "Latitude:51.789", "Longitude: -8.240")), .Names = "X1", row.names = c(NA,
                                                                                                  -4L), class = c("tbl_df", "tbl", "data.frame")), structure(list(
                                                                                                    X1 = c("Station Name: Newport", "Station Height: 22 M", "Latitude:53.920",
                                                                                                           "Longitude: -9.570")), .Names = "X1", row.names = c(NA, -4L
                                                                                                           ), class = c("tbl_df", "tbl", "data.frame")))

metadata_list <- lapply(metadata_list, function(x)
  sapply(x, function(y){
    str_replace_all(y,"Station Name: |Station Height: | M|Latitude:|Longitude: ", "" )
  }))
