SELECT *  FROM movies;

-- Pagination
-- LIMIT AND OFFSET
SELECT * FROM movies
LIMIT 20
OFFSET 60;



-- IN

-- Longer way
SELECT * FROM movies
WHERE director = 'Christopher Nolan' OR Director = 'Steven Spielberg' OR director = 'Peter Jackson';

-- Better Way
SELECT * FROM movies
WHERE director IN('Christopher Nolan','Steven Spielberg','Peter Jackson');


-- BETWEEN
SELECT * FROM movies
WHERE rating >=8.5 AND rating <=9.0;


SELECT * FROM movies
WHERE rating BETWEEN 8.5 AND 9.0;



-- ROUND
SELECT movie_id, title, ROUND(rating,2) FROM movies;

SELECT ROUND(9.4347,2);
SELECT CEIL(9.4347);
SELECT FLOOR(9.4347);



-- COALESCE
UPDATE movies
SET rating = null
WHERE movie_id <5;


SELECT COALESCE(director,'No Director Listed') AS director, title, movie_id, duration, COALESCE(rating,0) AS rating FROM movies;


-- Aggregation functions
SELECT SUM(rating) FROM movies;

SELECT avg(rating) FROM movies;

SELECT COUNT(*) FROM movies
WHERE rating >=9.0;


-- Case Insensistive query

-- Case Sensistive
SELECT * FROM movies
WHERE title = 'Pulp fiction';

-- Case Insesetive
SELECT * FROM movies
WHERE title ILIKE 'fiction';

-- Searching any matching substring
SELECT * FROM movies
WHERE title ~* 'on';


SELECT '1975-03-19' AS date;

SELECT CURRENT_DATE;
SELECT CURRENT_TIME;
SELECT CURRENT_TIMESTAMP;


-- Formatting dates
SELECT TO_CHAR(CURRENT_DATE,'YYYY-MM-DD');
SELECT TO_CHAR(CURRENT_DATE,'DD-YYYY-MM');
SELECT TO_CHAR(CURRENT_DATE,'YYYY:::::DD::::----MM');
SELECT TO_CHAR(CURRENT_TIMESTAMP,'HH24:MI:SS'); -- 24 hour 



-- Extracting from dates
SELECT EXTRACT(YEAR FROM CURRENT_DATE);
SELECT EXTRACT(MONTH FROM CURRENT_DATE);
SELECT EXTRACT(DAY FROM CURRENT_DATE);
SELECT EXTRACT(DOW FROM CURRENT_DATE);

-- DOW (Day Of the Week): Sunday = 0, Monday = 1, Teusday = 2, Wednesday = 3, Thursday =4

-- See Built In TimeZones
SELECT * FROM pg_timezone_names;


-- Adding and Subtracting from Date and Time
SELECT CURRENT_DATE - INTERVAL '1 day';
SELECT CURRENT_DATE - INTERVAL '7 day';
SELECT CURRENT_DATE + INTERVAL '1 month 2 days';
SELECT CURRENT_TIME + INTERVAL '3 hours';



-- Finding difference between dates
SELECT AGE(CURRENT_DATE, '2000-01-11');
SELECT '2025-03-20'::DATE - '2020-03-20'::DATE;



-- Comparing dates in Postgres
SELECT CURRENT_DATE < '1999-05-12'::DATE;

ALTER TABLE movies ADD COLUMN release_date DATE;
SELECT * FROM movies;

UPDATE movies
SET release_date = '2020-01-01'
WHERE movie_id BETWEEN 5 AND 10;


-- get me all the movies that came out after 2019
SELECT * FROM movies
WHERE release_date > '2019-01-01';


-- Common Built in Functions
SELECT UPPER('kathrin');
SELECT LOWER('kathrin');
SELECT TRIM('   kathrin   ');
SELECT REPLACE('kathrin', 'in', 'zzzzzzzz');



SELECT UPPER(title) AS title FROM movies;




-- Casting in Postgres
SELECT '1999-11-22'::TIMESTAMP;
SELECT '10000'::INT;





-- ON CONFLICT
-- DO NOTHING: if there is a conflict it wont do anything and just continue with the script
SELECT * FROM movies;
INSERT INTO movies(movie_id, title) VALUES (1,'Omars Movie')
ON CONFLICT DO NOTHING;


-- DO UPDATE
-- Example of UPSERT
INSERT INTO movies(movie_id,title,rating) VALUES(1, 'Shawshank',9.9)
ON CONFLICT(movie_id) DO UPDATE
SET rating = EXCLUDED.rating;




-- NULLS FIRST, NULLS LAST
SELECT * FROM movies
ORDER BY director DESC NULLS LAST;










