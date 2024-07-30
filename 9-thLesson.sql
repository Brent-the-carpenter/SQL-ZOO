/*
Lesson 9 : Window functions
*/

/*1 Show the lastName, party and votes for the constituency 'S14000024' in 2017.
*/
SELECT lastName, party, votes FROM ge
WHERE constituency = 'S14000024' 
AND yr = 2017
ORDER BY votes DESC

/*2 Show the lastName, party, votes and the total number of votes for the constituency 'S14000024' in 2017.
*/
SELECT party, votes,RANK() OVER (ORDER BY votes DESC) as posn FROM ge
WHERE constituency = 'S14000024' AND yr = 2017
ORDER BY party

/*3 Use PARTITION to show the ranking of each party in S14000021 in each year. Include yr, party, votes and ranking (the party with the most votes is 1).
*/

SELECT yr,party, votes, RANK() OVER (PARTITION BY yr ORDER BY votes DESC) as posn FROM ge
WHERE constituency = 'S14000021'
ORDER BY party,yr


/*4 Use PARTITION to show the ranking of each party in each constituency in 2017. Include constituency, party, votes and ranking (the party with the most votes is 1).
*/
SELECT constituency,party, votes , RANK() over(PARTITION BY constituency ORDER BY votes DESC) AS posn
  FROM ge
 WHERE constituency BETWEEN 'S14000021' AND 'S14000026'
   AND yr  = 2017
ORDER BY posn ,  constituency 

/*5 You can use SELECT within SELECT to pick out only the winners in Edinburgh.

Show the parties that won for each Edinburgh constituency in 2017.
*/

SELECT constituency,party, votes , FROM ge AS x
 WHERE constituency BETWEEN 'S14000021' AND 'S14000026'
 AND yr  = 2017
 AND votes = (SELECT MAX(votes) -- subquery is filtered by the outer query so we just need to find max votes
              FROM ge y
              WHERE x.constituency = y.constituency
              AND x.yr = y.yr
             )                
ORDER BY constituency,votes DESC

/*6 You can use COUNT and GROUP BY to see how each party did in Scotland. Scottish constituencies start with 'S'

Show how many seats for each party in Scotland in 2017.
*/
SELECT party, COUNT(*) AS seats FROM ge AS x
WHERE yr = 2017
AND constituency LIKE 'S%'
AND votes = (SELECT MAX(votes)
             FROM ge y
             WHERE y.constituency = x.constituency
             AND y.yr = x.yr
            )
GROUP BY party
;
