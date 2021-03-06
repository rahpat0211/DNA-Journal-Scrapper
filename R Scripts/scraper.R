library(rvest)
library(stringr)
# Title
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
getAbstract <- function(html_page){
  return(html_page %>% html_nodes(".abstract")%>% html_text())
}
getFullText <- function(html_page) {
  text <- html_text(html_nodes(html_page, 'h2.section-title,h3.section-title,p.chapter-para, div.block-child-p.js-p-fig-section'))
  return(text)
}
getKeywords <- function(html_page){
  return(html_node(page,"div.kwd-group") %>% html_text())
}
getDOI <- function(html_page){
  raw_text <- html_node(page,"div.ww-citation-primary") %>% html_text()
  vals <- regexpr("https://doi.org/(.*)", raw_text)
  doi_len <- attr(vals, "match.length")
  return(substr(raw_text,vals[1], vals[1] + doi_len -1))
}
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