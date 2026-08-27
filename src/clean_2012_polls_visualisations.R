


# Visualisation of polling activity towards election day
ggplot(polls_tidy, aes(x = sample_subpopulation, y = Obama - Romney)) +
  geom_boxplot() +
  labs(
    title = "Polling margins across sampled populations",
    x = "Sample population",
    y = "Obama - Romney margin"
  ) +
  theme_minimal()


# Visualisation of polling activity towards election day
polls_tidy <- polls_tidy |>
  mutate(
    weeks_to_election =
      floor(as.numeric(as.Date("2012-11-06") - end_date) / 7)
  )

polls_tidy |>
  count(weeks_to_election) |>
  ggplot(aes(x = weeks_to_election, y = n)) +
  geom_col() +
  scale_x_reverse() +
  labs(
    title = "Polling activity approaching Election Day",
    x = "Weeks until Election Day",
    y = "Number of polls"
  ) +
  theme_minimal()

# Visualisation of undecided voters towards election day
ggplot(polls_tidy,
       aes(x = days_to_election, y = Undecided)) +
  geom_point(alpha = 0.4) +
  geom_smooth() +
  scale_x_reverse() +
  labs(
    title = "Undecided voters approaching Election Day",
    x = "Days until Election Day",
    y = "Undecided voters (%)"
  ) +
  theme_minimal()
