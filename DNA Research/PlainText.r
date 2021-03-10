library(plyr)
library(readr)
setwd("~/Years")

#Gives the list of all the years
myFiles <- list.files(pattern = "*.csv", full.names = TRUE)
myFiles

#Reads all the csv into one file
dat_csv <- ldply(myFiles, read_csv)


#Creates a csv/text file with all the records that have been extracted
write.csv(dat_csv, file = "DNA Research.csv")

write.table(dat_csv, file = "DNA Research.txt", sep = "\t", col.names = TRUE)

#Read in the delivered plain text file
DNA <- read.table("DNA Research.txt")

