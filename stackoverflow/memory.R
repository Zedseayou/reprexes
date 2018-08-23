x <- list(1:10)
cat(tracemem(x), "\n")
cat(tracemem(x[[1]]), "\n")
x[[2]] <- x
cat(tracemem(x), "\n")
cat(tracemem(x[[1]]), "\n")
cat(tracemem(x[[2]]), "\n")
