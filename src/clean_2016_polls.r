# Xuan - this script cleans the 2016 state polls in data\raw\state_polls_2016.csv
# and saves it to a new csv file in data\cleaned\state_polls_2016_clean.csv
library(tidyverse)

# Read in data and save an unchanged data set 
polls_2016_raw <- read.csv("data/raw/state_polls_2016.csv")
polls_2016_tidy <- polls_2016_raw

# Remove redundant information in poll_info values to only keep state names  
polls_2016_tidy <- polls_2016_tidy %>%
  mutate(
    poll_info = str_remove(poll_info, "^2016-"),
    poll_info = str_remove(poll_info, "-president-trump-vs-clinton$"),
    poll_info = str_replace_all(poll_info, "-", " "),
    poll_info = str_to_title(poll_info),
    poll_info = str_replace(poll_info, "Washington D C", "Washington Dc")
  )
# Remove additional information from other poll_info values 
polls_2016_tidy <- polls_2016_tidy %>%
  mutate(
    poll_info = str_remove(
      poll_info,
      " Presidential General Election Trump Vs Clinton"
    ) 
  ) %>% 
  # Rename poll_info to State for meaningful variable name 
  rename(State = poll_info)

# Check for missingness in Trump and Clinton variable 
sum(is.na(polls_2016_tidy$Trump))
sum(is.na(polls_2016_tidy$Clinton))

# Check Trump and Clinton values are valid percentages (between 0 and 100)
sum(polls_2016_tidy$Trump < 0 | polls_2016_tidy$Trump > 100, na.rm = TRUE)
sum(polls_2016_tidy$Clinton < 0 | polls_2016_tidy$Clinton > 100, na.rm = TRUE)

# Recode "Not included in poll" to NA for consistent representation of missingness
# Convert Other values to numeric 
polls_2016_tidy <- polls_2016_tidy %>%
  mutate(
    Other = na_if(Other, "Not included in poll"),
    Other = as.numeric(Other)
  )

# Check for duplicated poll ID's 
sum(duplicated(polls_2016_tidy$poll_id))
# Check for any completely duplicated observations 
sum(duplicated(polls_2016_tidy))

# Convert start_date and end_date values to Date values 
polls_2016_tidy <- polls_2016_tidy %>%
  mutate(
    start_date = as.Date(start_date), 
    end_date = as.Date(end_date)
  )

# Check if sample size for any observations is less than 1 (invalid values)
sum(polls_2016_tidy$sample_size < 1, na.rm = TRUE)
# Negative sample sizes considered invalid, and recorded as missing (NA)
polls_2016_tidy <- polls_2016_tidy %>%
  mutate(
    sample_size = if_else(sample_size < 1, NA, sample_size)
  )

# Examine relationship between partisanship and partisan affiliation
table(polls_2016_raw$partisanship, polls_2016_raw$partisan_affiliation)
# Change "None" values to NA as affiliation is not applicable for nonpartisan polls 
polls_2016_tidy <- polls_2016_tidy  %>%
  mutate(
    partisan_affiliation = na_if(partisan_affiliation, "None")
  )

# Convert columns "Trump", "Clinton", "Other", "Undecided"
# "Johnson", "McMullin" under new candidate column
polls_2016_tidy <- polls_2016_tidy %>%
  pivot_longer(
    cols = c("Trump", "Clinton", "Other", "Undecided", "Johnson", "McMullin"), names_to = "candidate",
    values_to = "support"
  )

write_csv(
  polls_2016_tidy,
  "data/clean/state_polls_2016_clean.csv"
)
