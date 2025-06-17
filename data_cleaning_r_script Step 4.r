# Interactive Data Cleaning Script for Combined_East_West CSV

# 1. Install and load required packages
if (!requireNamespace("readr", quietly = TRUE)) install.packages("readr")
if (!requireNamespace("dplyr", quietly = TRUE)) install.packages("dplyr")
if (!requireNamespace("janitor", quietly = TRUE)) install.packages("janitor")
library(readr)
library(dplyr)
library(janitor)

# 2. Choose the CSV file interactively to avoid path issues
csv_path <- file.choose()
message("Selected file: ", csv_path)

# 3. Read raw data and inspect immediately
#    Common NA markers: "", "NA", "NaN"
df_raw <- read_csv(
  file           = csv_path,
  na             = c("", "NA", "NaN"),
  show_col_types = FALSE
)

# Debug: print first rows and dimensions of raw data
message("Raw data rows: ", nrow(df_raw), "; columns: ", ncol(df_raw))
print(head(df_raw, n = 10))

# 4. Cleaning pipeline (basic)
#    * Normalize column names to snake_case
#    * Trim whitespace in character columns
#    * Convert empty strings to NA

 df_clean <- df_raw %>%
  clean_names() %>%
  mutate(across(where(is.character), str_trim)) %>%
  mutate(across(where(is.character), ~ na_if(., "")))

# Debug: dimensions after basic cleaning
message("After basic cleaning rows: ", nrow(df_clean), "; columns: ", ncol(df_clean))
print(head(df_clean, n = 10))

# 5. Optional further steps (uncomment as needed)
# df_clean <- df_clean %>% mutate(across(where(is.character), as.factor))     # to factors
# df_clean <- df_clean %>% distinct()                                         # remove duplicates
# df_clean <- df_clean %>% drop_na(key_column1, key_column2)                  # drop NA in specific cols

# 6. Summary of NA counts per column (for diagnostics)
na_summary <- sapply(df_clean, function(x) sum(is.na(x)))
print(na_summary)

# 7. Write cleaned data to disk alongside input file
output_path <- file.path(dirname(csv_path), paste0(tools::file_path_sans_ext(basename(csv_path)), "_clean.csv"))
write_csv(df_clean, file = output_path)
message("Cleaned data saved to: ", output_path)
