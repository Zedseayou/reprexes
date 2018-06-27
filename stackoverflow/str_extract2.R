mytext <- c(
  as.character("HORSE MONKEY LIZARD AA12345 SWORDFISH"), # Return AA12345
  as.character("ELEPHANT AA100 KOALA POLAR.BEAR"), # Want to return AA100,
  as.character("AA3273 ELEPHANT KOALA POLAR.BEAR"), # Want to return AA3273
  as.character("ELEPHANT KOALA POLAR.BEAR AA5785"), # Want to return AA5785
  as.character("ELEPHANT KOALA POLAR.BEAR"), # Want to return nothing
  as.character("ELEPHANT AA12345 KOALA POLAR.BEAR AA5785") # Can return only AA12345 or both
)

library(stringr)
mytext %>% str_extract("(?<=^| )AA.*?(?=$| )")
mytext %>% str_extract_all("(?<=^| )AA.*?(?=$| )")

as.character("TULIP AA999 DAISY BB123") %>% str_extract_all("(?<=^| )(AA|BB).*?(?=$| )")
