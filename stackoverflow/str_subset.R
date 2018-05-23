library(stringr)
char <- c("AIASDFDIOHS*SDFDS", "ADUIHFSDUHF", "SDIFSDFIHSDOIU", "SDIOHFOSIDH#SDGFOIDS", "SDFIOJSD*IJF", "A", "AI%24;:x", "A12 345")
str_subset(char, "^A[^*#]*$")
