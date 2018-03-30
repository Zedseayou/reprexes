df<-data.frame(ID=c("1","1","1","1",
                    "2","2","2",
                    "3","3"),
               group=c("a", "a", "b", "b",
                       "a", "a", "b",
                       "a", "a"),
               flag=c("yes","no","yes","no",
                      "yes","no","yes",
                      "yes","no"),
               value=c(155,789,18,1893,1466,66,4889,1876,33))
df %>%
  complete(ID, group, flag, fill = list(value = 0))
