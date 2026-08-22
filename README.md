# Netflix Movies and TV Shows Data Analysis (SQL)

## Overview
This project analyzes the Netflix titles dataset using SQL to answer real-world
business questions about content type, ratings, countries, genres, and cast/director
trends. It demonstrates aggregation, window functions, string/array parsing, and
date handling in PostgreSQL.

## Dataset
The dataset contains information about Netflix movies and TV shows, including:
- `show_id`, `types` (Movie/TV Show), `title`, `director`, `casts`
- `country`, `date_added`, `release_year`, `rating`, `duration`
- `listed_in` (genre), `description`

> Source: [Netflix Movies and TV Shows dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows) (Kaggle)

## Schema
```sql
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
```

## Business Questions Answered
1. Count the number of Movies vs TV Shows
2. Find the most common rating for Movies and TV Shows
3. List all movies released in a specific year
4. Find the top 5 countries with the most content on Netflix
5. Find the longest movie
6. Find content added in the last 5 years
7. Find all movies/TV shows by a specific director
8. List all TV shows with more than 5 seasons
9. Count the number of content items in each genre
10. Find the top 5 years with the highest average content release by India
11. List all movies that are documentaries
12. Find all content without a director
13. Find how many movies a specific actor appeared in over the last 10 years
14. Find the top 10 actors with the most movie appearances in India-produced content

## Key Techniques Used
- Aggregate functions (`COUNT`, `MAX`)
- Window functions (`RANK() OVER (PARTITION BY ...)`)
- String/array parsing (`STRING_TO_ARRAY`, `UNNEST`, `SPLIT_PART`)
- Date parsing and filtering (`TO_DATE`, `INTERVAL`)
- Subqueries and correlated calculations

## Tools
- PostgreSQL
- pgAdmin / any SQL client

## Author
Aastha — [LinkedIn](#) | Data Analytics & AI/ML

## License
This project is open source and available under the [MIT License](LICENSE).
