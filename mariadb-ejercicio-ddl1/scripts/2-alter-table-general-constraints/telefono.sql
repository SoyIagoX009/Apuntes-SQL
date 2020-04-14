ALTER TABLE departamento
 ADD CONSTRAINT phone_mask
    CHECK (
        telefono REGEXP '[0-9]{9}'
    );