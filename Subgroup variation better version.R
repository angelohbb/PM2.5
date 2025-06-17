# ----------------------------------------
# STEP 1: Install & load required libraries
# ----------------------------------------
packages <- c("ggplot2", "dplyr", "readr", "forcats")
installed <- rownames(installed.packages())
for (pkg in packages) {
  if (!(pkg %in% installed)) install.packages(pkg)
}
library(ggplot2)
library(dplyr)
library(readr)
library(forcats)

# ----------------------------------------
# STEP 2: Load and clean your dataset
# ----------------------------------------
MergedData <- read_csv("~/Desktop/programming opdracht/spreadsheets/MergedData.csv")
MergedData$Premature_deaths <- as.numeric(gsub(",", "", MergedData$Premature_deaths))

# Filter only countries with both death and PM2.5 data
filtered_data <- MergedData %>%
  filter(!is.na(Premature_deaths), !is.na(average_pm25))

# ----------------------------------------
# STEP 3: List of countries with data
# ----------------------------------------
countries_with_data <- unique(filtered_data$country)

# ----------------------------------------
# STEP 4: Add population and region for those countries
# ----------------------------------------
population_region_df <- tibble::tibble(
  country = c(
    "Austria", "Belgium", "Bulgaria", "Estonia", "France", "Germany", "Hungary",
    "Ireland", "Latvia", "Lithuania", "Luxembourg", "Netherlands", "Poland",
    "Romania", "Slovakia", "Slovenia"
  ),
  population = c(
    9, 11.5, 6.5, 1.3, 67, 83, 9.6, 5.1, 1.9, 2.8, 0.65, 17, 38, 19, 5.4, 2.1
  ) * 1e6,
  region = c(
    "Western", "Western", "Eastern", "Eastern", "Western", "Western", "Eastern",
    "Western", "Eastern", "Eastern", "Western", "Western", "Eastern", "Eastern",
    "Eastern", "Eastern"
  )
)

# ----------------------------------------
# STEP 5: Compute average deaths and merge
# ----------------------------------------
avg_deaths <- filtered_data %>%
  group_by(country) %>%
  summarise(avg_deaths = mean(Premature_deaths, na.rm = TRUE)) %>%
  inner_join(population_region_df, by = "country") %>%
  mutate(
    deaths_per_100k = (avg_deaths / population) * 100000,
    country = fct_reorder(country, deaths_per_100k)
  )

# ----------------------------------------
# STEP 6: Plot bar chart with region coloring
# ----------------------------------------
ggplot(avg_deaths, aes(x = country, y = deaths_per_100k, fill = region)) +
  geom_col() +
  coord_flip() +
  scale_fill_manual(values = c("Western" = "steelblue", "Eastern" = "tomato")) +
  labs(
    title = "PM2.5-Related Premature Deaths per 100,000 People",
    subtitle = "Western vs Eastern Europe",
    x = "Country",
    y = "Deaths per 100,000",
    fill = "Region"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    axis.text.y = element_text(size = 10)
  )
