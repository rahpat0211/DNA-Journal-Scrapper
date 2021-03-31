library(rvest)
library(stringr)
setwd('C:\\Users\\apont\\Documents\\NJIT\\DNA-Journal-Scrapper-main\\Crawled Webpages')
getYear <- function(year){
  path <- paste(year, ".csv", sep='')
  if(path %in% list.files()){
    return(read.csv(path))
  }
  else{
    # Uncomment if you want to web scrape
    # Be careful the server will kick you off you run it too many times(More than twice in one hour)
    #getYearLinks(year)
    #return(read.csv(path))
    print('Needs to be web scraped uncomment getYearLinks(year return (read.csv(path)')
  }
}
getYearLinks <- function(year) {
  f_name <- paste(year, ".csv", sep="")
  
  years <- c(1994:2021)
  pages <- c(1:28)
  if(year %in% years) {
    new_index <- match(year,years)
    pageNumber <- pages[new_index]
    link <- paste("https://academic.oup.com/dnaresearch/issue/", pageNumber, "/1", sep = "")
    driver <- read_html(link)
    
    allIssue <- html_nodes(driver,'select.issue-browse-issues-list.issue-browse-select.at-issue-browse-select-issue') %>% html_text()
    allIssue <- str_count(allIssue, "Issue")
    
    ogDf <- data.frame(DOI="",Title="",Authors="",Author_Affiliations="NO",Correspondence_Author="NO",Correspondence_Author_Email="NO", Publication_Date="",Keywords="",Abstract="", Full_Text="")
    
    for (i in 1:allIssue){
      link <- paste("https://academic.oup.com/dnaresearch/issue/", pageNumber, "/", i, sep = "")
      driver <- read_html(link)
      subURLs <- html_nodes(driver,'h5.customLink.item-title') %>% 
        html_children() %>% 
        html_attr('href')
      subURLs <- subURLs[!is.na(subURLs)]
      mainURL <- "https://academic.oup.com/"
      
      yearALL <- subURLs
      Sys.sleep(60)
      
      getTitle <- function(html_page){
        raw_title <- html_node(html_page, "h1.wi-article-title.article-title-main") %>% html_text()
        return(str_trim(gsub("[\r\n]", " ",raw_title)))
      }
      # Authors
      getAuthors<- function(html_page){
        return(html_nodes(html_page, "a.linked-name") %>% html_text())
      }
      # Publication Date
      getPubDate <- function(html_page){
        return(html_node(html_page, "div.citation-date") %>%
                 html_text())
      }
      
      # DOI
      getDOI <- function(html_page){
        raw_text <- html_node(html_page,"div.ww-citation-primary") %>% html_text()
        vals <- regexpr("https://doi.org/(.*)", raw_text)
        doi_len <- attr(vals, "match.length")
        return(gsub("https://doi.org/","",substr(raw_text,vals[1], vals[1] + doi_len -1)))
      }
      
      # Keywords
      
      getKeywords <- function(html_page) {
        keywords <- html_node(html_page,"div.kwd-group") %>% html_text()
        return(keywords)
      }
      
      #Abstract
      getAbstract <- function(html_page){
        abstract <- html_text(html_node(html_page, 'p.chapter-para'))
        return(abstract)
      }
      
      getFullText <- function(html_page) {
        text <- html_text(html_nodes(html_page, 'h2.section-title,h3.section-title,p.chapter-para, div.block-child-p.js-p-fig-section'))
        return(text)
      }
      
      for(i in 1:length(yearALL)) {
        new <- paste("https://academic.oup.com", yearALL[i], sep = "")
        page <- read_html(new)
        
        ogDf[nrow(ogDf)+ 1,1] <- c(getDOI(page))
        ogDf[nrow(ogDf),2] <- c(getTitle(page))
        aut <- getAuthors(page)
        aut <- paste(aut, collapse = ",")
        ogDf[nrow(ogDf),3] <- c(aut)
        ogDf[nrow(ogDf),7] <- c(getPubDate(page))
        ogDf[nrow(ogDf),8] <- c(getKeywords(page))
        ogDf[nrow(ogDf),9] <- c(getAbstract(page))
        full <- getFullText(page)
        full <- paste(full, collapse = "")
        ogDf[nrow(ogDf),10] <- c(full)
        
      }
      
      
    }
    ogDf[is.na(ogDf)] <- "NO"
    ogDf = ogDf[-1,]
    row.names(ogDf) <- NULL
    write.csv(ogDf, file = "1994.csv")
    
  }
  else {
    return("Year out of bound")
  }
}

################################################################
# MAIN FUNCTION
getYear(2012)
