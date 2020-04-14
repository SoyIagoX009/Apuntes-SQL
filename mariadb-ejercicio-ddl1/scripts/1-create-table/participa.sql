USE DDL1;
CREATE TABLE participa (
    dni CHAR(9),
    codigo_proxecto VARCHAR(128) NOT NULL,
    data_inicio VARCHAR(128) NOT NULL,
    data_cese VARCHAR(128),
    dedicacion VARCHAR(128) NOT NULL
);