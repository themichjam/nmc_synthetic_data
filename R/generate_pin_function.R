## this generates a set of unique pins
generate_unique_nmc_pins <- function(gen_pin) {
  # number <- runif(n = n, min=0, max = (1e6)-1)
  number <- sample(x = seq(from = 0, to = (1e6) - 1, by = 1), size = n, replace = FALSE)
  number_6digit <- str_pad(number, width = 6, pad = "0")
  letter1 <- sample(x = LETTERS, size = n, replace = TRUE)
  letter2 <- sample(x = LETTERS, size = n, replace = TRUE)
  return(
    paste0(str_sub(number_6digit, 1, 2), letter1, str_sub(number_6digit, 3, 6), letter2)
  )
}