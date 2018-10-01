library(sf)
a_poly <- st_polygon(list(rbind(c(0, 0), c(1, 0), c(1, 1), c(0, 1), c(0, 0))))
a_sfc <- st_sfc(a_poly, a_poly + 2)
a_sf <- st_sf(att = 1:2, a_sfc)

nc <- st_read(system.file("shape/nc.shp", package="sf")) %>%
  st_transform(3857)

test_sfg <- function(x, size){
  bb <- st_bbox(x)
  lon <- runif(size, bb[1], bb[3])
  lat <- runif(size, bb[2], bb[4])
  m <- cbind(lon, lat)
  pts <- st_sfc(lapply(seq_len(nrow(m)), function(i) st_point(m[i,])))
  pts[lengths(st_within(pts, x)) > 0]

  if (length(pts) < size){
    pts <- rbind(pts, test_sfg(x, size - length(pts)))
  }
  else {
    pts
  }
}

test_sfc <- function(x, sizes){
  pts_list <- purrr::map2(
    .x = x,
    .y = sizes,
    .f = function(poly, size){
      test_sfg(poly, size)
    }
  )
  pts_sfc <- do.call("c", pts_list)
  st_crs(pts_sfc) <- st_crs(x)
  return(pts_sfc)
}

test_sf <- function(x, sizes){
  sfc <- sf::st_geometry(x)
  rows <- split(sf::st_set_geometry(x, NULL), seq(nrow(x))) %>%
    purrr::map(tibble::as_tibble)
  pts_list <- purrr::pmap(
    .l = list(rows, sfc, sizes),
    .f = function(row, poly, size){
      rows_rep <-  row[rep.int(1, size), ]
      rows_rep["samplepoint"] <- 1:size
      samp_pts <- test_sfg(poly, size)
      return(sf::st_sf(rows_rep, row.names = NULL, geometry = samp_pts))
    }
  )
  pts_sf <- do.call("rbind", pts_list)
  st_crs(pts_sf) <- st_crs(x)
  return(pts_sf)
}

test_sfg(nc$geometry[[1]], 1)
test_sfc(nc$geometry, rep(1:100))
