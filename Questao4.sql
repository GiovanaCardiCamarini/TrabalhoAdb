CREATE OR REPLACE FUNCTION verificar_data_cirurgia()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.data_cirurgia > CURRENT_DATE THEN
        RAISE EXCEPTION 'Não é permitido inserir uma cirurgia com data posterior à data atual.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_verificar_data_cirurgia
BEFORE INSERT ON cirurgia
FOR EACH ROW
EXECUTE FUNCTION verificar_data_cirurgia();
