SELECT COUNT(world.country) AS "Nº Países", world.continent AS "Continente"
FROM world
GROUP BY world.continent
HAVING COUNT(world.continent) > 40;