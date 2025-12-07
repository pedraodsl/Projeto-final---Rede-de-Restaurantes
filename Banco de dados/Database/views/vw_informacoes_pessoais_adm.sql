USE db_franquia;
CREATE OR REPLACE VIEW vw_informacoes_pessoais_adm AS
SELECT
    a.id_adm,
    u.nome AS nome_administrador,
    u.email,
    u.telefone
FROM administrador a
INNER JOIN usuario u ON a.email = u.email;
