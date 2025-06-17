library(dplyr)

# Load datasets
east <- read.csv("~/Documents/GitHub/PM2.5/All_Years_East_Combined.csv", check.names = TRUE)
west <- read.csv("~/Documents/GitHub/PM2.5/All_Years_Combined_West.csv", check.names = TRUE)

# Add Region
east$Region <- "East"
west$Region <- "West"

# Ensure both have 'Threshold.1' column
if (!"Threshold.1" %in% colnames(east)) {
  east$Threshold.1 <- NA_character_
}
if (!"Threshold.1" %in% colnames(west)) {
  west$Threshold.1 <- NA_character_
}

# Force 'Threshold.1' to character in both
east$Threshold.1 <- as.character(east$Threshold.1)
west$Threshold.1 <- as.character(west$Threshold.1)

# Align both datasets to shared columns
common_cols <- intersect(names(east), names(west))
east <- east[, common_cols]
west <- west[, common_cols]

# Combine
combined_data <- bind_rows(east, west)

# Save
write.csv(combined_data, "~/Documents/GitHub/PM2.5/Combined_East_West.csv", row.names = FALSE)

# Preview
head(combined_data)
