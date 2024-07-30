/* 
8Th lesson NSS Tutorial
*/

/*  1.
The example shows the number who responded for:

question 1
at 'Edinburgh Napier University'
studying '(8) Computer Science'
Show the the percentage who STRONGLY AGREE */

SELECT  A_Strongly_Agree/100*100 FROM nss
WHERE question='Q01'
AND institution='Edinburgh Napier University'
AND subject='(8) Computer Science' 
   
/*  2. Show the institution and subject where the score is at least 100 for question 15.
*/
SELECT institution , subject FROM nss
WHERE question='Q15'
AND score >= 100

/*  3. Show the institution and score where the score for '(8) Computer Science' is less than 50 for question 'Q15'.
*/
SELECT institution, score FROM nss
WHERE question='Q15'
AND subject = '(8) Computer Science' 
AND score < 50

/*  4. Show the subject and total number of students who responded to question 22 for each of the subjects '(8) Computer Science' and '(H) Creative Arts and Design'.
*/
SELECT subject ,SUM(response) FROM nss
WHERE question= 'Q22'
AND subject    IN('(H) Creative Arts and Design' ,'(8) Computer Science') 
GROUP BY subject;

/*  5. Show the subject and total score where the score is 1000 for any institution
*/
SELECT subject, SUM( A_STRONGLY_AGREE *response /100) FROM nss
WHERE question='Q22'
AND subject IN('(8) Computer Science','(H) Creative Arts and Design') 
GROUP BY subject ; 

/*  6. Show the institution, score, number of students and the total number of students who responded to question 22 for 'Robert Gordon University'. Order by score.
*/
SELECT subject, ROUND(AVG(a_strongly_agree)) FROM nss
WHERE question = 'Q22'
AND subject = '(8) Computer Science' XOR subject = '(H) Creative Arts and Design' 
GROUP BY subject
