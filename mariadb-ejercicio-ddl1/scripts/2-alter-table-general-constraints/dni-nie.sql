ALTER TABLE departamento
 ADD CONSTRAINT id_mask
    CHECK (
        director REGEXP '[0-9]{8}[A-Z]'
	OR
        director REGEXP '[X|Y|Z][0-9]{7}[A-Z]'
    );
ALTER TABLE grupo
 ADD CONSTRAINT id_mask
    CHECK (
        lider REGEXP '[0-9]{8}[A-Z]'
	OR
        lider REGEXP '[X|Y|Z][0-9]{7}[A-Z]'
    );
ALTER TABLE participa
 ADD CONSTRAINT id_mask
    CHECK (
        dni REGEXP '[0-9]{8}[A-Z]'
	OR
        dni REGEXP '[X|Y|Z][0-9]{7}[A-Z]'
    );
ALTER TABLE profesor
 ADD CONSTRAINT id_mask
    CHECK (
        dni REGEXP '[0-9]{8}[A-Z]'
	OR
        dni REGEXP '[X|Y|Z][0-9]{7}[A-Z]'
    );