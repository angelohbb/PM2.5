# 1. Install packages (if not installed yet)
install.packages(c("ggplot2", "readr", "dplyr"))

# 2. Load libraries
library(ggplot2)
library(readr)
library(dplyr)

# 3. Load and clean data
df <- read_csv("/Users/angelohabib/Desktop/Programming PM2_5/MergedData.csv")
df$average_pm25 <- as.numeric(df$average_pm25)
df_clean <- na.omit(df)

# 4. Define East and West Europe countries
east_countries <- c(
  "Poland", "Czechia", "Slovakia", "Hungary", "Romania", 
  "Bulgaria", "Lithuania", "Latvia", "Estonia", "Slovenia", 
  "Croatia"
)

# 5. Add region_group column (East or West)
df_clean <- df_clean %>%
  mutate(region_group = ifelse(country %in% east_countries, "East", "West"))

# 6. Group by region and year, calculate average PM2.5
region_pm25 <- df_clean %>%
  group_by(region_group, year_of_statistics) %>%
  summarise(avg_pm25 = mean(average_pm25, na.rm = TRUE)) %>%
  ungroup()

# 7. Plot: East vs West average PM2.5 over time
ggplot(region_pm25, aes(x = factor(year_of_statistics), y = avg_pm25, fill = region_group)) +
  geom_bar(stat = "identity", position = position_dodge(width = 0.7)) +
  geom_text(aes(label = round(avg_pm25, 2)), 
            position = position_dodge(width = 0.7), 
            vjust = -0.3, size = 3.5, fontface = "bold") +
  theme_minimal(base_size = 13) +
  labs(
    title = "Average PM2.5 in East vs West Europe Over Time",
    x = "Year",
    y = "Average PM2.5 (µg/m³)",
    fill = "Region"
  ) +
  scale_fill_manual(values = c("East" = "#E69F00", "West" = "#56B4E9")) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    plot.title = element_text(face = "bold", size = 15, hjust = 0.5)
  )


write.csv(df_clean, "data/.csv")
