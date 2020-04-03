SELECT world.country AS "Países"
FROM world
WHERE world.country IN ('Spain', 'Portugal', 'France')
ORDER BY world.country DESC;