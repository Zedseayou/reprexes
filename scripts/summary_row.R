df1 <- data.frame(Name=c("A", "B", "C"), E1=c(0, NA, 1), E2=c(1, 0, 1))
df2 <- data.frame(Name=c("A", "C", "F"), E1=c(1, 0, 1), E2=c(0, 0, 0))
ls <- list(df1, df2)

lapply(ls, function(x) {
  x[nrow(x)+1, -1] <- colSums(x[,-1], na.rm=TRUE)
  x[, 1] <- as.character(x[, 1])
  x[nrow(x), 1] <- "Sum"
  return(x)
})
