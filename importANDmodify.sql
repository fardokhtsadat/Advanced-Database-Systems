----How to create a DB------
# To create a db:
CREATE DATABASE MovieLens;

-----create tables for the small dataset-----
#### table: movies ####
# the original table "movies" is splited into two tables of "movieId_title" and "movieId_genres"
CREATE TABLE movieId_title(
    movieId NUMBER(5) CONSTRAINT movieId_pk PRIMARY KEY,
    title VARCHAR(200) CONSTRAINT title_nn NOT NULL
)

CREATE TABLE movieId_genres(
    movieId NUMBER(5) CONSTRAINT movieId_fk REFERENCES movieId_title(movieId),
    genres VARCHAR(30) CONSTRAINT genres_nn NOT NULL
)

#### table: links ####
CREATE TABLE links(
    movieId NUMBER(5) CONSTRAINT links_movieId_fk REFERENCES movieId_title(movieId),
    imdbId NUMBER(20) CONSTRAINT imdbId_uk UNIQUE,
    imdbId NUMBER(20) CONSTRAINT imdbId_uk UNIQUE
)

#### table: users ####
CREATE TABLE users(
    userId VARCHAR(4) CONSTRAINT userId_pk PRIMARY KEY
)

#### table: tags ####
CREATE TABLE tags(
    userId VARCHAR(4) CONSTRAINT tags_userId_fk REFERENCES users(userId),
    movieId NUMBER(5) CONSTRAINT tags_movieId_fk REFERENCES movieId_title(movieId),
    tag varchar(60) CONSTRAINT tag_nn NOT NULL,
    timestamp NUMBER(11) CONSTRAINT timestamp_nn NOT NULL

)

#### table: ratings ####
CREATE TABLE ratings(
    userId VARCHAR(4) CONSTRAINT ratings_userId_fk REFERENCES users(userId),
    movieId NUMBER(5) CONSTRAINT ratingd_movieId_fk REFERENCES movieId_title(movieId),
    rating NUMBER(1) CONSTRAINT rating_nn NOT NULL,
    timestamp NUMBER(11) CONSTRAINT timestamp_nn NOT NULL
)

-------------------------------------------
-----reate tables for the big dataset------
-------------------------------------------

#### table: movies ####
# the original table "movies" is splited into two tables of "movieId_title" and "movieId_genres"
CREATE TABLE movieId_title(
    movieId int(10),
    title varchar(300) NOT NULL
    );

ALTER TABLE movieId_title ADD CONSTRAINT movieId_pk PRIMARY KEY (movieId);

##ALTER TABLE movieId_genres MODIFY genres varchar(30) NOT NULL;

CREATE TABLE movieId_genres(
    movieId INT(10),
    genres VARCHAR(30) NOT NULL,
    FOREIGN KEY (movieId) REFERENCES movieId_title (movieId)
)

##ALTER TABLE movieId_genres ADD FOREIGN KEY (movieId) REFERENCES movieId_title (movieId);
##ALTER TABLE movieId_genres MODIFY movieId INT(10) NOT NULL;


#### table: links ####
CREATE TABLE links(
    movieId NUMBER(5) CONSTRAINT links_movieId_fk REFERENCES movieId_title(movieId),
    imdbId NUMBER(20) CONSTRAINT imdbId_uk UNIQUE,
    tmdbId NUMBER(20) CONSTRAINT imdbId_uk UNIQUE
)

CREATE TABLE links(
    movieId INT NOT NULL,
    imdbId INT,
    tmdbId INT
);
ALTER TABLE links ADD FOREIGN KEY (movieId) REFERENCES movieId_title (movieId);

UPDATE links 
SET tmdbId = NULL 
WHERE tmdbId  = 0;


#### table: users ####
CREATE TABLE users(
    userId INT(10)
);
ALTER TABLE users ADD CONSTRAINT userId_pk PRIMARY KEY (userId);

#### table: tags ####
CREATE TABLE tags(
    userId INT(10), 
    movieId INT,
    tag varchar(60) NOT NULL,
    timestamp INT(11) NOT NULL
);
ALTER TABLE tags ADD FOREIGN KEY (movieId) REFERENCES movieId_title (movieId);
ALTER TABLE tags ADD FOREIGN KEY (userId) REFERENCES users (userId);
ALTER TABLE tags MODIFY movieId INT NOT NULL;
ALTER TABLE tags MODIFY userId INT NOT NULL;

CONSTRAINT tags_userId_fk REFERENCES users(userId),
CONSTRAINT tag_nn NOT NULL,
    

#### table: ratings ####
CREATE TABLE ratings(
    userId INT,
    movieId INT, 
    rating DECIMAL(2,1) NOT NULL,
    timestamp INT NOT NULL
);
ALTER TABLE ratings ADD FOREIGN KEY (movieId) REFERENCES movieId_title (movieId);
ALTER TABLE ratings ADD FOREIGN KEY (userId) REFERENCES users (userId);
ALTER TABLE ratings MODIFY userId INT NOT NULL;
ALTER TABLE ratings MODIFY movieId INT NOT NULL;


#### table: genome_tags ####
CREATE TABLE genome_tags(
    tagId INT NOT NULL,
    tag varchar(100) NOT NULL
);
ALTER TABLE genome_tags ADD CONSTRAINT genome_tags_tagId_pk PRIMARY KEY (tagId);

CREATE TABLE genome_scores(
    movieId INT NOT NULL,
    tagId INT NOT NULL, 
    relevance DECIMAL(6,5) NOT NULL
);
ALTER TABLE genome_scores ADD FOREIGN KEY (movieId) REFERENCES movieId_title (movieId);
ALTER TABLE genome_scores ADD FOREIGN KEY (tagId) REFERENCES genome_tags (tagId);




------loading data frov csv to DB------
LOAD DATA INFILE '/Users/fardokht/Desktop/JCU/second-semester/database_systems/final_project/movieId_title.csv' 
INTO TABLE movieId_title 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(movieId, title);

LOAD DATA LOCAL INFILE '/Users/fardokht/Desktop/ml-latest-small/links.csv' INTO TABLE links
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(movieId, imdbId, tmdbId);


LOAD DATA LOCAL INFILE '/Users/fardokht/Desktop/JCU/second-semester/database_systems/final_project/ml-latest/tags.csv' INTO TABLE tags
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(userId, movieId, tag, timestamp);


LOAD DATA LOCAL INFILE '/Users/fardokht/Desktop/JCU/second-semester/database_systems/final_project/ml-latest/ratings.csv' INTO TABLE ratings
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(userId, movieId, rating, timestamp);


LOAD DATA LOCAL INFILE '/Users/fardokht/Desktop/JCU/second-semester/database_systems/final_project/ml-latest/genome-tags.csv' INTO TABLE genome_tags
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(tagId, tag);

LOAD DATA LOCAL INFILE '/Users/fardokht/Desktop/JCU/second-semester/database_systems/final_project/ml-latest/genome-scores.csv' INTO TABLE genome_scores
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(movieId, tagId, relevance);

LOAD DATA LOCAL INFILE '/Users/fardokht/Desktop/JCU/second-semester/database_systems/final_project/ml-latest/links.csv' INTO TABLE links
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(movieId, imdbId, tmdbId);

LOAD DATA LOCAL INFILE '/Users/fardokht/Desktop/JCU/second-semester/database_systems/final_project/userId.csv' INTO TABLE users
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(userId);


ALTER TABLE ratings ADD FOREIGN KEY (movieId) REFERENCES movieId_title (movieId);
ALTER TABLE ratings MODIFY movieId INT NOT NULL;



