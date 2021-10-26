## Personal data

# this generates random names
random_names <- randomNames(5e3L,
                            which.names = "both",
                            name.sep = ", ",
                            sample.with.replacement = TRUE,
                            return.complete.data = FALSE)
# Works
random_names

## this generates a set of unique pins
generate_unique_pins <- function(n) {
  # number <- runif(n = n, min=0, max = (1e6)-1)
  number <- sample(x = seq(from = 0, to = (1e6) - 1, by = 1), size = n, replace = FALSE)
  number_6digit <- str_pad(number, width = 6, pad = "0")
  letter1 <- sample(x = LETTERS, size = n, replace = TRUE)
  letter2 <- sample(x = LETTERS, size = n, replace = TRUE)
  return(
    paste0(str_sub(number_6digit, 1, 2), letter1, str_sub(number_6digit, 3, 6), letter2)
  )
}

# create pins
nmc_pins <- generate_unique_pins(5e3L)

unique_names <- c(random_names)
pin_number <- c(nmc_pins)

# create dates
date_test <- as_datetime( runif(5e3L, 1546290000, 1577739600))

join_datetime <- c(date_test)

test_spine <- data.frame(pin_number, unique_names, join_datetime, stringsAsFactors=FALSE)
str(test_spine)
