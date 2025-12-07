USE db_franquia;
CREATE OR REPLACE VIEW vw_pratos_mais_vendidos AS
SELECT
    p.nome AS nome_produto,
    r.nome AS nome_restaurante,
    SUM(ip.quantidade) AS quantidade_vendida
FROM item_pedido ip
INNER JOIN produto p
    ON ip.id_produto = p.id_produto
INNER JOIN pedido ped
    ON ip.id_pedido = ped.id_pedido
INNER JOIN restaurante r
    ON ped.id_restaurante = r.id_restaurante
GROUP BY p.nome, r.nome
ORDER BY quantidade_vendida DESC;

SELECT * FROM vw_pratos_mais_vendidos;
