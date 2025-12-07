CREATE OR REPLACE VIEW vw_filiais_populares_avaliadas AS
SELECT
    r.id_restaurante,
    r.nome AS filial,
    JSON_UNQUOTE(JSON_EXTRACT(r.endereco, '$.cidade')) AS cidade,
    COUNT(DISTINCT ped.id_pedido) AS total_pedidos,
    SUM(p.valor_pagamento) AS total_vendas
FROM restaurante r
INNER JOIN pedido ped
    ON ped.id_restaurante = r.id_restaurante
INNER JOIN pagamento p
    ON p.id_pedido = ped.id_pedido
WHERE p.status_pagamento = 1
GROUP BY
    r.id_restaurante,
    r.nome,
    JSON_UNQUOTE(JSON_EXTRACT(r.endereco, '$.cidade'))
ORDER BY
    total_pedidos DESC,
    total_vendas DESC
LIMIT 6;
-- exibe os seis restaurantes mais bem avaliados