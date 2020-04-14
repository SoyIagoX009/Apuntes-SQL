ALTER TABLE participa
 ADD CONSTRAINT pa_end_date_logic
    CHECK (
        data_cese < data_inicio
    );
ALTER TABLE proxecto
 ADD CONSTRAINT po_end_date_logic
    CHECK (
        data_fin < data_inicio
    );