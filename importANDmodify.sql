----How to create a DB------
# To create a db:
CREATE DATABASE moviesDB;

-------------------------------------------
-----create and load tables for the big dataset------
-------------------------------------------


It contains 27753444 ratings and 1108997 tag applications across 58098 movies. These data were created by 283228 users between January 09, 1995 and September 26, 2018.

######################
#### table: users ####
######################
CREATE TABLE users(
    userId INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (userId)
);

LOAD DATA LOCAL INFILE '/Users/fardokht/Desktop/JCU/second-semester/database_systems/final_project/userId.csv' INTO TABLE users
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(userId);

mysql> Query OK, 283228 rows affected (1.19 sec)
mysql> Records: 283228  Deleted: 0  Skipped: 0  Warnings: 0

######################
#### table: movies ####
######################
# the original table "movies" is splited into two tables of "titles" and "genres"
CREATE TABLE titles(
    movieId INT NOT NULL AUTO_INCREMENT,
    title varchar(300) NOT NULL,
    PRIMARY KEY (movieId)
    );

CREATE TABLE genres(
    id INT NOT NULL AUTO_INCREMENT,
    movieId INT NOT NULL,
    genres VARCHAR(30) NOT NULL,
    PRIMARY KEY (id)
);
ALTER TABLE genres ADD FOREIGN KEY (movieId) REFERENCES titles (movieId);

LOAD DATA INFILE '/Users/fardokht/Desktop/JCU/second-semester/database_systems/movieId_title.csv' 
INTO TABLE titles 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(movieId, title);

mysql> 58098 records imported

LOAD DATA LOCAL INFILE '/Users/fardokht/Desktop/ml-latest-small/movieId_genres.csv' INTO TABLE genres
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(movieId, genres);

mysql> 106107 records imported

######################
#### table: links ####
######################

CREATE TABLE links(
    id INT NOT NULL AUTO_INCREMENT,
    movieId INT NOT NULL,
    imdbId INT,
    tmdbId INT,
    PRIMARY KEY (id)
);
ALTER TABLE links ADD FOREIGN KEY (movieId) REFERENCES titles (movieId);

set foreign_key_checks = 0;

UPDATE links 
SET tmdbId = NULL 
WHERE tmdbId  = 0;

set foreign_key_checks = 1;

LOAD DATA LOCAL INFILE '/Users/fardokht/Desktop/JCU/second-semester/database_systems/final_project/ml-latest/links.csv' INTO TABLE links
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(movieId, imdbId, tmdbId);

mysql> Query OK, 58098 rows affected, 181 warnings (0.46 sec)
mysql> Query OK, 58098 rows affected, 181 warnings (0.46 sec)

#######################
#### table: ratings ###
#######################

CREATE TABLE ratings(
    id INT NOT NULL AUTO_INCREMENT,
    userId INT NOT NULL,
    movieId INT NOT NULL, 
    rating DECIMAL(2,1) NOT NULL,
    timestamp INT NOT NULL,
    PRIMARY KEY (id)
);
ALTER TABLE ratings ADD FOREIGN KEY (movieId) REFERENCES titles (movieId);
ALTER TABLE ratings ADD FOREIGN KEY (userId) REFERENCES users (userId);
ALTER TABLE ratings ADD CONSTRAINT user_movie_uc UNIQUE (userId,movieId);

LOAD DATA LOCAL INFILE '/Users/fardokht/Desktop/JCU/second-semester/database_systems/final_project/ml-latest/ratings.csv' INTO TABLE ratings
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(userId, movieId, rating, timestamp);

mysql> Query OK, 27753444 rows affected (8 min 10.36 sec)
mysql> Records: 27753444  Deleted: 0  Skipped: 0  Warnings: 0

####################
#### table: tags ###
####################
CREATE TABLE tags(
    id INT NOT NULL AUTO_INCREMENT,
    userId INT NOT NULL, 
    movieId INT NOT NULL,
    tag varchar(60) NOT NULL,
    timestamp INT NOT NULL,
    PRIMARY KEY (id)
);
ALTER TABLE tags ADD FOREIGN KEY (movieId) REFERENCES titles (movieId);
ALTER TABLE tags ADD FOREIGN KEY (userId) REFERENCES users (userId);

LOAD DATA LOCAL INFILE '/Users/fardokht/Desktop/JCU/second-semester/database_systems/final_project/ml-latest/tags.csv' INTO TABLE tags
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(userId, movieId, tag, timestamp);

mysql> Query OK, 1108997 rows affected, 570 warnings (15.96 sec)
mysql> Records: 1108997  Deleted: 0  Skipped: 0  Warnings: 570

###########################
#### table: genome_tags ###
###########################

CREATE TABLE genome_tags(
    tagId INT NOT NULL AUTO_INCREMENT,
    tag varchar(100) NOT NULL,
    PRIMARY KEY (tagId)
);

LOAD DATA LOCAL INFILE '/Users/fardokht/Desktop/JCU/second-semester/database_systems/final_project/ml-latest/genome-tags.csv' INTO TABLE genome_tags
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(tagId, tag);

mysql> Query OK, 1128 rows affected (0.01 sec)
mysql> Records: 1128  Deleted: 0  Skipped: 0  Warnings: 0

###########################
#### table: genome_scores ###
###########################
CREATE TABLE genome_scores(
    id INT NOT NULL AUTO_INCREMENT,
    movieId INT NOT NULL,
    tagId INT NOT NULL, 
    relevance DECIMAL(6,5) NOT NULL,
    PRIMARY KEY (id)
);
ALTER TABLE genome_scores ADD FOREIGN KEY (movieId) REFERENCES titles (movieId);
ALTER TABLE genome_scores ADD FOREIGN KEY (tagId) REFERENCES genome_tags (tagId);


LOAD DATA LOCAL INFILE '/Users/fardokht/Desktop/JCU/second-semester/database_systems/final_project/ml-latest/genome-scores.csv' INTO TABLE genome_scores
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(movieId, tagId, relevance);

mysql> Query OK, 14862528 rows affected, 65535 warnings (3 min 23.70 sec)
mysql> Records: 14862528  Deleted: 0  Skipped: 0  Warnings: 11399920

warnings:
 Note  | 1265 | Data truncated for column 'relevance' at row 1426


