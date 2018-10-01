library(tidyverse)
library(sf)
nc <- st_read(system.file("shape/nc.shp", package="sf")) %>%
  st_transform(3857)

print(class(nc))
print(class(nc$geometry))
print(class(nc$geometry[[1]]))


points_from_poly <- function(x, size){
  bb <- st_bbox(x)
  lon <- runif(n, bb[1], bb[3])
  lat <- runif(n, bb[2], bb[4])
  m <- cbind(lon, lat)
  pts <- st_sfc(lapply(seq_len(nrow(m)), function(i) st_point(m[i,])), crs = st_crs(poly))
  pts[lengths(st_within(pts, poly)) > 0]

  if (length(pts) < n){
    pts <- rbind(pts, points_from_poly(poly, size - length(pts)))
  }
  else {
    pts
  }
}

x <- points_from_poly(nc$geometry[[1]], n = 10)

st_sample_fixed <- function(x, sizes){
  sfc <- st_geometry(x)
  rows <- split(st_set_geometry(x, NULL), seq(nrow(x)))
  pts <- pmap(
    .l = list(rows, sfc, sizes),
    .f = function(row, poly, size){
      rows_rep <-  row[rep.int(1, size), ]
      rows_rep["samplepoint"] <- 1:size
      samp_pts <- points_from_poly(poly, size)
      return(st_sf(rows_rep, geometry = samp_pts))
    }
  )
  pts_sf <- do.call("rbind", pts)
  return(pts_sf)
}

st_sample_fixed(nc, rep.int(2, 100))

p0 = st_polygon(list(rbind(c(0, 0), c(1, 0), c(1, 1), c(0, 1), c(0, 0))))
p1 = p0 * c(0.5, 1) + c(0.75, 0)
p2 = p0 + c(-1.5, 0)
p3 = p2 + c(0, 0.9)

a_poly <- st_polygon(list(rbind(c(0, 0), c(1, 0), c(1, 1), c(0, 1), c(0, 0))))
a_sfc <- st_sfc(a_poly, a_poly + 2)
a_sf <- st_sf(att = 1:2, a_sfc)
