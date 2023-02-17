# The init.R file must be executed before this R file.

# Load a string and table libraries
library(dplyr)
library(stringr)

# Duplicate np_data to avoid manipulating the original data frame.
df <- np_data

# Initialize a summary info list
summary <- list()

# Q1. The total number of records.
summary$num_records <- format(
  nrow(df),
  big.mark = ",",
  scientific = FALSE)

# Q2. The total number of bestsellers.
df_unique <- df %>%
  group_by(Creator, Title) %>% 
  summarize(Checkouts = sum(Checkouts), .groups = 'drop')

summary$num_books <- format(
  nrow(df_unique),
  big.mark = ",",
  scientific = FALSE)

# Q3. The number of checkouts of the most checked-out books.
summary$most_checkout <- df_unique %>%
  summarize(max(Checkouts)) %>% 
  pull()
summary$most_checkout <- format(
  summary$most_checkout,
  big.mark = ",",
  scientific = FALSE)

# Q4. Checkout rate between physical vs digital.
df_physical <- df %>% 
  filter(UsageClass == "Physical")
df_digital <- df %>% 
  filter(UsageClass == "Digital")

ntotal <- nrow(df_physical) + nrow(df_digital)

summary$rate_physical <- sprintf(
  nrow(df_physical) / ntotal * 100,
  fmt = '%#.1f%%')
summary$rate_digital <- sprintf(
  nrow(df_digital) / ntotal * 100,
  fmt = '%#.1f%%')

# Q5. The total number of authors of the bestsellers.
summary$authros <- df %>%
  summarize(n_distinct(Creator)) %>% 
  pull()
summary$authros <- format(
  summary$authros,
  big.mark = ",",
  scientific = FALSE)

# Q6. The average duration of popularity.
summary$duration <- sprintf(
  df %>%
    summarize(mean(Lifespan, na.rm = TRUE)) %>% 
    pull(),
  fmt = '%#.1f')

