# 1. Install and load required packages
if (!requireNamespace("readr", quietly = TRUE)) install.packages("readr")
if (!requireNamespace("dplyr", quietly = TRUE)) install.packages("dplyr")
if (!requireNamespace("janitor", quietly = TRUE)) install.packages("janitor")
if (!requireNamespace("stringr", quietly = TRUE)) install.packages("stringr")

library(readr)
library(dplyr)
library(janitor)
library(stringr)

# 2. Set CSV path directly instead of using file.choose()
csv_path <- "~/Documents/GitHub/PM2.5/Combined_East_West.csv"
csv_path <- path.expand(csv_path)  # ensures ~ is correctly expanded on all systems

if (!file.exists(csv_path)) stop("❌ File not found: ", csv_path)
message("✅ Using file: ", csv_path)

# 3. Read the raw data
df_raw <- read_csv(
  file           = csv_path,
  na             = c("", "NA", "NaN"),
  show_col_types = FALSE
)

message("📄 Raw data: ", nrow(df_raw), " rows × ", ncol(df_raw), " columns")
print(head(df_raw, 10))

# 4. Clean the data
df_clean <- df_raw %>%
  clean_names() %>%
  mutate(across(where(is.character), str_trim)) %>%
  mutate(across(where(is.character), ~na_if(., "")))

message("🧼 Cleaned data: ", nrow(df_clean), " rows × ", ncol(df_clean), " columns")
print(head(df_clean, 10))

# 5. Optional transformations (uncomment as needed)
# df_clean <- df_clean %>% mutate(across(where(is.character), as.factor))
# df_clean <- df_clean %>% distinct()
# df_clean <- df_clean %>% drop_na(key_column1, key_column2)

# 6. NA summary
na_summary <- sapply(df_clean, function(x) sum(is.na(x)))
message("🕳️ NA values per column:")
print(na_summary)

# 7. Save cleaned data
output_path <- file.path(
  dirname(csv_path),
  paste0(tools::file_path_sans_ext(basename(csv_path)), "_clean.csv")
)
write_csv(df_clean, output_path)
message("✅ Cleaned data saved to: ", output_path)
