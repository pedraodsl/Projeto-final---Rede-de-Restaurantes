use db_franquia;
CREATE TABLE item_pedido (
    id_item BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_pedido BIGINT UNSIGNED NOT NULL,
    id_produto BIGINT UNSIGNED NOT NULL,
    quantidade INT NOT NULL,
    valor_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2)
        GENERATED ALWAYS AS (quantidade * valor_unitario) STORED,

    CONSTRAINT chk_valor_unitario_pos
        CHECK (valor_unitario > 0),

    CONSTRAINT fk_item_pedido
        FOREIGN KEY (id_pedido)
        REFERENCES pedido(id_pedido)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_item_produto
        FOREIGN KEY (id_produto)
        REFERENCES produto(id_produto)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
        -- permanece como restrict e a lógica de ativo é backend
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
