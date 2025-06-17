# 1. Load required packages
if (!requireNamespace("readxl", quietly = TRUE)) install.packages("readxl")
if (!requireNamespace("dplyr", quietly = TRUE)) install.packages("dplyr")
if (!requireNamespace("tidyr", quietly = TRUE)) install.packages("tidyr")

library(readxl)
library(dplyr)
library(tidyr)

# 2. Define file path (expand ~ for cross-platform compatibility)
excel_path <- path.expand("~/Documents/GitHub/PM2.5/sdg_11_52_page_spreadsheet-3.xlsx")

# 3. Read the Excel file, skipping the first 9 rows
df_raw <- read_excel(excel_path, skip = 9)

# 4. Restructure to long format
df_long <- df_raw %>%
  rename(country = TIME) %>%
  pivot_longer(
    cols = -country,
    names_to = "year_of_statistics",
    values_to = "premature_deaths",
    values_drop_na = TRUE
  )

# 5. Save the cleaned long-format dataset
write.csv(
  df_long,
  path.expand("~/Documents/GitHub/PM2.5/2eDataset.csv"),
  row.names = FALSE
)

# Optional: Preview
head(df_long)
