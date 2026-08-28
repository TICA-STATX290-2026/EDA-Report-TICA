# Xuan - this script visualises the cleaned 2016 state polls in data\clean\state_polls_2016_clean.csv
# This script produces two plots: one showing the average margin by state, and another showing the distribution of margins by state

library(tibble)
library(readr)
library(naniar)
library(dplyr)
library(ggplot2)
library(GGally)

polls <- read_csv("data/clean/state_polls_2016_clean.csv")

# plot: average margin by state
polls %>%
  mutate(margin = Trump - Clinton) %>%
  group_by(State) %>%
  summarise(avg_margin = mean(margin, na.rm = TRUE)) %>%
  ggplot(aes(x = avg_margin, y = reorder(State, avg_margin))) +
  geom_vline(xintercept = 0) +
  geom_col() +
  labs(
    x = "Average Trump - Clinton margin",
    y = "State",
    title = "Average 2016 Polling Margin by State"
  )


# second version: distribution of margins by state
polls %>%
  mutate(margin = Trump - Clinton) %>%
  ggplot(aes(x = margin, y = reorder(State, margin, FUN = median, na.rm = TRUE))) +
  geom_vline(xintercept = 0, linetype = "dashed") +
  geom_boxplot() +
  labs(
    x = "Trump - Clinton margin",
    y = "State",
    title = "Distribution of 2016 Polling Margins by State"
  )
