library(tidyverse)
library(sf)
nc <- st_read(system.file("shape/nc.shp", package="sf")) %>%
  st_transform(3857)


points_from_poly <- function(poly, n = 1){
  bb <- st_bbox(poly)
  lon <-runif(n, bb[1], bb[3])
  lat <- runif(n, bb[2], bb[4])
  m <- cbind(lon, lat)
  pts <- st_sfc(lapply(seq_len(nrow(m)), function(i) st_point(m[i,])), crs = st_crs(poly))
  pts[lengths(st_within(pts, poly)) > 0]

  if (length(pts) < n){
    pts <- rbind(pts, points_from_poly(poly, n - length(pts)))
  }
  else {
    pts
  }
}

x <- points_from_poly(nc$geometry[[1]], n = 10)

st_sample_fixed <- function(x, sizes){
  sfc <- st_geometry(x)
  rows <- split(st_set_geometry(x, NULL), seq(nrow(x)))
  pointlist <- pmap(
    .l = list(rows, sfc, sizes),
    .f = function(row, poly, size){
      rows = row[]
    }
  )


  return(bb)
}

st_sample_fixed(nc)
plot(nc$geometry)
