make_matrix <- function(tm, A){
  A[, 1:(tm - 3)] <- do.call(
    what = cbind,
    args = lapply(
      X = 1:(tm - 3),
      FUN = function(n) sample(1:(n + 2), nrow(A), replace = TRUE)
      )
    )
  return(A)
}
A <- matrix(0, 5, 23)
make_matrix(10, A)
