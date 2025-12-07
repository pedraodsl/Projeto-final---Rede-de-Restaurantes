CREATE OR REPLACE VIEW vw_cardapio AS
SELECT
    p.id_produto,
    p.nome AS nome_produto,
    p.preco,
    p.tempo_preparo_min,                         -- supondo que exista esse campo
    r.id_restaurante,
    r.nome AS restaurante,
    CASE
        WHEN p.ativo = 1 AND r.ativo = 1 THEN 'Disponível'
        ELSE 'Indisponível'
    END AS status_exibicao
FROM produto p
INNER JOIN restaurante r
    ON p.id_restaurante = r.id_restaurante
WHERE p.ativo = 1
  AND r.ativo = 1
ORDER BY r.nome, p.nome;
