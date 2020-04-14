USE DDL1;
CREATE TABLE proxecto (
    codigo_proxecto VARCHAR(128) NOT NULL,
    nome_proxecto VARCHAR(128) NOT NULL,
    orzamento VARCHAR(128) NOT NULL,
    data_inicio DATE,
    grupo VARCHAR(128),
    data_fin DATE
);