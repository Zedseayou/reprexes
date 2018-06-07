l1 <- list(list("62010"), list("79110"), list("69202"), list("96040"), list("90010"), list("59200"))

to_sublist <- function(string_list){
  string <- string_list[[1]]

  if (nchar(string) == 2){
    return(string_list)
  } else {
    substring <- substr(string, 1, nchar(string) - 1)
    sublist <- list(substring, string_list)
    return(to_sublist(sublist))
  }
}

l_out <- lapply(l1, to_sublist)
str(l_out[1:2])
