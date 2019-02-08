library(tidyverse)
df <- structure(list(Date = structure(c(13879, 13910, 13939, 13970, 14000, 14031, 14061, 14092, 14123, 14153), class = "Date"), Closings = c(250.156142028049, 278.357976437638, 255.121081362418, 283.702250084887, 283.28935185905, 288.313623559134, 325.000699725773, 298.376264701902, 313.84570882404, 305.210255253672), Price = c(292992.425757596, 282232.785900843, 275389.834275573, 274500.109731967, 264944.862222162, 261706.592852482, 250524.250644742, 246374.074631546, 236004.574847187, 228285.291130621)), row.names = c(NA, -10L), class = "data.frame")
ggplot(df, aes(x = Date)) +
  geom_area(aes(y = Closings, fill = "Closings"), colour = "black") +
  geom_line(aes(y = Price * 0.001333333, colour = "Price")) +
  scale_fill_manual(values = "yellow", breaks = "Closings", name = NULL) +
  scale_colour_manual(values = "green", breaks = "Price", name = NULL)
