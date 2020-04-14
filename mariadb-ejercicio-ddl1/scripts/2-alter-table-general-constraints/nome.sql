ALTER TABLE sede
 ADD CONSTRAINT name_mask
    CHECK (
        nome_sede REGEXP '%[A-Za-zÑñÇç .,]%'
    );
ALTER TABLE ubicacion
 ADD CONSTRAINT name_mask
    CHECK (
        nome_sede REGEXP '%[A-Za-zÑñÇç .,]%'
        AND
        nome_depto REGEXP '%[A-Za-zÑñÇç .,]%'
    );
ALTER TABLE departamento
 ADD CONSTRAINT name_mask
    CHECK (
        nome_depto REGEXP '%[A-Za-zÑñÇç .,]%'
        AND
        director REGEXP '%[A-Za-zÑñÇç .,]%'
    );
ALTER TABLE grupo
 ADD CONSTRAINT name_mask
    CHECK (
        nome_grupo REGEXP '%[A-Za-zÑñÇç .,]%'
        AND
        nome_depto REGEXP '%[A-Za-zÑñÇç .,]%'
        AND
        lider REGEXP '%[A-Za-zÑñÇç .,]%'
    );
ALTER TABLE profesor
 ADD CONSTRAINT name_mask
    CHECK (
        nome_profesor REGEXP '%[A-Za-zÑñÇç .,]%'
    );
ALTER TABLE proxecto
 ADD CONSTRAINT name_mask
    CHECK (
        nome_proxecto REGEXP '%[A-Za-zÑñÇç .,]%'
    );
ALTER TABLE programa
 ADD CONSTRAINT name_mask
    CHECK (
        nome_programa REGEXP '%[A-Za-zÑñÇç .,]%'
    );
ALTER TABLE financia
 ADD CONSTRAINT name_mask
    CHECK (
        nome_programa REGEXP '%[A-Za-zÑñÇç .,]%'
    );