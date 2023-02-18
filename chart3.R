# The init.R file must be executed before this R file.

# Load a chart library
library(ggplot2)

# Turn off scientific notation
options(scipen = 999)

# Duplicate np_data to avoid manipulating the original data frame.
df <- np_data

# Group by creator and book type.
df <- df %>%
  select(UsageClass, Creator, Checkouts) %>%
  filter(Creator != "") %>%
  group_by(UsageClass, Creator) %>%
  summarize(Checkouts = sum(Checkouts), .groups = "drop") %>%
  arrange(-Checkouts) %>%
  head(10)

# Draw a bar chart.
ggplot(df) +
  aes(
    x = Checkouts,
    y = reorder(Creator, Checkouts, sum),
  ) +
  geom_bar(
    stat = "identity",
    aes(fill = UsageClass),
    width = 0.75,
  ) +
  geom_text(
    aes(label = Checkouts),
    size = 3,
    hjust = -0.1,
    vjust = 0.3,
    color = "#404040",
  ) +
  labs(
    title = "The total number of checkouts of the books written by the top 10 most popular authors",
    x = "Total Checkouts",
    y = "Authors"
  ) +
  guides(
    color = guide_legend(title = "Book Type")
  ) +
  xlim(0, 210000) +
  theme(
    legend.position = c(0.89, 0.17)
  )

