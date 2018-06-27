a <- structure(list(`1` = c("123", "131", "342"), `2` = c("123", "131"), `3` = c("123", "131", "352"), `4` = c("31", "352"), `5` = c("153", "131"), `6` = c("153", "131", "382")), .Names = c("1", "2", "3", "4", "5", "6"))

dates <-  data.frame(
  matrix(
    data = c(names(a), lengths(a)),
    ncol = length(a),
    byrow = TRUE
    )
  )
dates

dates = data.frame()
for(i in 1:length(a)){
  dates[1, i] = strtoi(names(a)[i]) #Appends to my data frame on the first row, line 'i' the key from my list (index 'i'), as Integer
  dates[2, i] = length(a[[i]]) #Here is my problem, it returns '1', not the real length of my list (index 'i')
}
dates

a[1]
a[[1]]
