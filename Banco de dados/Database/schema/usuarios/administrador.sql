use db_franquia;
-- ==========================================================
-- Tabela: administrador
-- Descrição: Representa administradores do sistema,
-- com escopo local (por restaurante) ou global (superadmin).
-- ==========================================================

CREATE TABLE administrador (
    id_adm BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_restaurante BIGINT UNSIGNED NULL,
    email VARCHAR(100) NOT NULL,
    senha_hash VARCHAR(255) NOT NULL,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    nivel_adm ENUM('normal','superadmin') DEFAULT 'normal',

    CONSTRAINT fk_adm_usuario
        FOREIGN KEY (email) REFERENCES usuario(email)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_adm_restaurante
        FOREIGN KEY (id_restaurante) REFERENCES restaurante(id_restaurante)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE administrador
DROP COLUMN  senha_hash;
