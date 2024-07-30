/*
Lesson 9 : Self JOIN
*/

/*1. How many stops are in the database.*/
SELECT COUNT(*) FROM stops

/*2. Find the id value for the stop 'Craiglockhart'*/
SELECT id FROM stops 
WHERE name = 'Craiglockhart'

/*3. Give the id and the name for the stops on the '4' 'LRT' service.*/
SELECT id , name from stops 
INNER JOIN route on (id =route.stop)
WHERE route.num = 4 
AND route.company = 'LRT' 
ORDER BY pos

/*
4. The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53). Run the query and notice the two services that link these stops have a count of 2. Add a HAVING clause to restrict the output to these two routes.
*/
SELECT company, num, COUNT(*) FROM route 
WHERE stop=149 
OR stop=53
GROUP BY company, num 
HAVING COUNT(*) = 2;

/*5. Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, without changing routes. Change the query so that it shows the services from Craiglockhart to London Road.*/
SELECT a.company, a.num, a.stop, b.stop
FROM route AS a 
JOIN route AS b ON (a.company=b.company AND a.num=b.num)
WHERE a.stop=(SELECT id FROM stops 
              where name ='Craiglockhart'
             ) 
AND b.stop =(SELECT id FROM stops 
             WHERE name = 'London Road'
            )

/*6. The query shown is similar to the previous one, however by joining two copies of the stops table we can refer to stops by name rather than by number. Change the query so that the services between 'Craiglockhart' and 'London Road' are shown.*/
SELECT a.company, a.num, a.stop, b.stop FROM route AS a 
JOIN route AS b ON (a.company=b.company AND a.num=b.num)
JOIN stops AS c ON (a.stop=c.id) 
JOIN stops AS d ON (b.stop=d.id)
WHERE c.name='Craiglockhart' 
AND d.name='London Road'

/*7. Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')*/
SELECT a.company , b.num FROM route AS a 
JOIN route AS b ON (a.company = b.company) AND (a.num = b.num)
WHERE a.stop = 115 
AND b.stop = 137 
GROUP BY num

/*8. Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'*/

SELECT a.company , a.num FROM route AS a 
JOIN route AS b ON (a.company = b.company) AND (a.num = b.num)
JOIN stops AS c ON (a.stop = c.id)
JOIN stops AS d ON (b.stop = d.id)
WHERE c.name = 'Craiglockhart' 
AND d.name= 'Tollcross'

/*9. Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 'Craiglockhart' itself, offered by the LRT company. Include the company and bus no. of the relevant services.*/
SELECT DISTINCT d.name,a.company, a.num  FROM route AS a 
JOIN route AS b ON (a.company = b.company) AND (a.num = b.num)
JOIN stops AS c ON (a.stop = c.id)
JOIN stops AS d ON (b.stop = d.id)
WHERE c.name = 'Craiglockhart' 
AND a.company = 'LRT'

/*10. Find the routes involving two buses that can go from Craiglockhart to Lochend.*/
SELECT a.num , a.company ,stops.name ,  d.num , d.company 
FROM route AS a 
JOIN route AS b ON (a.company = b.company) AND (a.num = b.num)
JOIN stops  ON (b.stop = stops.id )
JOIN route AS c ON (c.stop = stops.id)
JOIN route AS d ON (c.company = d.company) AND (c.num = d.num)
WHERE a.stop = (SELECT id FROM stops WHERE name = 'Craiglockhart' ) 
AND d.stop = (SELECT id from stops where name = 'Lochend')
ORDER BY a.num , stops.name , d.num 
    


