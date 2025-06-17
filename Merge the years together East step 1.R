library(dplyr)

# Define the base path
base_path <- "~/Documents/GitHub/PM2.5/data/east europe data/"

# Helper function to safely read tab-separated UTF-16LE files
read_tsv_utf16 <- function(filename, year) {
  path <- paste0(base_path, filename)
  df <- read.delim(path, fileEncoding = "UTF-16LE", sep = "\t", check.names = TRUE)
  df$Year <- year
  df <- df[, !duplicated(names(df))]  # Remove any duplicated columns
  return(df)
}

# Read each year
data_2018 <- read_tsv_utf16("2018.csv", 2018)
data_2019 <- read_tsv_utf16("2019.csv", 2019)
data_2020 <- read_tsv_utf16("2020.csv", 2020)
data_2021 <- read_tsv_utf16("2021.csv", 2021)
data_2022 <- read_tsv_utf16("2022.csv", 2022)
data_2023 <- read_tsv_utf16("2023.csv", 2023)

# Combine all datasets
all_data <- bind_rows(
  data_2018, data_2019, data_2020,
  data_2021, data_2022, data_2023
)

# Save the combined dataset
write.csv(all_data, "~/Documents/GitHub/PM2.5//All_Years_East_Combined.csv", row.names = FALSE)


# Optional: preview the result
print(head(all_data))
