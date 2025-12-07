CREATE TABLE log_adm_acao (
    id_log BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_administrador BIGINT UNSIGNED NOT NULL,
    acao VARCHAR(100) NOT NULL,  -- ex: 'INSERÇÃO', 'ALTERAÇÃO', 'EXCLUSÃO'
    tabela_afetada VARCHAR(100) NOT NULL,
    id_registro_afetado BIGINT UNSIGNED NULL,
    descricao TEXT NULL,         -- descrição textual da ação
    data_acao DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_log_adm_acao_administrador
        FOREIGN KEY (id_administrador)
        REFERENCES administrador(id_adm)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
