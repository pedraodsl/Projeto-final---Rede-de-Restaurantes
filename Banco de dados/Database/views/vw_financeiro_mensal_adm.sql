use db_franquia;
    CREATE OR REPLACE VIEW vw_financeiro_mensal_adm AS
       SELECT
           r.id_restaurante,
           r.nome AS restaurante,
           ROUND(SUM(p.valor_pagamento), 2) AS total_recebido_mes
       FROM restaurante r
       JOIN pagamento p
        ON r.id_restaurante = p.id_restaurante
       WHERE MONTH(p.data_pagamento) = MONTH(CURDATE())
       AND YEAR(p.data_pagamento) = YEAR(CURDATE())
       AND p.status_pagamento = 1
       GROUP BY r.id_restaurante, r.nome;
use db_franquia;
select *from restaurante;