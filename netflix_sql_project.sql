-- ============================================================
-- Netflix Movies and TV Shows Data Analysis using SQL
-- ============================================================
-- Author: Aastha
-- Description: A collection of SQL business problems solved
-- using the Netflix titles dataset, covering aggregation,
-- window functions, string/array functions, and date handling.
-- ============================================================

-- Schema
CREATE TABLE netflix (
    show_id       VARCHAR(6),
    types         VARCHAR(10),
    title         VARCHAR(150),
    director      VARCHAR(210),
    casts         VARCHAR(1000),
    country       VARCHAR(130),
    date_added    VARCHAR(50),
    release_year  INT,
    rating        VARCHAR(10),
    duration      VARCHAR(10),
    listed_in     VARCHAR(80),
    description   VARCHAR(250)
);

SELECT * FROM netflix;

-- ============================================================
-- Business Problems
-- ============================================================

-- Q1: Count the number of Movies vs TV Shows
SELECT
    types,
    COUNT(*) AS total_content
FROM netflix
GROUP BY types;

-- Q2: Find the most common rating for Movies and TV Shows
SELECT
    types,
    rating
FROM (
    SELECT
        types,
        rating,
        COUNT(*) AS rating_count,
        RANK() OVER (PARTITION BY types ORDER BY COUNT(*) DESC) AS ranking
    FROM netflix
    GROUP BY types, rating
) AS t1
WHERE ranking = 1;

-- Q3: List all movies released in a specific year (e.g. 2020)
SELECT *
FROM netflix
WHERE types = 'Movie'
  AND release_year = 2020;

-- Q4: Find the top 5 countries with the most content on Netflix
SELECT
    UNNEST(STRING_TO_ARRAY(country, ',')) AS new_country,
    COUNT(show_id) AS total_content
FROM netflix
GROUP BY new_country
ORDER BY total_content DESC
LIMIT 5;

-- Q5: Find the longest movie
SELECT *
FROM netflix
WHERE types = 'Movie'
  AND duration = (SELECT MAX(duration) FROM netflix)
LIMIT 1;

-- Q6: Find content added in the last 5 years
SELECT *
FROM netflix
WHERE TO_DATE(TRIM(date_added), 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years';

-- Q7: Find all movies/TV shows directed by 'Rajiv Chilaka'
SELECT *
FROM netflix
WHERE director = 'Rajiv Chilaka';

-- Q8: List all TV shows with more than 5 seasons
SELECT *
FROM netflix
WHERE types = 'TV Show'
  AND SPLIT_PART(duration, ' ', 1)::NUMERIC > 5;

-- Q9: Count the number of content items in each genre
SELECT
    UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS genre,
    COUNT(show_id) AS total_content
FROM netflix
GROUP BY genre;

-- Q10: Find each year and the average number of content releases by India;
--      return the top 5 years with the highest average content release
SELECT
    EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY')) AS year,
    COUNT(*) AS yearly_content,
    ROUND(
        COUNT(*)::NUMERIC /
        (SELECT COUNT(*) FROM netflix WHERE country = 'India')::NUMERIC * 100,
        2
    ) AS avg_content_pct
FROM netflix
WHERE country = 'India'
GROUP BY year
ORDER BY avg_content_pct DESC
LIMIT 5;

-- Q11: List all movies that are documentaries
SELECT *
FROM netflix
WHERE listed_in ILIKE '%documentaries%'
  AND types = 'Movie';

-- Q12: Find all content without a director
SELECT *
FROM netflix
WHERE director IS NULL;

-- Q13: Find how many movies actor 'Salman Khan' appeared in over the last 10 years
SELECT *
FROM netflix
WHERE casts ILIKE '%Salman Khan%'
  AND release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;

-- Q14: Find the top 10 actors who have appeared in the highest number
--      of movies produced in India
SELECT
    UNNEST(STRING_TO_ARRAY(casts, ',')) AS actor,
    COUNT(*) AS total_content
FROM netflix
WHERE country ILIKE '%India%'
GROUP BY actor
ORDER BY total_content DESC
LIMIT 10;

-- ============================================================
-- End of Analysis
-- ============================================================
