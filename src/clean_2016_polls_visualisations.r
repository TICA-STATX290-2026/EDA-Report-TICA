# Xuan - this script visualises the cleaned 2016 state polls in data\cleaned\state_polls_2016_clean.csv
# This script produces two plots: one showing the average margin by state, and another showing the distribution of margins by state

library(tibble)
library(readr)
library(naniar)
library(dplyr)
library(ggplot2)
library(GGally)

polls <- read_csv("data/cleaned/state_polls_2016_clean.csv")

# plot: average margin by state
polls %>%
  mutate(margin = trump - clinton) %>%
  group_by(state) %>%
  summarise(avg_margin = mean(margin, na.rm = TRUE)) %>%
  ggplot(aes(x = avg_margin, y = reorder(state, avg_margin))) +
  geom_vline(xintercept = 0) +
  geom_col() +
  labs(
    x = "Average Trump - Clinton margin",
    y = "State",
    title = "Average 2016 Polling Margin by State"
  )


# second version: distribution of margins by state
polls %>%
  mutate(margin = trump - clinton) %>%
  ggplot(aes(x = margin, y = reorder(state, margin, FUN = median, na.rm = TRUE))) +
  geom_vline(xintercept = 0, linetype = "dashed") +
  geom_boxplot() +
  labs(
    x = "Trump - Clinton margin",
    y = "State",
    title = "Distribution of 2016 Polling Margins by State"
  )
