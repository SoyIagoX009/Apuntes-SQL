ALTER TABLE financia
 ADD CONSTRAINT money_mask
    CHECK (
        cantidade_financiada <= 0
    );