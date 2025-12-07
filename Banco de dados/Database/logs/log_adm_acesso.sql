
CREATE TABLE log_adm_acesso (
    id_log BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_administrador BIGINT UNSIGNED NOT NULL,
    ultimo_login DATETIME DEFAULT CURRENT_TIMESTAMP,
    ultima_alteracao_senha DATETIME DEFAULT NULL,
    ip_origem VARCHAR(45) NULL,  -- suporta IPv4 e IPv6
    dispositivo VARCHAR(100) NULL,
    navegador VARCHAR(100) NULL,

    CONSTRAINT fk_log_adm_acesso_administrador
        FOREIGN KEY (id_administrador)
        REFERENCES administrador(id_adm)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
