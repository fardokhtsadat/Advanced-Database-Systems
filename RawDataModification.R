
####----movies.csv----####
movies <- read.csv("~/database_systems/final_project/ml-latest/movies.csv") # read the data file 'movies.csv'
colnames(movies) # get the names of the column 
 
length(movies$movieId)
length(movies$title)
length(movies$genres)

# the table movies has 3 columns of "movieId" "title" "genres".
# moviedId is uniques and starts from 1.
# genres is multivalued. This violates the 1NF. To solve this problem, we need to devide the table moives into two tables with the first table having "movieId" "title", and
# the secnd table having "movieId" and "genres".

movieId_title <- data.frame(movieId = movies$movieId, title= movies$title) # extract the columns movieId and title from movies.csv
head(movieId_title)
length(movieId_title$movieId)

movies$Year<-substr(movies$title,nchar(as.character(movies$title))-4,nchar(as.character(movies$title))-1)
movies$title<-paste0(substr(movies$title,1,nchar(as.character(movies$title))-6))
movies <- movies[,-3]
write.csv(movies, "/Users/fardokht/Desktop/movieId_title.csv", row.names = F)

length(movies$movieId)
length(movies$Year )

is.integer(movies$Year)
movies$Year <- as.integer(movies$Year)

which(is.na(test) == 0)

movies$Year[which(is.na(movies$Year) == T)] <- rep(0, length(movies$Year[which(is.na(movies$Year) == T)]))




write.csv(movieId_title, "titles.csv", row.names = F) # writing out the table 'titles.csv'

s <- strsplit(as.character(movies$genres), split = "\\|") # separating the multivalued genres
movieId_genres <- data.frame(movieId = rep(movies$movieId, sapply(s, length)), genres = unlist(s))
head(movieId_genres)
length(movieId_genres$movieId)

####----tags----####
tags <- read.csv("~/database_systems/final_project/ml-latest/tags.csv") # read the data file 'tags.csv'
head(tags)

length(tags$userId)
length(tags$movieId)
length(tags$tag)
length(tags$timestamp)

users <- tags$userId

sorted_users <- sort(users)
tail(sorted_users)
length(users)
length(unique(users))
unique_ids <- (unique(users))

users_df <- data.frame(unique_ids)
head(users_df)
tail(users_df)
write.csv(unique_ids, "unique_ids.csv",row.names = F )

sorted_time <- tags$timestamp
tail(sorted_time )


####----ratings----####
ratings <- read.csv("~/database_systems/final_project/ml-latest/ratings.csv")
head(ratings)
#27753444
length(ratings$userId)
length(ratings$movieId)
length(ratings$rating)
length(ratings$timestamp)

length(unique(ratings$userId))
unique(ratings$rating)

rating_movieId <- length(unique(ratings$movieId))
movies_movieId <- length(unique(movies$movieId))

####----links----####
links <- read.csv("~/database_systems/final_project/ml-latest/links.csv")

head(links)
length(links$movieId)
tail(links)
length(unique(links$movieId))
length(unique(links$imdbId))
length(unique(links$tmdbId))
temp <- links$tmdbId
class(temp)
typeof(temp)

links[625,]

sorted_imdb <- sort(links$imdbId)
tail(sorted_imdb)

sorted_tmdb <- sort(links$tmdbId)
tail(sorted_tmdb)

links[which(is.na(links$tmdbId) == T),]$tmdbId <- rep(0, length(links[which(is.na(links$tmdbId) == T),]$tmdbId))
write.table(links, "new_links", sep=",", na = "", row.names = F )
?write.table


t <- read.table("new_links", header = T,sep= "," )
head(t)
t[which(is.na(t$tmdbId) == T), ]

?read.table

####Genome####

genome_scores <- read.csv("/Users/fardokht/Desktop/JCU/second-semester/database_systems/final_project/ml-latest/genome-scores.csv")
head(genome_scores)

sorted_relevance <- sort(genome_scores$relevance)
tail(sorted_relevance)
max(genome_scores$relevance)
min(genome_scores$relevance)

length(genome_scores$movieId)
length(genome_scores$tagId)
length(genome_scores$relevance)

genome_tags <- read.csv("/Users/fardokht/Desktop/JCU/second-semester/database_systems/final_project/ml-latest/genome-tags.csv")
head(genome_tags)

a <- c(1:1128)
tail(a)

length(genome_tags$tagId)
length(unique(genome_tags$tagId))
length(unique(genome_tags$tag))
tail(sort(genome_tags$tagId))

length(genome_tags$tag)
which(is.na(genome_tags$tagId) == T)

all(genome_tags$tagId == a)
####users####
users_new <- read.csv("/Users/fardokht/Desktop/JCU/second-semester/database_systems/final_project/userId.csv")
length(users_new)
head(users_new)

userId <- c(1:283228)
write.table(userId, "userId.csv", sep=",", na = "", row.names = F )
