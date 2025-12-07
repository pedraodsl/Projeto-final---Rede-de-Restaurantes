use db_franquia;
    CREATE TABLE IF NOT EXISTS comentario (
    id_comentario BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,

    id_cliente BIGINT UNSIGNED NULL,             -- permite manter comentário se cliente for excluído
    id_produto BIGINT UNSIGNED NOT NULL,
    id_restaurante BIGINT UNSIGNED NOT NULL,     -- isolamento por restaurante

    conteudo TEXT NOT NULL,
    nota TINYINT UNSIGNED NOT NULL CHECK (nota BETWEEN 1 AND 5),

    data_criacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    INDEX idx_comentario_cliente (id_cliente),
    INDEX idx_comentario_produto (id_produto),
    INDEX idx_comentario_restaurante (id_restaurante),

    CONSTRAINT fk_comentario_cliente FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente)
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    CONSTRAINT fk_comentario_produto FOREIGN KEY (id_produto)
        REFERENCES produto(id_produto)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_comentario_restaurante FOREIGN KEY (id_restaurante)
        REFERENCES restaurante(id_restaurante)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
