CREATE TABLE world(
	country valid_name PRIMARY KEY,
	capital valid_name UNIQUE NOT NULL,
	continent VARCHAR 
		CONSTRAINT valid_continents 
		CHECK (
			continent IN ('Africa', 'America', 'Asia', 'Europe', 'Oceania')
		),
	area BIGINT
		CONSTRAINT valid_area
		CHECK (
			area >= 0
		),
	population INTEGER
		CONSTRAINT valid_population
		CHECK (
			population >= 0
		),
	gdp INTEGER
		CONSTRAINT valid_gdp NOT NULL
);