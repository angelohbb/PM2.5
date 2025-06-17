# Install packages (only run once if not already installed)
install.packages("readxl")
install.packages("writexl")
install.packages("dplyr")

# Load libraries
library(readxl)
library(writexl)
library(dplyr)

# ✅ Use the correct file path and name
file_path <- "/Users/angelohabib/Desktop/Programming PM2_5/filtered_countries_PM2_5.xlsx"

# Read the Excel file
df <- read_excel(file_path)

# Define the countries you want
target_countries <- c("Poland", "Bulgaria", "Hungary", "Romania", "Lithuania",
                      "Slovakia", "Latvia", "Estonia", "Netherlands", "Belgium",
                      "Luxembourg", "Germany", "France", "Austria", "Ireland")

# Filter to only those countries and select 2018–2022 data columns
filtered_df <- df %>%
  filter(Country %in% target_countries) %>%
  select(
    Country,
    "...26",  # 2018
    "...28",  # 2019
    "...30",  # 2020
    "...32",  # 2021
    "...34"   # 2022
  )

# Rename the columns for clarity
colnames(filtered_df) <- c("Country", "2018", "2019", "2020", "2021", "2022")

# Save the filtered data to a new Excel file on the Desktop
output_path <- "/Users/angelohabib/Desktop/filtered_PM2_5_2018_2022_final.xlsx"
write_xlsx(filtered_df, path = output_path)

# Optional: Automatically open the file in Excel (macOS only)
system(paste("open", output_path))
