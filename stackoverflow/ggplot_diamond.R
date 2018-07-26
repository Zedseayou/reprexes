library(ggplot2)
# df <- data.frame(x = c(1, 0, -1, 0), y = c(0, 1, 0, -1))
# ggplot(df) + geom_polygon(aes(x = x, y = y))
#
# as.vector(t(matrix(c(1, 0, -1, 0, 0, 1, 0, -1), ncol = 2)))

diamond <- function(side_length, center) {
  base <- matrix(c(1, 0, 0, 1, -1, 0, 0, -1), nrow = 2) * sqrt(2) / 2
  trans <- (base * side_length) + center
  as.data.frame(t(trans))
}

ggplot() +
  geom_polygon(diamond(2, c(1, 2)), aes(x = V1, y = V2))

mlb <- read.table("https://umich.instructure.com/files/330381/download?download_frd=1", as.is = T, header = T)
str(mlb)

fit <- lm(Height ~ Weight + Age - 1, data = as.data.frame(scale(mlb[, 4:6])))
points <- data.frame(x = c(0, fit$coefficients[1]), y = c(0, fit$coefficients[2]), z = c("(0,0)", "OLS Coef"))

Y <- scale(mlb$Height)
X <- scale(mlb[, c(5, 6)])
beta1 <- seq(-0.556, 1.556, length.out = 100)
beta2 <- seq(-0.661, 0.3386, length.out = 100)
df <- expand.grid(beta1 = beta1, beta2 = beta2)

b <- as.matrix(df)
df$sse <- rep(t(Y) %*% Y, 100 * 100) - 2 * b %*% t(X) %*% Y + diag(b %*% t(X) %*% X %*% t(b))

# base <- ggplot(df) +
#   stat_contour(aes(beta1, beta2, z = sse),
#     breaks = round(quantile(df$sse, seq(0, 0.2, 0.03)), 0),
#     size = 0.5, color = "darkorchid2", alpha = 0.8
#   ) +
#   scale_x_continuous(limits = c(-0.4, 1)) +
#   scale_y_continuous(limits = c(-0.55, 0.4)) +
#   geom_point(data = points, aes(x, y)) +
#   geom_text(data = points, aes(x, y, label = z), vjust = 2, size = 3.5)

ggplot(df) +
  stat_contour(aes(beta1, beta2, z = sse),
               breaks = round(quantile(df$sse, seq(0, 0.2, 0.03)), 0),
               size = 0.5, color = "darkorchid2", alpha = 0.8
  ) +
  geom_polygon(data = diamond(0.1, c(0, 0)), mapping = aes(x = V1, y = V2), fill = "cadetblue1") +
  scale_x_continuous(limits = c(-0.4, 1)) +
  scale_y_continuous(limits = c(-0.55, 0.4)) +
  geom_point(data = points, aes(x, y)) +
  geom_text(data = points, aes(x, y, label = z), vjust = 2, size = 3.5)
