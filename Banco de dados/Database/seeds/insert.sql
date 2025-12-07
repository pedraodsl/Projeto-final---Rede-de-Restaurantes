-- Restaurantes
use db_franquia;
-- Inserções de exemplo para a tabela pagamento

INSERT INTO pagamento (
    id_pedido,
    id_cliente,
    id_restaurante,
    forma_pagamento,
    valor_pagamento,
    data_pagamento,
    status_pagamento,
    detalhes_transacao
) VALUES
-- Pagamento aprovado via cartão de crédito
(1, 2, 5, 2, 45.50, NOW(), 0,
    JSON_OBJECT(
        'metodo', 'pix',
        'chave_pix', 'cliente2@email.com',
        'codigo_qr', 'pix123456789',
        'status_pix', 'aguardando_confirmacao'
    )
);