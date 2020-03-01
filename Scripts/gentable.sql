CREATE TABLE world(
	country VARCHAR PRIMARY KEY 
		CONSTRAINT valid_country
		CHECK (
			country NOT SIMILAR TO '%(1|2|3|4|5|6|7|8|9|0)%'
		),
	capital VARCHAR UNIQUE NOT NULL
		CONSTRAINT valid_capital
		CHECK (
			capital NOT SIMILAR TO '%(1|2|3|4|5|6|7|8|9|0)%'
		),
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