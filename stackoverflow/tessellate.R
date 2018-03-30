library(sf)
square <- st_polygon(
  list(
    matrix(c(0,0,0,1,1,1,1,0,0,0), ncol = 2, byrow = TRUE)
  )
)
calculateOctagonUp <- function(p_start,l_m) { # draws the points of an octagon while walking upwards, counterclockwise
  p1=p_start
  p2=p1+c(l_m,0)
  p3=p2+c(l_m,l_m)/sqrt(2)
  p4=p3+c(0,l_m)
  p5=p4+c(-l_m,l_m)/sqrt(2)
  p6=p5+c(-l_m,0)
  p7=p6-c(l_m,l_m)/sqrt(2)
  p8=p7+c(0,-l_m)
  rbind(p1,p2,p3,p4,p5,p6,p7,p8,p1)
}

octagon <- st_polygon(list(calculateOctagonUp(c(0,1), 1)))

unit <- st_sfc(square, octagon)
plot_grid <- function(tile, nrow, ncol){
  col <- tile
  for (i in 1:nrow){
    col <- c(col, col + c(0, 2 + sqrt(2)))
  }
  grid <- col
  for (i in 1:ncol){
    grid <- c(grid, grid + c(1 + sqrt(2) / 2, -(1 + sqrt(2) / 2)))
  }
  plot(grid)
}

plot_grid(unit, 3, 3)
