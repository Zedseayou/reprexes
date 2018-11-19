library(data.table)
library(microbenchmark)
library(stringi)
df1 <- data.frame(name = rep(LETTERS, 250), number = rep(c(1:26), 250), stringsAsFactors = FALSE)
df1$name[df1$name == "D" | df1$name == "F" | df1$name == "L"] <- "foo*"
df2 <- data.frame(name = rep(LETTERS, 250), number = rep(c(1:26), 250), stringsAsFactors = FALSE)
df2$name[df2$name == "A" | df2$name == "R" | df2$name == "T"] <- "*foo*"
df3 <- data.frame(name = rep(LETTERS, 250), number = rep(c(1:26), 250), stringsAsFactors = FALSE)
df3$name[df3$name == "C" | df3$name == "Q" | df3$name == "W"] <- "f*oo"

df <- list(df1, df2, df3)
dt <- lapply(df, as.data.table)

mapply.remove.asterisk = function(x){
  df2 <- data.frame(mapply(gsub, "\\*", "", x, perl = TRUE))
  colnames(df2) <- colnames(x)
}

dt.remove.asterisk = function (x) {
  x[, lapply(.SD, function(x) gsub("\\*", "", x, perl = TRUE))]
}

stringi.remove.asterisk = function (x) {
  out <- x
  out$name <- stri_replace_all_regex(x$name, "\\*", "")
  out
}

gsub.remove.asterisk = function(x) {
  out <- x
  out$name <- gsub("\\*", "", x$name)
  out
}

mapgsubtest = function(x) {
  df.test <- lapply(x, mapply.remove.asterisk)
}

dtgsubtest = function(x) {
  dt.test <- lapply(x, dt.remove.asterisk)
}

strisubtest = function(x) {
  str.test <- lapply(x, stringi.remove.asterisk)
}

gsubtest = function(x){
  gsub.test <- lapply(x, gsub.remove.asterisk)
}

microbenchmark(mapgsubtest(df), dtgsubtest(dt), strisubtest(df), gsubtest(df))
