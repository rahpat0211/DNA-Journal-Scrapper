library(rvest)
library(stringr)
# Variables
main_path<- "https://academic.oup.com/"
page <- read_html(article_url)
typeof(page) # list

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
# DOI
getDOI <- function(html_page){
  raw_text <- html_node(page,"div.ww-citation-primary") %>% html_text()
  vals <- regexpr("https://doi.org/(.*)", raw_text)
  doi_len <- attr(vals, "match.length")
  return(substr(raw_text,vals[1], vals[1] + doi_len -1))
}

# Keywords
getKeywords <- function(html_page) {
  keywords <- html_node(page,"div.kwd-group") %>% html_text()
  return(keywords)
}

# Abstract
  getAbstract <- function(html_page){
    abstract <- html_text(html_node(html_page, 'p.chapter-para'))
    return(abstract)
  }

getKeywords(page)
