library(rvest)
library(stringr)
# SET WORKING DIRECTORY IN RSTUDIO
source('scraperV5.R')
# Need to convert script into functions
year <- 2021
raw_links <- getYearLinks(year)
LEN <- length(raw_links)
year_links <- vector("list", length=LEN)
for(i in 1:LEN){
  year_links[i] <- paste("https://academic.oup.com",raw_links[i],sep="")
}
# MAKE INTO FUNCTION
MASTER_PAGES <- vector("list", length=LEN)
print(paste('Est time to completion:', length(MASTER_PAGES), 'minutes'))
for( i in 1:LEN){
  print(i)
  link <- year_links[[i]]
  print(paste("SCRAPING: ", link))
  i_page <- read_html(link)
  MASTER_PAGES[[i]] <- i_page
  print(i_page)
  Sys.sleep(60)
}
MASTER_PAGES # return
#####################
MASTER_data <- vector("list", length=LEN)
for(i in 1:LEN){
  article_i <- vector('list', length = 6)
  page <- MASTER_PAGES[[i]]
  article_i[1] <- getDOI(page)
  article_i[2] <- getTitle(page)
  article_i[3] <- getAuthors(page)
  article_i[4] <- getPubDate(page)
  article_i[5] <- getKeywords(page)
  article_i[6] <- getFullText(page)
  MASTER_data[[i]] <- article_i
  rm(article_i)
}
MASTER_data


