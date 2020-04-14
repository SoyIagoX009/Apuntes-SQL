CREATE DATABASE DDL1;

CREATE TABLE sede (
    nome_sede VARCHAR(128),
    campus VARCHAR(128)
);
CREATE TABLE ubicacion (
    nome_sede VARCHAR(128),
    nome_depto VARCHAR(128)
);
CREATE TABLE departamento (
    nome_depto VARCHAR(128),
    telefono VARCHAR(128),
    director VARCHAR(128)
);
CREATE TABLE grupo (
    nome_grupo VARCHAR(128),
    nome_depto VARCHAR(128),
    area VARCHAR(128),
    lider VARCHAR(128)
);
CREATE TABLE profesor (
    dni CHAR(9),
    nome_profesor VARCHAR(128),
    titulacion VARCHAR(128),
    experiencia VARCHAR(128),
    grupo VARCHAR(128)
);
CREATE TABLE participa (
    dni CHAR(9),
    codigo_proxecto VARCHAR(128),
    data_inicio DATE,
    data_cese DATE,
    dedicacion VARCHAR(128)
);
CREATE TABLE proxecto (
    codigo_proxecto VARCHAR(128),
    nome_proxecto VARCHAR(128),
    orzamento VARCHAR(128),
    data_inicio DATA,
    grupo VARCHAR(128),
    data_fin DATA
);
CREATE TABLE programa (
    nome_programa VARCHAR(128)
);
CREATE TABLE financia (
    nome_programa VARCHAR(128),
    codigo_proxecto VARCHAR(128),
    numero_proxecto VARCHAR(128),
    cantidade_financiada INT
);


CREATE DOMAIN id_mask CHAR(9)
    CHECK (
        VALUE SIMILAR TO '[0-9]{8}[A-Z]'	    -- Formato DNI.
		OR
		VALUE SIMILAR TO '[A-Z][0-9]{7}[A-Z]'	-- Formato NIE.
    );

CREATE DOMAIN name_mask VARCHAR(128)
    CHECK (
        VALUE SIMILAR TO '%[A-Za-zÑñ .,]%'      -- Solo permitimos A-Z, punto y coma. 
    );

CREATE DOMAIN money_mask BIGINT
    CHECK (
        VALUE NOT NULL
        OR
        VALUE < 0
    )

CREATE DOMAIN es_phone_mask CHAR(9)
    CHECK (
        VALUE SIMILAR TO '[0-9]{9}'
    )