use db_franquia;
-- alterando a tabela pedidos
ALTER TABLE pedido
MODIFY COLUMN id_cliente BIGINT UNSIGNED NULL;
ALTER TABLE pedido
DROP FOREIGN KEY fk_pedido_cliente;
ALTER TABLE pedido
ADD CONSTRAINT fk_pedido_cliente
  FOREIGN KEY (id_cliente)
  REFERENCES cliente(id_cliente)
  ON DELETE SET NULL
  ON UPDATE CASCADE;
-- adicionando endereço
    ALTER TABLE pedido
    ADD COLUMN endereco JSON NULL AFTER id_restaurante;

-- tabela original
CREATE TABLE pedido (
    id_pedido BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_cliente BIGINT UNSIGNED NOT NULL,
    id_restaurante BIGINT UNSIGNED NOT NULL,
    data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    status_pedido ENUM('pendente', 'em_preparo', 'concluido', 'cancelado') DEFAULT 'pendente',
    valor_pedido DECIMAL(10,2) DEFAULT 0.00,
    forma_pagamento INT NULL,
    observacoes TEXT NULL,

    CONSTRAINT fk_pedido_cliente
        FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_pedido_restaurante
        FOREIGN KEY (id_restaurante) REFERENCES restaurante(id_restaurante)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
