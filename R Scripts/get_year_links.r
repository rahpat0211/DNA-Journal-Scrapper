library(rvest)
library(stringr)

getYearLinks <- function(year) {
  years <- c(1994:2021)
  pages <- c(1:28)
  if(year %in% years) {
    new_index <- match(year,years)
    pageNumber <- pages[new_index]
    link <- paste("https://academic.oup.com/dnaresearch/issue/", pageNumber, "/1", sep = "")
    driver <- read_html(link)
    subURLs <- html_nodes(driver,'h5.customLink.item-title') %>% 
      html_children() %>% 
      html_attr('href')
    subURLs <- subURLs[!is.na(subURLs)]
    mainURL <- "https://academic.oup.com/"
    return(subURLs)
  }
  else {
    return("Year out of bound")
  }
}

getYearLinks(2021)




