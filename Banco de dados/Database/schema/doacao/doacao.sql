use db_franquia;
    CREATE TABLE doacao (
    id_doacao BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_cliente BIGINT UNSIGNED NULL,
    id_restaurante_destino BIGINT UNSIGNED NOT NULL,
    valor_doacao DECIMAL(10,2) NOT NULL,
    observacao VARCHAR(255) NULL,
    data_doacao DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_doacao_cliente
        FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
        ON UPDATE CASCADE
        ON DELETE SET NULL,

    CONSTRAINT fk_doacao_restaurante
        FOREIGN KEY (id_restaurante_destino) REFERENCES restaurante(id_restaurante)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
