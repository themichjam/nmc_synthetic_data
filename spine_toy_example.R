## a toy example for generating a 'spine' listing how many 'jobs' and 'ftps' to associate with each name
## and then generating a dataframe of jobs and ftps, with as many entries per person as specified

spine <-
  tibble(
    name = LETTERS[1:5],
    num_records_jobs = rpois(n = 5, lambda = 3),  # poisson-distributed number of records, probably decent fit for actual distribution if we can work out a realistic lambda parameter
    num_records_ftp = rpois(n = 5, lambda = 0.5)
  )


how_many_jobs_to_generate <- sum(spine$num_records_jobs)
how_many_ftp_to_generate <- sum(spine$num_records_ftp)

generate_jobs <- function(how_many) {
  tibble(
    job_type = sample(LETTERS, size = how_many, replace = TRUE)
  )
}

generate_ftps <- function(how_many) {
  tibble(
    ftp_reason = sample(LETTERS, size = how_many, replace = TRUE)
  )
}


records_jobs <- bind_cols(
  spine %>% select(name) %>% slice(rep(seq(nrow(spine)), times = spine$num_records_jobs)),  # this "unrolls" the spine
  generate_jobs(how_many_jobs_to_generate)
)

records_ftp <- bind_cols(
  spine %>% select(name) %>% slice(rep(seq(nrow(spine)), times = spine$num_records_ftp)),  # this "unrolls" the spine
  generate_ftps(how_many_ftp_to_generate)
)