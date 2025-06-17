sdg_11_52_page_spreadsheet_3 <- read_excel("Desktop/Programming opdracht/sdg_11_52_page_spreadsheet-3.xlsx", 
                                           skip = 9)

# restructure
df_long <- sdg_11_52_page_spreadsheet_3 %>%
  rename(country = 'TIME') %>%
  pivot_longer(
    cols = -country,
    names_to = "year_of_statistics",
    values_to = "Premature_deaths",
    values_drop_na = TRUE
  )

# Save to CSV
write.csv(
  df_long,
  "desktop/programming opdracht/2eDataset.csv",
  row.names = FALSE
)