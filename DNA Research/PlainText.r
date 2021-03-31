library(plyr)
library(readr)
setwd("~/Years")

#Gives the list of all the years
myFiles <- list.files(pattern = "*.csv", full.names = TRUE)
myFiles

#Reads all the csv into one file
dat_csv <- ldply(myFiles, read_csv)


#Creates a text file with all the records that have been extracted
write.table(dat_csv, file = "DNA Research.txt", sep = "\t", col.names = TRUE)

DNA <- read.table("DNA Research.txt")
View(DNA)
