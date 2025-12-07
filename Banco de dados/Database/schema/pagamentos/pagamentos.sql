use db_franquia;
    CREATE TABLE pagamento (
    id_pagamento BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_pedido BIGINT UNSIGNED NOT NULL,
    id_cliente BIGINT UNSIGNED NULL,
    id_restaurante BIGINT UNSIGNED NOT NULL,
    forma_pagamento INT NOT NULL,
    valor_pagamento DECIMAL(10,2) NOT NULL,
    data_pagamento DATETIME DEFAULT CURRENT_TIMESTAMP,
    status_pagamento INT NOT NULL,
    detalhes_transacao JSON NOT NULL,

    CONSTRAINT fk_pagamento_pedido
        FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
        ON UPDATE CASCADE ON DELETE RESTRICT,

    CONSTRAINT fk_pagamento_cliente
        FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
        ON UPDATE CASCADE ON DELETE SET NULL,

    CONSTRAINT fk_pagamento_restaurante
        FOREIGN KEY (id_restaurante) REFERENCES restaurante(id_restaurante)
        ON UPDATE CASCADE ON DELETE RESTRICT
);
-- 2_alter_pagamento_cliente_desconto.sql
ALTER TABLE pagamento
    ADD COLUMN id_cliente_desconto BIGINT UNSIGNED NULL AFTER id_cliente,
    ADD CONSTRAINT fk_pagamento_cliente_desconto FOREIGN KEY (id_cliente_desconto)
        REFERENCES cliente_desconto(id_cliente_desconto)
        ON UPDATE CASCADE
        ON DELETE SET NULL;

