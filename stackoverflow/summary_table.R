Age1 <- data.frame(c(5, 10, 15, 20, 25))
colnames(Age1) <- c("Age")
Age2 <- data.frame(c(5, 10, 15))
colnames(Age2) <- c("Age")
Age3 <- data.frame(c(5, 10, 15, 20, 25, 30))
colnames(Age3) <- c("Age")

summary.stats <- function(x, d){
  RowName <- deparse(substitute(d))
  N <- length(x[!is.na(x)])
  Mu <- mean(x)
  Sigma <- sd(x)
  Min <- min(x, na.rm = T)
  Max <- max(x, na.rm = T)
  Row <- tibble(RowName, N, Mu, Sigma, Min, Max)
}

rbind(
  summary.stats(Age1$Age, Age1),
  summary.stats(Age2$Age, Age2),
  summary.stats(Age3$Age, Age3)
)
