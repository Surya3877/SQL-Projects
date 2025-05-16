USE movie;


/*
1. Write a SQL query to find when the movie 'American Beauty' released. Return 
movie release year. 
*/
SELECT * FROM movie;
SELECT
    mov_year
FROM
    movie
WHERE
    mov_title = 'American Beauty';
    
/*
2. Write a SQL query to find those movies, which were released before 1998. Return 
movie title.
*/ 
SELECT
    mov_title,
    mov_year
FROM
    movie
WHERE
    mov_year < 1998;
    
/*
3. Write a query where it should contain all the data of the movies which were 
released after 1995 and their movie duration was greater than 120.
*/
SELECT
    *
FROM
    movie
WHERE
    mov_year > 1995
AND
   mov_time > 120;
   
/*
4. Write a query to determine the Top 7 movies which were released in United 
Kingdom. Sort the data in ascending order of the movie year.
*/
SELECT
    mov_title,
    mov_year
FROM
    movie
WHERE
    mov_rel_country = 'UK'
ORDER BY
    mov_year ASC
LIMIT 7;

/*
5. Set the language of movie language as 'Chinese' for the movie which has its 
existing language as Japanese and the movie year was 2001.
*/
UPDATE
    movie
SET
    mov_lang = 'Chinese'
WHERE
    mov_lang = 'Japanese'
AND
    mov_year = 2001;

/*
6. Write a SQL query to find name of all the reviewers who rated the movie 
'Slumdog Millionaire'. 
*/
SELECT 
    reviewer.rev_name
FROM 
    reviewer
JOIN 
    ratings 
ON 
    reviewer.rev_id = ratings.rev_id
JOIN 
    movie 
ON 
    ratings.mov_id = movie.mov_id
WHERE 
    movie.mov_title = 'Slumdog Millionaire';

/*
7. Write a query which fetch the first name, last name & role played by the 
actor where output should all exclude Male actors. 
*/
SELECT
    actor.act_fname,
    actor.act_lname,
    cast.role
FROM
    actor
INNER JOIN
    cast
ON
    actor.act_id = cast.act_id
WHERE
    act_gender != 'm';
    
/*
8. Write a SQL query to find the actors who played a role in the movie 'Annie Hall'. 
Fetch all the fields of actor table. (Hint: Use the IN operator).
*/
SELECT * 
FROM actor
WHERE act_id IN (
    SELECT act_id 
    FROM cast
    WHERE mov_id IN (
        SELECT mov_id 
        FROM movie 
        WHERE mov_title = 'Annie Hall'
    )
);

/*
9. Write a SQL query to find those movies that have been released in countries other 
than the United Kingdom. Return movie title, movie year, movie time, and date of 
release, releasing country. 
*/
SELECT
     mov_title,
     mov_year,
     mov_time,
     mov_dt_rel
FROM
    movie
WHERE
    mov_rel_country != 'UK';
    
/*
10. Print genre title, maximum movie duration and the count the number of 
movies in each genre. (HINT: By using inner join) 
*/
SELECT
    genres.gen_title,
    max(mov_time) AS Maximum_Movie_Duration,
    count(mov_title) AS The_Number_of_movies_in_each_genres
FROM
    genres
INNER JOIN
    movie_genres
ON 
    movie_genres.gen_id = genres.gen_id
INNER JOIN
    movie
ON
    movie.mov_id = movie_genres.mov_id
GROUP BY
    genres.gen_title;
    
/*
10. Create a view which should contain the first name, last name, title of the 
movie & role played by particular actor. 
*/
CREATE VIEW ActorMovieRoles AS
SELECT
    actor.act_fname,
    actor.act_lname,
    movie.mov_title,
    cast.role
FROM
    actor
INNER JOIN
    cast ON actor.act_id = cast.act_id
INNER JOIN
    movie ON cast.mov_id = movie.mov_id;


# 12. Write a SQL query to find the movies with lowest ratings
SELECT
    movie.mov_title,
    num_o_ratings AS Lowest_Ratings
FROM
    movie
INNER JOIN
    ratings
ON
    movie.mov_id = ratings.mov_id
WHERE
    ratings.num_o_ratings = (
        SELECT
            MIN(num_o_ratings)
		FROM
            ratings
);








    




