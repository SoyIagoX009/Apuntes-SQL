CREATE DOMAIN valid_country VARCHAR(128) 
 CONSTRAINT valid_charset
  CHECK (
	 VALUE SIMILAR TO '[A-Za-zÑn .,-]{1,}'
  );