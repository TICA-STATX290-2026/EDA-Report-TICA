library(tidyverse)

# Read in data and save an unchanged copy 
polls_raw <- read.csv("data/raw/state_polls_2012.csv")
polls_tidy <- polls_raw

# Remove redundant information in poll_info values to only keep state names  
polls_tidy <- polls_tidy %>%
  mutate(
    poll_info = str_remove(poll_info, "^2012-"),
    poll_info = str_remove(poll_info, "-president-romney-vs-obama$"),
    poll_info = str_replace_all(poll_info, "-", " "),
    poll_info = str_to_title(poll_info)
  )
# Rename poll_info to State for meaningful variable name 
polls_tidy <- polls_tidy %>%
  rename(state = poll_info)

# Check for missingness in Obama and Romney variable 
sum(is.na(polls_tidy$Romney))
sum(is.na(polls_tidy$Obama))

# Check Obama and Romney and Undecided values are valid percentages (between 0 and 100)
sum(polls_tidy$Romney < 0 | polls_tidy$Romney > 100, na.rm = TRUE)
sum(polls_tidy$Obama < 0 | polls_tidy$Obama > 100, na.rm = TRUE)
sum(polls_tidy$Undecided < 0 | polls_tidy$Undecided > 100, na.rm = TRUE)

# Check missingness in Undecided variable 
sum(is.na(polls_tidy$Undecided))


# Recode "Not included in poll" to NA for consistent representation of missingness
# Convert Other values to numeric 
polls_tidy <- polls_tidy %>%
  mutate(
    Other = na_if(Other, "Not included in poll"),
    Other = as.numeric(Other)
  )
# Check Other values are valid percentages (between 0 and 100)
sum(polls_tidy$Other < 0 | polls_tidy$Other > 100, na.rm = TRUE)


# Check for duplicated poll ID's 
sum(duplicated(polls_tidy$poll_id))
# Check for any completely duplicated observations
sum(duplicated(polls_tidy))

# Convert start_date and end_date values to Date values 
polls_tidy <- polls_tidy %>%
  mutate(
    start_date = as.Date(start_date), 
    end_date = as.Date(end_date)
  )
# Check start_date is earlier than end_date for validity 
sum(polls_tidy$start_date > polls_tidy$end_date, na.rm = TRUE)


# Check if sample size for any observations is less than 1 (invalid values)
sum(polls_raw$sample_size < 1, na.rm = TRUE)
# Sample size less than 1 are considered invalid, and recorded as missing (NA)
polls_tidy <- polls_tidy %>%
  mutate(
    sample_size = if_else(sample_size < 1, NA, sample_size)
  )

# Examine relationship between partisanship and partisan affiliation
table(polls_raw$partisanship, polls_raw$partisan_affiliation)
# Change "None" values to NA as affiliation is not applicable for nonpartisan polls where affiliation
polls_tidy <- polls_tidy %>%
  mutate(
    partisan_affiliation = na_if(partisan_affiliation, "None")
  )

# Convert columns "Obama", "Romney", "Other", "Undecided" under new candidate column
polls_tidy <- polls_tidy %>%
  pivot_longer(
    cols = c("Obama", "Romney", "Other", "Undecided"),
    names_to = "candidate",
    values_to = "support"
  )

write_csv(
  polls_tidy,
  "data/clean/state_polls_2012_clean.csv"
)