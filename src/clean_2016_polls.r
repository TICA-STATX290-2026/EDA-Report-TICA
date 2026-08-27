# Xuan - this script cleans the 2016 state polls in data\raw\state_polls_2016.csv
# and saves it to a new csv file in data\cleaned\state_polls_2016_clean.csv
# some of the data checking code is commented out because it was used for checking the data and is not needed for the final cleaning

library(tibble)
library(readr)
library(naniar)
library(dplyr)
library(ggplot2)
library(GGally)

output_file <- "data/cleaned/state_polls_2016_clean.csv"

# load data
polls_2016_raw <- read_csv("data/raw/state_polls_2016.csv")

# clean column names by standardizing them brute force
# =====================
# converts all column names to lowercase just in case
# replaces any possible non-alphanumeric characters with underscores
# strips off any possible leading or trailing underscores

colnames(polls_2016_raw) <- polls_2016_raw %>%
  colnames() %>%
  tolower() %>%
  gsub("[^a-z0-9]+", "_", .) %>%
  gsub("^_+|_+$", "", .)

View(polls_2016_raw, title = "raw data check")

# cleaning data types and handling missing values
# ================================
# converts the dates to R objects
# replaces "Not included in poll" in the other column with NA
# converts the other column to numeric
# replace that one sample size of -1

polls_2016 <- polls_2016_raw %>%
  mutate(
    start_date = as.Date(start_date),
    end_date = as.Date(end_date)
  ) %>%

  replace_with_na(replace = list(other = "Not included in poll")) %>%

  mutate(other = as.numeric(other)) %>%

  replace_with_na(replace = list(sample_size = -1))


# clean column names by standardizing them brute force
# where is California and Florida??
# ====================
# replace any '-' with spaces
# Cap the first letter of each word

# get state names from middle text starts with "2016-" and ending with "-president" or "-presidential-general-election"
polls_2016 <- polls_2016 %>%
  mutate(state = sub("^2016-(.*?)-(president|presidential-general-election).*", "\\1", poll_info))

polls_2016 <- polls_2016 %>%
  mutate(
    state = gsub("-", " ", state),
    state = tools::toTitleCase(state),
  )


# write cleaned data
write_csv(
  polls_2016,
  output_file
)

View(polls_2016, title = "cleaned full")

# cat("2016 POLL SUMMARY\n")
# cat("rows:", nrow(polls_2016), "\n")
# cat("cols:", ncol(polls_2016), "\n")
# cat("unique poll id amount:", n_distinct(polls_2016$poll_id), "\n")
# cat("states:", n_distinct(polls_2016$state), "\n")

# View(miss_var_summary(polls_2016), title = "na amount in cleaned")
# View(polls_2016 %>% count(sample_subpopulation), title = "Counts by Subpopulation")
# View(polls_2016 %>% count(mode), title = "Counts by Mode")
# View(polls_2016 %>% count(pollster), title = "Counts by Pollster")


# # check for missing vars in raw data
# missing_summary <- miss_var_summary(polls_2016_raw)
# View(missing_summary, title = "na in raw")


# # previous check for errors and na
# # ============================

# if any of them is NA (none of them are)
# missing_states <- polls_2016 %>%
#   filter(is.na(state)) %>%
#   select(poll_info)
# View(missing_states, title = "Unextracted States")

# # if date is na or end_date < start_date
# date_errors <- polls_2016 %>%
#   filter(
#     is.na(start_date) |
#     is.na(end_date) |
#     end_date < start_date
#   )

# cat("date error:", nrow(date_errors), "\n")

# # check for other sample size problems other than the -1
# sample_size_errors <- polls_2016 %>%
#   filter(
#     !is.na(sample_size) &
#       sample_size <= 0
#   )

# cat("sample size error:", nrow(sample_size_errors), "\n")

# # % that is not 0 - 100 or na
# percentage_errors <- polls_2016 %>%
#   filter(
#     between(trump, 0, 100) == FALSE |
#     between(clinton, 0, 100) == FALSE |
#     (!is.na(other) & between(other, 0, 100) == FALSE) |
#     (!is.na(undecided) & between(undecided, 0, 100) == FALSE) |
#     (!is.na(johnson) & between(johnson, 0, 100) == FALSE) |
#     (!is.na(mcmullin) & between(mcmullin, 0, 100) == FALSE)
#   )

# cat("percentage error:", nrow(percentage_errors), "\n")
