df <- data.frame(
  id = rep(letters[1], 2),
  val1 = c(10, 20),
  val2 = c(100, 200),
  key = c("A", "B"),
  value = c(1, 2))

df %>%
  spread("key", "value") %>%
  group_by(id) %>%
  summarise(
    val1 = min(val1),
    val2 = max(val2),
    A = mean(A, na.rm = TRUE),
    B = mean(B, na.rm = TRUE)
    )
