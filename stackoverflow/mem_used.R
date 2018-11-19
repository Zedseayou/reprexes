library(pryr)
mem_used()
foo <- iris
bar <- mtcars
mem_used()
foo["Foo"] <- mean(foo$Sepal.Length) + median(bar$carb)
mem_used()
foo_list <- list(foo)
mem_used()
