library(rvest)
library(stringr)
# Request URL
# Function may not be needed
getURL <- function(url_str){
  return(read_html(url_str))
}
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
getFullArticle <- function(html_page){
  
}
getKeywords <- function(html_page){
  return(html_node(page,"div.kwd-group") %>% html_text())
}
# DOI
getDOI <- function(html_page){
  raw_text <- html_node(page,"div.ww-citation-primary") %>% html_text()
  vals <- regexpr("https://doi.org/(.*)", raw_text)
  doi_len <- attr(vals, "match.length")
  return(substr(raw_text,vals[1], vals[1] + doi_len -1))
}

