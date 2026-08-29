# Xuan - this script visualises the cleaned 2016 state polls in data\clean\state_polls_2016_clean.csv
# This script produces two plots: one showing the average margin by state, and another showing the distribution of margins by state

library(tibble)
library(readr)
library(naniar)
library(dplyr)
library(ggplot2)
library(GGally)
library(tidyverse)

polls <- read_csv("data/clean/state_polls_2016_clean.csv")

# Reshape data to wide format so Trump and Clinton are individual columns
polls_wide <- polls %>%
  filter(candidate %in% c("Trump", "Clinton")) %>%
  pivot_wider(
    names_from = candidate, 
    values_from = support
  )

# plot: average margin by state
polls_wide %>%
  mutate(margin = Trump - Clinton) %>%
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
polls_wide %>%
  mutate(margin = Trump - Clinton) %>%
  ggplot(aes(x = margin, y = reorder(state, margin, FUN = median, na.rm = TRUE))) +
  geom_vline(xintercept = 0, linetype = "dashed") +
  geom_boxplot() +
  labs(
    x = "Trump - Clinton margin",
    y = "State",
    title = "Distribution of 2016 Polling Margins by State"
  )
