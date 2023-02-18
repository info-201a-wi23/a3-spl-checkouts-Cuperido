# The init.R file must be executed before this R file.

# Load a string and table libraries
library(knitr)

# Definition of NAICS codes.
df <- data.frame(
  "Information" = c(
    "The total number of checkout records for popular books over the entire period",
    "The total unique number of the popular books",
    "The number of checkouts of the most popular book over the entire period",
    "Checkout rate between physical vs digital books",
    "The total number of authors of the popular books",
    "The average duration of popularity"
  ),
  "Results" = c(
    paste(summary$num_records, "records"),
    paste(summary$num_books, "books"),
    paste(summary$most_checkout, "checkouts"),
    paste0("Physical (", summary$rate_physical, ") / Digital (", summary$rate_digital, ")"),
    paste(summary$authros, "authors"),
    paste(summary$duration, "years")
  ),
  stringsAsFactors = FALSE
)

kable(df)
