catalan_num_recr <- function(numb){
  if (numb == 0){
    return(1)
  }
  else
    return(((4*numb-2)*catalan_num_recr(numb-1))/(numb+1))
}

purrr::map_dbl(1:15, catalan_num_recr)
