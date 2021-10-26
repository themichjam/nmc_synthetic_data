generate_random_names <- function(ran_nam) {
  randomNames(5000,
              which.names="both",
              name.order="last.first",
              name.sep=", ",
              sample.with.replacement=TRUE,
              return.complete.data=FALSE)
  }