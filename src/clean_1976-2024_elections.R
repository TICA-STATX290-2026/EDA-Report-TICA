library(readr)
library(dplyr)
library(stringr)

# Read in data and save an unchanged copy
X1976_2024_president <- read_csv("data/raw/1976-2024-president.csv")

# Summary of data
glimpse(X1976_2024_president)

# Check election years are correct (four-year intervals)
unique(X1976_2024_president$year)

# Check missingness for year column
sum(is.na(X1976_2024_president$year))

X1976_2024_president_clean <- X1976_2024_president %>%

  # Standardise state variable to match the polling data sets
  mutate(
    state = str_to_title(state),
    state = if_else(state == "District Of Columbia", "Washington Dc", state)
    ) %>%

  # Drop 'office' (constant value for every observation)
  select(-office) %>%

  # Drop 'notes' (constant/empty value for every observation)
  select(-notes) %>%

  # Standardise version values to the same yyyymmdd format
  mutate(version = if_else(
    str_detect(version, "/"),
    format(as.Date(version, "%d/%m/%Y"), "%Y%m%d"),
    version
  )) %>%
  mutate(version = as.Date(version, format = "%Y%m%d")) %>%

  # Clean candidate names: collapse doubled quotes ""NAME"" -> "NAME"
  # (CSV escaping artifact; same person sometimes appears both ways)
  mutate(candidate = str_replace_all(candidate, '""', '"'))

# Check missingness in state column
sum(is.na(X1976_2024_president_clean$state))

# Check missingness in state_po, state_fips and state_cen columns
sum(is.na(X1976_2024_president_clean$state_po))
sum(is.na(X1976_2024_president_clean$state_fips))
sum(is.na(X1976_2024_president_clean$state_cen))

# Check observations missing ICPSR state codes
X1976_2024_president_clean %>%
  filter(is.na(state_ic)) %>%
  select(year, state, state_po, state_ic) %>%
  print(n = Inf)
# Missing values only for New Hampshire and West Virginia 2024 observations.
# Keep NA as states can be identified by other variables.

# Check missingness and validity of candidatevotes column
sum(is.na(X1976_2024_president_clean$candidatevotes))
sum(X1976_2024_president_clean$candidatevotes < 0, na.rm = TRUE)

# Check missingness and validity of totalvotes column
sum(is.na(X1976_2024_president_clean$totalvotes))
sum(X1976_2024_president_clean$totalvotes < 0, na.rm = TRUE)

# Check values in party_simplified and examine missingness
unique(X1976_2024_president_clean$party_simplified)
sum(is.na(X1976_2024_president_clean$party_simplified))
X1976_2024_president_clean %>%
  filter(is.na(party_simplified)) %>%
  select(party_detailed, party_simplified, candidate) %>%
  print(n = Inf)
# Missingness corresponds to write-in candidate, so NA is unchanged.

# Check values in writein column
unique(X1976_2024_president_clean$writein)
sum(is.na(X1976_2024_president_clean$writein))
X1976_2024_president_clean %>%
  filter(is.na(writein)) %>%
  print(n = Inf)
# Retain NA values as insufficient information to replace with TRUE/FALSE

# Check missing values in party_detailed column
sum(is.na(X1976_2024_president_clean$party_detailed))
X1976_2024_president_clean %>%
  filter(is.na(party_detailed)) %>%
  count(party_simplified)
X1976_2024_president_clean %>%
  filter(is.na(party_detailed),
         party_simplified %in% c("DEMOCRAT", "REPUBLICAN", "LIBERTARIAN")) %>%
  select(year, state, candidate, party_detailed, party_simplified)
# NA values were unchanged as insufficient information to replace missing values.

# Check missing values in candidate column
sum(is.na(X1976_2024_president_clean$candidate))
X1976_2024_president_clean %>%
  filter(is.na(candidate)) %>%
  count(writein)
X1976_2024_president_clean %>%
  filter(is.na(candidate), writein == FALSE) %>%
  select(state, year, party_detailed, candidatevotes) %>%
  print(n = Inf)
# Keep the observations as rows contain vote counts

# Check for any completely identical observations (accidental duplicates)
sum(duplicated(X1976_2024_president_clean))

write_csv(
  X1976_2024_president_clean,
  "data/clean/1976-2024-president-clean.csv"
)
