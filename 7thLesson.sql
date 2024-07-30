
/* TITLE : MORE JOIN OPERATIONS */

/* QUESTION 1
List the films where the yr is 1962 [Show id, title]
*/
SELECT id, title FROM movie
 WHERE yr=1962

/* QUESTION 2
Give year of 'Citizen Kane'.
*/
SELECT yr FROM movie
WHERE title = 'Citizen Kane'

/* QUESTION 3
List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). 
*/
SELECT id, title, yr FROM movie
WHERE title LIKE '%Star Trek%'
/* QUESTION 4
What id number does the actor 'Glenn Close' have?
*/
SELECT id FROM actor
 where name = 'Glenn Close'

/* QUESTION 5
What is the id of the film 'Casablanca'
*/

SELECT id FROM movie 
WHERE title = 'Casablanca' ; 

/* QUESTION 6
Obtain the cast list for 'Casablanca'.
what is a cast list?
The cast list is the names of the actors who were in the movie.
Use movieid=11768, (or whatever value you got from the previous question)
*/
SELECT name FROM casting 
JOIN actor ON actorid = actor.id 
WHERE casting.movieid=11768;

/* QUESTION 7
Obtain the cast list for the film 'Alien'
*/
SELECT name FROM movie 
JOIN casting ON movieid = movie.id 
JOIN actor ON actorid = actor.id
WHERE title= 'Alien'

/* QUESTION 8
List the films in which 'Harrison Ford' has appeared
*/
SELECT title FROM movie 
JOIN casting ON movieid = movie.id 
JOIN actor ON actorid = actor.id
WHERE name = 'Harrison Ford'

/* QUESTION 9
List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
*/
SELECT title FROM movie
JOIN casting ON movieid = movie.id 
JOIN actor ON actorid = actor.id
WHERE name = 'Harrison Ford' AND ord != 1

/* QUESTION 10
List the films together with the leading star for all 1962 films.
*/
SELECT title, name FROM movie
JOIN casting ON movieid = movie.id 
JOIN actor ON actorid = actor.id
WHERE yr = 1962 AND ord = 1

/* QUESTION 11
Which were the busiest years for 'John Travolta'? Show the year and the number of movies he made each year for any year in which he made more than 2 movies.
*/
SELECT yr, COUNT(title) FROM movie 
JOIN casting ON movieid = movie.id 
JOIN actor ON actorid = actor.id
WHERE name = 'John Travolta'

/* QUESTION 12 

*/ 
SELECT m.title , a.name FROM movie AS m 
JOIN casting AS c 
ON m.id = c.movieid 
JOIN actor AS a ON a.id = c.actorid
WHERE c.movieid IN( SELECT movieid FROM casting
    WHERE actorid IN (
                    SELECT id FROM actor
                        WHERE name='Julie Andrews'
                    )
                )  AND c.ord = 1

/*QUESTION 13
Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.
*/

SELECT name  FROM actor AS a JOIN casting AS c ON a.id = c.actorid JOIN movie AS m ON c.movieid = m.id

WHERE ord = 1 

GROUP BY a.id HAVING COUNT(m.title) >=15 ORDER BY name

/*QUESTION 14 
List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
*/

SELECT title , COUNT(actor.id) FROM movie AS m 
                                JOIN casting AS c   
                                ON m.id = 
                                   c.movieid
                                JOIN actor 
                                ON actor.id = c.actorid
WHERE yr = 1978 
GROUP BY m.title 
ORDER BY COUNT(actorid) DESC , title 

/*QUESTION 15
List all the people who have worked with 'Art Garfunkel'.
*/
SELECT name FROM actor AS a 
            JOIN casting AS c 
            on a.id = c.actorid 
            JOIN movie AS m 
            ON c.movieid = m.id
WHERE c.movieid IN( SELECT movieid FROM casting
    WHERE actorid IN (
                    SELECT id FROM actor
                        WHERE name = 'Art Garfunkel'
                    )
    )
    AND name != 'Art Garfunkel'


   
