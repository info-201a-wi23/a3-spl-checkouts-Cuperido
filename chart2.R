# The init.R file must be executed before this R file.

# Load a chart library
library(ggplot2)

# Duplicate np_data to avoid manipulating the original data frame.
df <- np_data

# Group by year and book type.
df <- df %>%
  select(UsageClass, Lifespan, Checkouts) %>%
  filter(Lifespan >= 0 & Lifespan <= 10) %>%
  group_by(UsageClass, Lifespan) %>%
  summarize(Checkouts = sum(Checkouts), .groups = "drop")

# Draw a line chart.
ggplot(df) +
  aes(
    x = Lifespan,
    y = Checkouts
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
    aes(label = Checkouts),
    vjust = -1,
    size = 3,
    color = "#606060",
    check_overlap = TRUE
  ) +
  labs(
    title = "The total number of checkouts per year after publication",
    x = "Elapsed Years after Publication",
    y = "Checkouts"
  ) +
  guides(
    color = guide_legend(title = "Book Type")
  ) +
  scale_x_continuous(
    breaks = seq(0, 10, 1)
  ) +
  scale_y_continuous(
    breaks = seq(0, 4500000, 500000)
  ) +
  theme(
    legend.position = c(0.92, 0.87)
  )

