# The init.R file must be executed before this R file.

# Load a chart library
library(ggplot2)

# Duplicate np_data to avoid manipulating the original data frame.
df <- np_data

# Group records by year so that it eliminates duplication of months.
df <- df %>%
  group_by(UsageClass, Creator, Title, CheckoutYear) %>%
  summarize(Checkouts = sum(Checkouts), .groups = "drop")

# Group by year and book type.
df <- df %>%
  select(UsageClass, CheckoutYear, Checkouts) %>%
  group_by(UsageClass, CheckoutYear) %>%
  summarize(Books = n(), .groups = "drop")

# Draw a line chart.
ggplot(df) +
  aes(
    x = CheckoutYear,
    y = Books
  ) +
  geom_line(
    aes(color = UsageClass),
    size = 0.8
  ) +
  geom_point(
    aes(color = UsageClass),
    size = 3
  ) +
  geom_text(
    aes(label = Books),
    size = 3,
    vjust = -1,
    color = "#606060",
    check_overlap = TRUE
  ) +
  labs(
    title = "The total number of popular books by year",
    x = "Year",
    y = "Number of Books"
  ) +
  guides(
    color = guide_legend(title = "Book Type")
  ) +
  scale_x_continuous(
    breaks = seq(2000, 2025, 1)
  ) +
  scale_y_continuous(
    breaks = seq(0, 2000, 200)
  ) + 
  theme(
    legend.position = c(0.06, 0.89)
  )

