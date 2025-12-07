
use db_franquia;
   -- 1_create_cliente_desconto.sql
CREATE TABLE IF NOT EXISTS cliente_desconto (
    id_cliente_desconto BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,

    -- Vinculação principal
    id_cliente BIGINT UNSIGNED NOT NULL,
    id_desconto BIGINT UNSIGNED NOT NULL,

    -- Se a concessão veio por doação, armazena o id_da_doacao
    id_doacao BIGINT UNSIGNED NULL,

    -- Status e datas
    status ENUM('disponivel','usado','expirado','cancelado') NOT NULL DEFAULT 'disponivel',
    data_atribuicao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_utilizacao DATETIME NULL,

    -- Valor aplicado (preenchido quando usado) — permite auditar abatimento real
    valor_aplicado DECIMAL(10,2) NULL,

    -- Referência ao restaurante no momento da concessão (redundância útil para histórico)
    id_restaurante_origem BIGINT UNSIGNED NULL,

    -- Índices
    INDEX idx_cd_cliente (id_cliente),
    INDEX idx_cd_desconto (id_desconto),
    INDEX idx_cd_status (status),

    -- FK constraints
    CONSTRAINT fk_cd_cliente FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_cd_desconto FOREIGN KEY (id_desconto)
        REFERENCES desconto(id_desconto)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_cd_doacao FOREIGN KEY (id_doacao)
        REFERENCES doacao(id_doacao)
        ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT fk_cd_restaurante_origem FOREIGN KEY (id_restaurante_origem)
        REFERENCES restaurante(id_restaurante)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

