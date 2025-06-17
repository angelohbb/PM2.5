# Install required packages (run once)
install.packages("readxl")
install.packages("dplyr")
install.packages("writexl")  # For writing Excel files

# Load libraries
library(readxl)
library(dplyr)
library(writexl)

# Correct file path
file_path <- "/Users/angelohabib/Downloads/Programming PM2_5/sdg_11_52_page_spreadsheet-3.xlsx"

# Read the Excel file
df <- read_excel(file_path, sheet = "Sheet 1", skip = 5)
names(df)[1] <- "Country"

# Filter for selected countries
target_countries <- c("Poland", "Bulgaria", "Hungary", "Romania", "Lithuania",
                      "Slovakia", "Latvia", "Estonia", "Netherlands", "Belgium",
                      "Luxembourg", "Germany", "France", "Austria", "Ireland")

filtered_df <- df %>%
  filter(Country %in% target_countries)

# Save the filtered data to a new Excel file
output_path <- "/Users/angelohabib/Downloads/filtered_countries_PM2_5.xlsx"
write_xlsx(filtered_df, path = output_path)

# Confirmation message
cat("Filtered Excel file saved to:", output_path, "\n")
