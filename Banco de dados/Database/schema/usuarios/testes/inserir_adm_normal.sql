 use db_franquia;
-- Administrador normal (vinculado a restaurante já existente)
INSERT INTO administrador (id_restaurante, email, senha_hash, nivel_adm)
VALUES (
    (SELECT id_restaurante FROM restaurante WHERE nome = 'Restaurante Sabor Caseiro'),
    'admin1@teste.com',
    'hash123',
    'normal'
);