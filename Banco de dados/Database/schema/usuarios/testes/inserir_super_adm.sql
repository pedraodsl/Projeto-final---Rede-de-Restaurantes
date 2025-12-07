use db_franquia;
    -- Superadmin global (sem restaurante)
INSERT INTO administrador (email, senha_hash, nivel_adm)
VALUES ('super@teste.com', 'hashsuper', 'superadmin');