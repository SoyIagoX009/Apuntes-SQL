DELETE FROM world
WHERE country LIKE '%asia%'
RETURNING country, capital;