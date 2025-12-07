use db_franquia;
-- ==========================================================
-- Trigger para INSERT
-- ==========================================================
CREATE TRIGGER trg_adm_check_insert
BEFORE INSERT ON administrador
FOR EACH ROW
BEGIN
    IF NEW.nivel_adm = 'normal' AND NEW.id_restaurante IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Administrador normal deve ter restaurante.';
    ELSEIF NEW.nivel_adm = 'superadmin' AND NEW.id_restaurante IS NOT NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Superadmin não pode ter restaurante.';
    END IF;
END;