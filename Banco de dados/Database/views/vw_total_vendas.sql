USE db_franquia;
    CREATE VIEW vw_total_vendas_diario AS
        SELECT
            DATE (p.data_pagamento) AS data_venda,
            r.id_restaurante,
            r.nome AS restaurante,
            SUM(p.valor_pagamento) AS total_vendas
    FROM pagamento p
    INNER JOIN restaurante r ON p.id_restaurante = r.id_restaurante
    WHERE p.status_pagamento = '1'
    -- pagamentos bem sucedidos devem retornar 1
    GROUP BY DATE(p.data_pagamento), r.id_restaurante, r.nome
    ORDER BY data_venda DESC;
-- Diferença percentual (Backend) (a-b)/100 * 100 = Diferença_percentual
-- view basica: se eu quiser filtar %y, %m, %d faço pelo backend
-- da pra exibir na evolução de vendas tbm