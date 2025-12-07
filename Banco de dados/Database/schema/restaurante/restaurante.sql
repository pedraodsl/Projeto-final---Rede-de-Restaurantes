use db_franquia;
CREATE TABLE restaurante (
    id_restaurante BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    telefone VARCHAR(15) NOT NULL UNIQUE,
    email VARCHAR(100) NULL UNIQUE,
    endereco JSON NOT NULL,
    cnpj CHAR(14) NULL,
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
ALTER TABLE restaurante
    ADD COLUMN ativo BOOLEAN NOT NULL DEFAULT TRUE
        COMMENT 'Indica se o restaurante está ativo';
