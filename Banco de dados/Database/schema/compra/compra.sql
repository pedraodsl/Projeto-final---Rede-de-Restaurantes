use db_franquia;
    CREATE TABLE compra (
    id_compra BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_pagamento BIGINT UNSIGNED NULL,
    id_cliente BIGINT UNSIGNED NULL,
    id_restaurante BIGINT UNSIGNED NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL CHECK (valor_total > 0),
    data_compra DATETIME DEFAULT CURRENT_TIMESTAMP,
    tipo_compra ENUM('presencial', 'online', 'delivery') DEFAULT 'presencial',
    observacoes TEXT NULL,

    CONSTRAINT fk_compra_pagamento FOREIGN KEY (id_pagamento)
        REFERENCES pagamento(id_pagamento)
        ON DELETE SET NULL
        ON UPDATE CASCADE,

    CONSTRAINT fk_compra_cliente FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente)
        ON DELETE SET NULL
        ON UPDATE CASCADE,

    CONSTRAINT fk_compra_restaurante FOREIGN KEY (id_restaurante)
        REFERENCES restaurante(id_restaurante)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
