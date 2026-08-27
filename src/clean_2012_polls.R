library(tidyverse)

# Read in data and save an unchanged data set 
polls_raw <- read.csv("data/raw/state_polls_2012.csv")
polls_tidy <- polls_raw

# Clean poll_info 
polls_tidy <- polls_tidy |>
  mutate(
    poll_info = str_remove(poll_info, "^2012-"),
    poll_info = str_remove(poll_info, "-president-romney-vs-obama$")
  )

polls_tidy <- polls_tidy |>
  rename(State = poll_info)

# Check for missingness in Obama and Romney variable 
sum(is.na(polls_tidy$Romney))
sum(is.na(polls_tidy$Obama))

# Clean Other variable 
polls_tidy <- polls_tidy |>
  mutate(
    Other = na_if(Other, "Not included in poll"),
    Other = as.numeric(Other)
  )

# Clean poll_id variable 
sum(duplicated(polls_tidy$poll_id))

# Clean start_date and end_date variable
polls_tidy <- polls_tidy |>
  mutate(
    start_date = as.Date(start_date), 
    end_date = as.Date(end_date)
  )
# Potentially create new column poll_duration 

# Negative sample sizes considered invalid, and recorded as missing (NA)
polls_tidy <- polls_tidy |>
  mutate(
    sample_size = if_else(sample_size < 0, NA, sample_size)
  )

# Clean partisan_affiliation column 
polls_tidy <- polls_tidy |>
  mutate(
    partisan_affiliation = na_if(partisan_affiliation, "None")
  )
