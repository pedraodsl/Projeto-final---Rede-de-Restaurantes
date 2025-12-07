use db_franquia;
-- 1_create_desconto.sql
CREATE TABLE desconto (
    id_desconto BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,

    -- Vinculação operacional
    id_restaurante BIGINT UNSIGNED NULL,   -- FK opcional: restaurante de origem
    id_doacao BIGINT UNSIGNED NULL,        -- FK opcional: se desconto veio de doação

    -- Auditoria de criador
    id_adm_criador BIGINT UNSIGNED NOT NULL,   -- obrigatório
    criado_por_snapshot JSON NOT NULL,         -- snapshot com {id, nome, cpf, role, email}

    -- Auditoria de atualizador
    id_adm_atualizador BIGINT UNSIGNED NULL,   -- opcional
    atualizado_por_snapshot JSON NULL,         -- snapshot do atualizador

    -- Metadados do desconto
    nome VARCHAR(120) NOT NULL,
    descricao TEXT DEFAULT NULL,
    tipo ENUM('percentual','valor_fixo') NOT NULL,
    valor DECIMAL(10,2) NOT NULL CHECK (valor >= 0),

    -- Validade
    data_inicio DATETIME NOT NULL,
    data_fim DATETIME NULL,
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    global BOOLEAN NOT NULL DEFAULT FALSE,

    -- Auditoria temporal
    criado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,

    -- Índices
    INDEX idx_desconto_restaurante (id_restaurante),
    INDEX idx_desconto_ativo_global (ativo, global),
    INDEX idx_desconto_periodo (data_inicio, data_fim),

    -- FKs
    CONSTRAINT fk_desconto_restaurante FOREIGN KEY (id_restaurante)
        REFERENCES restaurante(id_restaurante)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_desconto_doacao FOREIGN KEY (id_doacao)
        REFERENCES doacao(id_doacao)
        ON UPDATE CASCADE
        ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

