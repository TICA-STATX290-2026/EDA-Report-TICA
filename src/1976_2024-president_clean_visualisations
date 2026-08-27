# Vote share by party over time:
# sum candidatevotes per party per year, convert to share of that year's total,
# then plot as a line chart so trends across parties can be compared over time
X1976_2024_president_clean %>%
  group_by(year, party_simplified) %>%
  summarise(votes = sum(candidatevotes, na.rm = TRUE), .groups = "drop") %>%
  group_by(year) %>%
  mutate(share = votes / sum(votes)) %>%
  ggplot(aes(year, share, color = party_simplified)) +
  geom_line() +
  labs(title = "Vote Share by Party Over Time")

# Find the winning candidate's party for each state, each year
state_winners <- X1976_2024_president_clean %>%
  group_by(year, state) %>%
  slice_max(candidatevotes, n = 1)

# Order states by historical Republican win rate, so states with similar
# partisan lean are grouped together instead of sorted alphabetically —
# makes the tile chart below far easier to read
state_order <- state_winners %>%
  group_by(state) %>%
  summarise(pct_rep = mean(party_simplified == "REPUBLICAN")) %>%
  arrange(pct_rep) %>%
  pull(state)

# Winning party by state and year, sorted by partisan lean:
# reveals which states are solidly one-party vs genuinely contested
state_winners %>%
  mutate(state = factor(state, levels = state_order)) %>%
  ggplot(aes(year, state, fill = party_simplified)) +
  geom_tile() +
  labs(title = "Winning Party by State (sorted by partisan lean)") +
  theme(axis.text.y = element_text(size = 6))
