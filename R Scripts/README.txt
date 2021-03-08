There are three scripts: Rcrawler.r
			get_features.r
			get_year_links.r


Rcrawler.r -->	This program takes the year input from the user. It validates if the user input
is amongst the years within the publications, if it is not, an error will be throwed "Year out of bound".

The function is associated with multiple other functions gathered from get_features.r. 
It checks to see whether or not each field is empty or not. If the field is not empty, it will extract 
the useful information based on each field. If it is empty, it will return as NA which will be swapped 
with "NO". Lastly, the gathered information is appended to the dataframe for clarity of the year inputed.


get_features.r --> This program has mutliple functions associated with the fields mentioned. 
It will extract the information based on the indicated link of the publication/article. 

get_year_links.r --> This program is used to take the input from the user and extract the urls mentioned 
about the article of the corresponding year. It will return n number of urls based on the count of the 
avaiable links.