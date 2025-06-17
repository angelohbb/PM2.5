library(readr)
MortaliteitDataset <- read_csv("Desktop/Programming opdracht/2eDataset.csv")

PM25Dataset <- read_csv("Desktop/Programming opdracht/Average_PM25_By_Country_Year.csv")


#merge
MergedData <- full_join(MortaliteitDataset, PM25Dataset, by = c("year_of_statistics", "country"))

write_csv(MergedData, file.path(path.expand("~/Desktop/Programming opdracht"), "MergedData.csv"))
