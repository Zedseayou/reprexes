library(stringi)

make_postcodes <- function(templates){
  postcodes <- templates
  while (any(stri_detect_regex(postcodes, "l|n"))){
    for (i in 1:length(templates)){
      postcodes[i] <- stri_replace_first_fixed(
        str = postcodes[i],
        pattern = "l",
        replacement = sample(LETTERS, 1)
        )
      postcodes[i] <- stri_replace_first_fixed(
        str = postcodes[i],
        pattern = "n",
        replacement = sample(0:9, 1)
        )
    }
  }
  postcodes
}

make_postcodes("ln nll")
make_postcodes(c("ln nll", "ln nll", "lnl nll"))

test = stri_trim_both(stri_rand_strings(100000, sample(5:9, 1), pattern = "[nl\\ ]"))
tictoc::tic("Time to convert 100,000 templates")
x <- make_postcodes(test)
tictoc::toc()
head(test)
head(x)
