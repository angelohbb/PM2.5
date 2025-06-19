# Load required package
library(dplyr)

# Step 1: Read the cleaned CSV file
df <- read.csv("~/Documents/GitHub/PM2.5/Combined_East_West_clean.csv")

# Step 2: Group by country, region, and year, then calculate average PM2.5
avg_pm25_by_country_year <- df %>%
  group_by(country, region, year_of_statistics) %>%
  summarise(average_pm25 = mean(air_pollution_level, na.rm = TRUE)) %>%
  arrange(year_of_statistics, region, country)

# Step 3: View result
print(avg_pm25_by_country_year)

# Step 4: Save to CSV
write.csv(
  avg_pm25_by_country_year,
  "~/Documents/GitHub/PM2.5/Average_PM25_By_Country_Year.csv",
  row.names = FALSE
)

