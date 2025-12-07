use db_franquia;
    CREATE TABLE IF NOT EXISTS mesa (
    id_mesa BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_restaurante BIGINT UNSIGNED NOT NULL,
    numero INT UNSIGNED NOT NULL,                   -- número da mesa dentro do restaurante
    status ENUM('disponivel','reservada','ocupada') NOT NULL DEFAULT 'disponivel',

    INDEX idx_mesa_restaurante (id_restaurante),
    CONSTRAINT fk_mesa_restaurante FOREIGN KEY (id_restaurante)
        REFERENCES restaurante(id_restaurante)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE mesa
    ADD COLUMN capacidade TINYINT NOT NULL;