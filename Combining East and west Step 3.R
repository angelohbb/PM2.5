# Install and load dplyr if not already installed
if (!require(dplyr)) install.packages("dplyr", dependencies = TRUE)
library(dplyr)

# 🔧 Correct the file paths
east <- read.csv("desktop/programming opdracht/East europe data/All_Years_East_Combined.csv")
west <- read.csv("desktop/programming opdracht/west Europe data/All_Years_Combined_West.csv")

# 🔧 Ensure the column exists and convert to character only if needed
if ("Threshold.1" %in% colnames(east)) {
  east$Threshold.1 <- as.character(east$Threshold.1)
}
if ("Threshold.1" %in% colnames(west)) {
  west$Threshold.1 <- as.character(west$Threshold.1)
}

# Add region labels
east$Region <- "East"
west$Region <- "West"

# Combine both datasets
combined_data <- bind_rows(east, west)

# 🔧 Fix output path (you used "~desktop" which is invalid)
write.csv(combined_data, "desktop/programming opdracht/Combined_East_West.csv", row.names = FALSE)

# Optional: preview
head(combined_data)
