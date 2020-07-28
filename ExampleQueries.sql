

# Make a query to find movies titles of movies under genres comedy with rating higher than 4:

SELECT DISTINCT titles.title
FROM moviesDB.titles 
INNER JOIN genres ON titles.movieId = genres.movieId 
INNER JOIN ratings ON ratings.movieId = genres.movieId
WHERE genres.genres = 'Comedy' AND ratings.rating > 4;

# Under which genres is the movie Toy Story 1995 categorized?

SELECT DISTINCT genres.genres 
FROM moviesDB.titles
INNER JOIN moviesDB.genres ON titles.movieId = genres.movieId
WHERE titles.title = 'Toy Story (1995)';

# make a query to obtain titles of movies with the tag epic.

SELECT titles.title, tags.tag
FROM moviesDB.titles 
INNER JOIN tags ON titles.movieId = tags.movieId
WHERE tags.tag = 'epic';

# Make a query to find movieIds which do not have a tmdbId link:

SELECT movieId, tmdbId
FROM moviesDB.links
WHERE tmdbId IS NULL;

# Make a query to retrieve the movie-titles which were tagged between '2015-01-01' and '2015-01-31' and order the result by the date ascending:

SELECT userId, movieId, tag, TIME(from_unixtime(tags.timestamp)) AS creation_time, DATE(from_unixtime(tags.timestamp)) AS creation_date
FROM moviesDB.tags
WHERE from_unixtime(tags.timestamp) between '2015-01-01' and '2015-01-31'
ORDER BY creation_date ASC;

# Get the tmdbId and the imdbId link for the movie 'Troublemaker (1988)':

SELECT title, CONCAT('https://movielens.org/movies/', links.tmdbId) as tmdbId_link, CONCAT('https://movielens.org/movies/', links.imdbId) as imdbId_link
FROM moviesDB.links 
INNER JOIN titles ON titles.movieId = links.movieId
WHERE titles.title = 'Troublemaker (1988)';

# Make a query to retrieve the average rating for the movie ‘White Dog (1982)’:

SELECT titles.title, AVG(rating) 'Average rating'
FROM moviesDB.ratings
INNER JOIN titles ON titles.movieId = ratings.movieId
WHERE titles.title = 'White Dog (1982)';



