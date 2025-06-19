# ----------------------------------------
# STEP 1: Install required packages
# ----------------------------------------
packages <- c("rnaturalearth", "rnaturalearthdata", "sf", "ggplot2", "dplyr", "readr")

installed <- rownames(installed.packages())
for (pkg in packages) {
  if (!(pkg %in% installed)) install.packages(pkg)
}

# ----------------------------------------
# STEP 2: Load libraries
# ----------------------------------------
library(rnaturalearth)
library(rnaturalearthdata)
library(sf)
library(ggplot2)
library(dplyr)
library(readr)

# ----------------------------------------
# STEP 3: Load and clean your dataset
# ----------------------------------------
MergedData <- read_csv("~/Desktop/programming opdracht/spreadsheets/MergedData.csv")

# Convert deaths to numeric (remove commas)
MergedData$Premature_deaths <- as.numeric(gsub(",", "", MergedData$Premature_deaths))

# Filter: only rows with complete PM2.5 and death data
spatial_data <- MergedData %>%
  filter(!is.na(Premature_deaths), !is.na(average_pm25)) %>%
  group_by(country) %>%
  summarise(
    avg_pm25 = mean(average_pm25, na.rm = TRUE),
    avg_deaths = mean(Premature_deaths, na.rm = TRUE)
  )

# ----------------------------------------
# STEP 4: Load world map and merge with your data
# ----------------------------------------
world <- ne_countries(scale = "medium", returnclass = "sf")

# Merge map with your country-level data
map_data <- left_join(world, spatial_data, by = c("name" = "country"))

# Optional: Keep only Europe for clarity
map_data <- map_data %>% filter(region_un == "Europe")

# ----------------------------------------
# STEP 5: Plot the PM2.5 map (single-hue gradient)
# ----------------------------------------
ggplot(map_data) +
  geom_sf(aes(fill = avg_pm25), color = "white", size = 0.2) +
  scale_fill_gradient(
    low = "#c6dbef",    # light blue
    high = "#08306b",   # dark blue
    na.value = "lightgrey"
  ) +
  labs(
    title = "Spatial Variation of Average PM2.5 in Europe",
    subtitle = "Darker colors indicate higher pollution levels",
    fill = "Avg PM2.5 (µg/m³)",
    caption = "Countries with missing data are shown in grey."
  ) +
  coord_sf(
    xlim = c(-15, 35),   # Longitude range for Europe
    ylim = c(35, 60),    # Latitude range for Europe
    expand = FALSE
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold"),
    plot.subtitle = element_text(size = 12),
    legend.title = element_text(size = 11),
    legend.text = element_text(size = 10)
  )
