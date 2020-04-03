@echo off
del genrows.sql
echo TRUNCATE world CASCADE >> genrows.sql
echo INSERT INTO world (country, continent, area, population, gdp, capital) VALUES >> genrows.sql
for /f "tokens=1-6 delims=," %%G in (database.csv) do echo ('%%G', '%%H', %%I, %%J, %%K, '%%L'),>> genrows.sql
echo ;>> genrows.sql
cls
echo Recuerda eliminar la coma anterior al ; en genrows.sql
echo Pulsa cualquier tecla para cerrar...
pause > nul
