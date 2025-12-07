USE db_franquia;
CREATE OR REPLACE VIEW vw_cliente_metricas_cadastro AS
SELECT
    DATE_FORMAT(u.data_cadastro, '%Y-%m-01') AS mes,

    CASE DATE_FORMAT(u.data_cadastro, '%c')
        WHEN 1  THEN CONCAT('Janeiro ',   YEAR(u.data_cadastro))
        WHEN 2  THEN CONCAT('Fevereiro ', YEAR(u.data_cadastro))
        WHEN 3  THEN CONCAT('Março ',     YEAR(u.data_cadastro))
        WHEN 4  THEN CONCAT('Abril ',     YEAR(u.data_cadastro))
        WHEN 5  THEN CONCAT('Maio ',      YEAR(u.data_cadastro))
        WHEN 6  THEN CONCAT('Junho ',     YEAR(u.data_cadastro))
        WHEN 7  THEN CONCAT('Julho ',     YEAR(u.data_cadastro))
        WHEN 8  THEN CONCAT('Agosto ',    YEAR(u.data_cadastro))
        WHEN 9  THEN CONCAT('Setembro ',  YEAR(u.data_cadastro))
        WHEN 10 THEN CONCAT('Outubro ',   YEAR(u.data_cadastro))
        WHEN 11 THEN CONCAT('Novembro ',  YEAR(u.data_cadastro))
        WHEN 12 THEN CONCAT('Dezembro ',  YEAR(u.data_cadastro))
    END AS nome_mes,

    COUNT(*) AS total_cadastrados,
    SUM(c.status = TRUE)      AS ativos,
    SUM(c.status = FALSE)     AS inativos,
    SUM(c.status IS NULL)     AS sem_status

FROM cliente c
INNER JOIN usuario u ON c.cpf = u.cpf
GROUP BY
    DATE_FORMAT(u.data_cadastro, '%Y-%m-01'),
    YEAR(u.data_cadastro),
    MONTH(u.data_cadastro)
ORDER BY mes DESC;
/*
  vw_cliente_metricas_cadastro
  Resumo mensal de cadastros
  → Total, ativos, inativos e sem status
  → Nome do mês em PT-BR (ex: Novembro 2025)
  → Pronto pra dashboard (Metabase/PowerBI)
  → Atualizado automaticamente
  Última alteração: 2025-11-06 22:23 -03
*/