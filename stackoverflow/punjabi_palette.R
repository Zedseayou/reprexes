PunjabiPalette <- list("a" = 1, "b" = 2)
ListPalette <- function(listname = "PunjabiPalette"){

  if (listname != "PunjabiPalette"){
    stop(paste0(listname, " does not exist."))
  }

  list <- get(listname)
  names(list)
}

print(ListPalette())
print(ListPalette("PunjabiPalette"))
print(ListPalette("OtherName"))
