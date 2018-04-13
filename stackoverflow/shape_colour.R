df <- data.frame( thrd_cnt=c(1,2,4,8,16),
                  runtime4=c(53,38,31,41,54),
                  runtime8=c(54,35,31,35,44))
library(tidyverse)
df %>% gather(cores, runtime, runtime4, runtime8)

ggplot(
  data = df %>%
    gather(cores, runtime, runtime4, runtime8) %>%
    mutate(cores = str_c(str_extract(cores, "\\d"), " cores")),
  mapping = aes(x = thrd_cnt, y = runtime, colour = cores)
  ) +
  geom_line() +
  geom_point(aes(shape = cores), size = 3, fill = "white") +
  scale_x_continuous(breaks = c(1, 2, 4, 8, 16)) +
  scale_shape_manual(values = c("4 cores" = 21, "8 cores" = 23)) +
  theme(legend.position = c(0.3, 0.8)) +
  labs(
    x = "Number of Threads",
    y = "Execution Time (millisec)",
    colour = "# cores",
    shape = "# cores"
  )
