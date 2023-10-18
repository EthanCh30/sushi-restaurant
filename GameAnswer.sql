1.List all the details of the publisher table ordered by revenue in descending order.

pubID       name                    revenue     countryID
----------  ----------------------  ----------  ----------
2           Microsoft Game Studios  817         10
7           Bethesda Softworks      784         5
1           Nintendo                726         4
9           Sega                    521         3
3           Take-Two Interactive    449         5
6           Ubisoft                 415         6

SELECT *
FROM publisher
ORDER BY revenue DESC;

2.List only the name and population columns of all the countries in name order.

name        population
----------  ----------
Bangladesh  164972348
Brazil      212821986
China       1440297825
DR Congo    90003954
Egypt       102659126

SELECT name, population
FROM country
ORDER BY name;

3.List the firstName, lastName for all gamers that have a gender of ‘M’ and order by firstName.

SELECT firstName, lastName
FROM Gamer
WHERE gender = 'M'
ORDER BY firstName;

4.For each birthYear in Gamer, list the birthYear and the number of Gamers with that birthYear, but list only those birthYears that have a total count greater than 35. Order by birthYear and rename the number of gamers column to ‘Number of Gamers’.

birthYear   Number of Gamers
----------  ----------------
1997        36
1998        37
2000        40
2001        39
2004        41
2007        44
2008        40

SELECT birthYear, COUNT(gamerID) AS "Number of Gamers"
FROM Gamer
GROUP BY birthYear
HAVING COUNT(gamerID) > 35
ORDER BY birthYear;

5.For each gender of Gamer, list the gender and the count for that gender, but only include gamers that have a lastName number beginning with ‘G’. Order by gender and rename the count to ‘Count of G’.

gender      Count of G
----------  ----------
F           7
M           6

SELECT gender, COUNT(gamerID) AS "Count of G"
FROM Gamer
WHERE lastName LIKE 'G%'
GROUP BY gender
ORDER BY gender;

6.Using only a WHERE to perform the join (instead of a JOIN...ON or a NATURAL JOIN), list the title, label, and minAge of the games for all games that have a title beginning with ‘Grand’. Order by title.

title                 label       minAge
--------------------  ----------  ----------
Grand Theft Auto III  MA15+       15
Grand Theft Auto IV   R18+        18
Grand Theft Auto V    G           0
Grand Theft Auto: Li  MA15+       15
Grand Theft Auto: Sa  R18+        18
Grand Theft Auto: Vi  M           12SELECT g.title, ar.label, ar.minAge

FROM Game g, AgeRating ar
WHERE g.arID = ar.arID
AND g.title LIKE 'Grand%'
ORDER BY g.title;

7.List the total number of games that have a genre with the label of ‘Shooter’. Use subqueries and IN clauses. Rename the total number column to ‘Total Number of Shooter Games’.

Total Number of Shooter Games
-----------------------------
17

SELECT COUNT(gameID) AS "Total Number of Shooter Games"
FROM Game
WHERE genreID IN (SELECT genreID FROM Genre WHERE label = 'Shooter');

8.List the game title, console name, and the number of purchases made for all purchases with more than 45 purchases. Order the result set by the number of purchases and then by title. Use a JOIN…ON clause to perform the join. Rename the number of purchases column to ‘Number of Purchases’.

title              consoleName  Number of Purchases
-----------------  -----------  -------------------
Final Fantasy VII  PS           46
FIFA Soccer 13     PS3          47
Gran Turismo 2     PS           51
Grand Theft Auto:  PSP          60

SELECT g.title, c.consoleName, COUNT(p.purchaseID) AS "Number of Purchases"
FROM Game g
JOIN Purchase p ON g.gameID = p.gameID
JOIN Console c ON p.consoleID = c.consoleID
GROUP BY g.title, c.consoleName
HAVING COUNT(p.purchaseID) > 45
ORDER BY COUNT(p.purchaseID), g.title;

9.Using a set operator, list country names that have a gamer that does not have a publisher for the country. Order by country name.

name
----------
Bangladesh
DR Congo
Egypt
Ethiopia
Germany
India

SELECT name
FROM Country
WHERE countryID IN (SELECT countryID FROM Gamer)
AND countryID NOT IN (SELECT countryID FROM Publisher)
ORDER BY name;

10.List the teamID, team name, and the first name, last name and the name of the country for the gamer(s) with the most team points for each team. Use a correlated sub-query on the teamID column. There might be more than one maximum!!!

teamID      teamName        firstName   lastName    name
----------  --------------  ----------  ----------  ----------
1           AngryCreepy591  Colton      Barbieri    Ethiopia
1           AngryCreepy591  Wilber      Mogan       Japan
2           PsychoYellow15  Synthia     Brewton     Iran
3           CreepyNugget01  Lyn         Mccluney    Vietnam
4           CreepyOtter314  Augusta     Roldan      Thailand

SELECT 
    t.teamID,
    t.teamName,
    g.firstName,
    g.lastName,
    c.name
FROM Team t
JOIN Gamer g ON t.teamID = g.teamID
JOIN Country c ON g.countryID = c.countryID
WHERE g.teamPoints IN (
    SELECT MAX(teamPoints) 
    FROM Gamer 
    WHERE teamID = g.teamID
)
ORDER BY t.teamID, g.firstName, g.lastName;
