#gsub is a standard replacement
​
require(rvest) #will read html code
url <- 'http://www.imdb.com/search/title?count=100&release_date=2016,2016&title_type=feature'
webpage <- read_html(url)
​
rank_data_html <- html_nodes(webpage,'.text-primary') #text is rank data 
rank_data <- html_text(rank_data_html) #process html code text, into soemthing usable in r
head(rank_data)
rank_data<-as.numeric(rank_data)
head(rank_data)
​
title_data_html <- html_nodes(webpage,'.lister-item-header a')
title_data <- html_text(title_data_html)
head(title_data)
​
description_data_html <- html_nodes(webpage,'.ratings-bar+ .text-muted')
description_data <- html_text(description_data_html)
head(description_data)#Note the first listing
description_data <- description_data[2:101]
description_data<-gsub("\n    ","",description_data)
head(description_data)
​
runtime_data_html <- html_nodes(webpage,'.runtime')
runtime_data <- html_text(runtime_data_html)
head(runtime_data)
runtime_data<-gsub(" min","",runtime_data)
runtime_data<-as.numeric(runtime_data)
head(runtime_data)
​
genre_data_html <- html_nodes(webpage,'.genre')
genre_data <- html_text(genre_data_html)
head(genre_data)
genre_data<-gsub("\n","",genre_data)
genre_data<-gsub(" ","",genre_data)
genre_data<-gsub(",.*","",genre_data) #* command only keeps primary label, removes everything after first comma
genre_data<-as.factor(genre_data) #factor variables are categorical 
head(genre_data)
View(genre_data)
​
rating_data_html <- html_nodes(webpage,'.ratings-imdb-rating strong')
rating_data <- html_text(rating_data_html)
head(rating_data)
rating_data<-as.numeric(rating_data)
head(rating_data)
​
votes_data_html <- html_nodes(webpage,'.sort-num_votes-visible span:nth-child(2)')
votes_data <- html_text(votes_data_html)
head(votes_data)
votes_data<-gsub(",","",votes_data)
votes_data<-as.numeric(votes_data)
head(votes_data)
​
#directors_data_html <- html_nodes(webpage,'.text-muted+ p a:nth-child(1)')
directors_data_html <- html_nodes(webpage,'p:nth-child(5) a:nth-child(1)')
directors_data <- html_text(directors_data_html)
head(directors_data)
directors_data<-as.factor(directors_data)
#actors_data_html <- html_nodes(webpage,'a:nth-child(6) , .lister-item-content a:nth-child(5), #main a:nth-child(4), .lister-item-content a:nth-child(3)')
#actors_data <- html_text(actors_data_html)
#head(actors_data)
#actors_data<-as.factor(actors_data)
​
​
movies_df<-data.frame(Rank = rank_data, Title = title_data,
                      Description = description_data, Runtime = runtime_data,
                      Genre = genre_data, Rating = rating_data, Votes = votes_data,
                      Director = directors_data)
​
str(movies_df)
​
View(movies_df)
require(data.table)
getwd()
fwrite(movies_df,"movies_df.csv")
