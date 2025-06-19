# 1. Install necessary packages (if not installed)
install.packages(c("ggplot2", "readr", "dplyr"))

# 2. Load libraries
library(ggplot2)
library(readr)
library(dplyr)

# 3. Load and clean data
df <- read_csv("/Users/angelohabib/Desktop/Programming PM2_5/MergedData.csv")
df$average_pm25 <- as.numeric(df$average_pm25)
df_clean <- na.omit(df)

# 4. Define the event year (COVID-19 lockdown year)
event_year <- 2020

# 5. Aggregate average PM2.5 by year
pm25_event <- df_clean %>%
  group_by(year_of_statistics) %>%
  summarise(avg_pm25 = mean(average_pm25, na.rm = TRUE)) %>%
  ungroup()

# 6. Plot: PM2.5 over time with COVID-19 lockdown marker
ggplot(pm25_event, aes(x = year_of_statistics, y = avg_pm25)) +
  geom_line(color = "darkgreen", size = 1.2) +
  geom_point(color = "darkgreen", size = 3) +
  geom_vline(xintercept = event_year, linetype = "dashed", color = "red", size = 1) +
  annotate("text", x = event_year + 0.3, y = max(pm25_event$avg_pm25), 
           label = "2020 COVID-19 Lockdown", color = "red", fontface = "bold", angle = 90, hjust = -0.1) +
  geom_text(aes(label = round(avg_pm25, 2)), vjust = -0.8, size = 3.5, fontface = "bold") +
  theme_minimal(base_size = 13) +
  labs(
    title = "Impact of COVID-19 Lockdown on PM2.5 Levels in Europe",
    x = "Year",
    y = "Average PM2.5 (µg/m³)"
  ) +
  theme(
    plot.title = element_text(face = "bold", size = 15, hjust = 0.5),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )



