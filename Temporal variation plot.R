# 1. Install packages (if not yet installed)
install.packages(c("ggplot2", "readr", "dplyr"))

# 2. Load libraries
library(ggplot2)
library(readr)
library(dplyr)

# 3. Load and clean data
df <- read_csv("Documents/Github/PM2.5/MergedData.csv")
df$average_pm25 <- as.numeric(df$average_pm25)
df_clean <- na.omit(df)

# 4. Group by year and compute average PM2.5
pm25_trend <- df_clean %>%
  group_by(year_of_statistics) %>%
  summarise(avg_pm25 = mean(average_pm25, na.rm = TRUE)) %>%
  ungroup()

# 5. Plot: PM2.5 trend over time
ggplot(pm25_trend, aes(x = year_of_statistics, y = avg_pm25)) +
  geom_line(color = "steelblue", size = 1.2) +
  geom_point(color = "steelblue", size = 3) +
  geom_text(aes(label = round(avg_pm25, 2)), vjust = -0.8, size = 3.5, fontface = "bold") +
  theme_minimal(base_size = 13) +
  labs(
    title = "Average PM2.5 Over Time in Europe",
    x = "Year",
    y = "Average PM2.5 (µg/m³)"
  ) +
  theme(
    plot.title = element_text(face = "bold", size = 15, hjust = 0.5),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )


