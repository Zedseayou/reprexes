eg_ans <- sample.int(3, 31, replace = TRUE)

transform_scores <- function(answers){
  # assertthat::assert_that(
  #   length(answers) == 31,
  #   msg = "There are not 31 values in input vector"
  # )
  score1 <- function(ans) ans * 10
  score6a <- function(ans) (6 - ans) * 20
  score6b <- function(ans) (ans - 1) * 20
  score5a <- function(ans) (5 - ans) * 25
  score5b <- function(ans) (ans - 1) * 25
  score4 <- function(ans) (ans - 1) * (100 / 3)
  score3 <- function(ans) (ans - 1) * 50

  scores <- numeric(31)
  scores[1] <- score1(answers[1])
  scores[c(2, 5:6, 9)] <- score6a(answers[c(2, 5:6, 9)])
  scores[c(3:4, 7:8, 10:13, 16:18)] <- score6b(answers[c(3:4, 7:8, 10:13, 16:18)])
  scores[c(14, 25:30)] <- score5a(answers[c(14, 25:30)])
  scores[19:20] <- score5b(answers[19:20])
  scores[c(15, 21, 23:24)] <- score4(answers[c(15, 21, 23:24)])
  scores[22] <- score3(answers[22])
  return(scores)
}

eg_scores <- transform_scores(eg_ans)
eg_scores
