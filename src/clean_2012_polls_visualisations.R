library(tidyverse)
polls_raw <- read.csv("data/raw/state_polls_2012.csv")
polls_tidy <- polls_raw

# Visualisation of polling activity towards election day
ggplot(polls_tidy, aes(x = sample_subpopulation, y = Obama - Romney)) +
  geom_boxplot() +
  labs(
    title = "Polling margins across different sampled populations",
    x = "Sample population",
    y = "Obama - Romney margin"
  ) +
  theme_minimal()

# Create a variable calculating days until election
polls_tidy <- polls_tidy %>%
  mutate(
    end_date = as.Date(end_date),
    days_before_election = as.numeric(as.Date("2012-11-06") - end_date)
  )

# Visualisation of undecided voters towards election day
ggplot(polls_tidy,
       aes(x = days_before_election, y = Undecided)) +
  geom_point() +
  geom_smooth() +
  scale_x_reverse() +
  labs(
    title = "Undecided voters approaching Election Day",
    x = "Days before Election Day",
    y = "Undecided voters (%)"
  ) +
  theme_minimal()
