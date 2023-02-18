# This is a file to handle global data.
# Feel free to add initialization code for global here.
library(dplyr)
library(ggplot2)
library(stringr)

# Turn off scientific notation
options(scipen = 999)

# Load csv data and combine them.
# Data source: https://canvas.uw.edu/courses/1613223/files/102089304/download?download_frd=1

np_data <- read.csv(
  paste0("D:\\Study\\[2023.1Q.UW - INFO 201] Foundational Skills for Data Science\\Assignment\\3 - SPL Library\\50-Checkouts-SPL-Data.csv"),
  stringsAsFactors = FALSE,
)

# Organize publication year column.
# Only take a 4-digit number in a row that appears first.
np_data$PublicationYear <- as.numeric(str_extract(as.character(np_data$PublicationYear), "(?<!\\d)\\d{4}(?!\\d)", group = 0))

# Organize creator column
# Calculate first, last name properly.
organize_name <- function(full_name) {
  name_words <- str_extract_all(full_name, "(\\w[^,]+)", simplify = TRUE)
  cnt_words <- length(name_words)

  if (cnt_words == 0) {
    # If there is no name, return NULL
    return("")
  } else if (cnt_words == 1) {
    # If there is no comma, just return in that order (First Name + Last Name)
    return(name_words[1])
  } else if (cnt_words >= 2) {
    # If there is commas, return in reverse order (Last Name, First Name => First Name + Last Name)
    return(paste(name_words[2], name_words[1]))
  }
}

np_data$Creator <- as.character(lapply(np_data$Creator, organize_name))

# Add a lifespan column
np_data <- np_data %>%
  mutate(Lifespan = CheckoutYear - PublicationYear)
