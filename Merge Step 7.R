library(readr)
MortaliteitDataset <- read_csv("~/Documents/GitHub/PM2.5/2eDataset.csv")

PM25Dataset <- read_csv("~/Documents/GitHub/PM2.5/Average_PM25_By_Country_Year.csv")


#merge
MergedData <- full_join(MortaliteitDataset, PM25Dataset, by = c("year_of_statistics", "country"))

write_csv(MergedData, file.path(path.expand("~/Documents/GitHub/PM2.5/"), "MergedData.csv"))
