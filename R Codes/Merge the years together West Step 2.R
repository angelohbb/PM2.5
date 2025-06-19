library(dplyr)

# Define base folder path
base_path <- "~/Documents/GitHub/PM2.5/data/west europe data/"

# Function to read UTF-16LE tab-separated files
read_tsv_utf16 <- function(filename, year) {
  path <- paste0(base_path, filename)
  df <- read.delim(path, fileEncoding = "UTF-16LE", sep = "\t", check.names = TRUE)
  df$Year <- year
  df <- df[, !duplicated(names(df))]  # Remove duplicated columns if any
  return(df)
}

# Load each year (west files)
data_2018 <- read_tsv_utf16("2018 west.csv", 2018)
data_2019 <- read_tsv_utf16("2019 west.csv", 2019)
data_2020 <- read_tsv_utf16("2020 west.csv", 2020)
data_2021 <- read_tsv_utf16("2021 west.csv", 2021)
data_2022 <- read_tsv_utf16("2022 west.csv", 2022)
data_2023 <- read_tsv_utf16("2023 west.csv", 2023)

# Combine all years
all_data_west <- bind_rows(
  data_2018, data_2019, data_2020,
  data_2021, data_2022, data_2023
)

# Save the combined West Europe dataset
write.csv(all_data_west, "~/Documents/GitHub/PM2.5/All_Years_Combined_West.csv", row.names = FALSE)

# Preview the first few rows (optional)
print(head(all_data_west))
