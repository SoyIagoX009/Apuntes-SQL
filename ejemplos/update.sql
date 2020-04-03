UPDATE world
SET capital='New York'
WHERE country=continent
RETURNING country, capital;