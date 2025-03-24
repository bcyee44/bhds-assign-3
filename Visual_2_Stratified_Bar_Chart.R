###Visualization 2:
# stratified_bar_chart.R
# Stratified Bar Chart of Text Messages by Group and Time
# Author: Collaborative GitHub Project Team/Veronica Leary
# Description: This script generates a stratified bar chart with a Wes Anderson color palette using ggplot2 and dplyr

# set working directory as folder on desktop
# setwd("C:/Users/brand/OneDrive/Desktop/BHDS2010/ASSIGN3/bhds-assign-3")
# setwd("/Users/vleary71/Desktop/BHDS2010/ASSIGN3/bhds-assign-3")
# successfully set working directory

# Load necessary libraries
library(ggplot2)        # For plotting
library(dplyr)          # For data manipulation
library(tidyr)          # For reshaping data
library(wesanderson)    # For Wes Anderson-inspired color palettes

# Load and clean the dataset
data <- read.csv("TextMessages.csv")  # Load dataset

# Rename columns for clarity
colnames(data) <- c("Group", "Baseline", "Six_months", "Participant")

# Remove redundant header row
data <- data[-1, ]

# Convert data types and reshape
data <- data %>%
  mutate(across(c(Baseline, Six_months), as.numeric),
         Group = as.factor(Group)) %>%
  pivot_longer(cols = c(Baseline, Six_months),
               names_to = "Time",
               values_to = "TextMessages")

# Create a stratified bar chart
data %>%
  group_by(Group, Time) %>%
  summarise(TotalMessages = sum(TextMessages, na.rm = TRUE), .groups = "drop") %>%
  ggplot(aes(x = Time, y = TotalMessages, fill = Group)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~ Group) +
  scale_fill_manual(values = wes_palette("Rushmore", n = 2)) +
  labs(title = "Stratified Bar Chart of Text Messages by Group and Time",
       x = "Time Point",
       y = "Total Text Messages") +
  theme_minimal(base_size = 14) +
  theme(legend.position = "none")
