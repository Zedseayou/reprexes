df <- head(airquality)
for (i in names(df)){
  print(df[, i])
}

for (col in df){
  print(col)
}
