use db_franquia;
    CREATE TABLE IF NOT EXISTS agendamento (
    id_agendamento BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_cliente BIGINT UNSIGNED NOT NULL,
    id_mesa BIGINT UNSIGNED NOT NULL,              -- vincula o agendamento à mesa reservada
    data DATE NOT NULL,
    hora TIME NOT NULL,
    status ENUM('confirmado','cancelado','concluido') NOT NULL DEFAULT 'confirmado',

    INDEX idx_agendamento_cliente (id_cliente),
    INDEX idx_agendamento_mesa (id_mesa),

    CONSTRAINT fk_agendamento_cliente FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_agendamento_mesa FOREIGN KEY (id_mesa)
        REFERENCES mesa(id_mesa)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE agendamento
    ADD CONSTRAINT uq_agendamento_mesa_data_hora
    UNIQUE (id_mesa, data, hora);
ALTER TABLE agendamento
    ADD INDEX idx_agendamento_data (data);

-- Alterando o agendamento: id cliente agora é opcional
ALTER TABLE agendamento
    MODIFY COLUMN id_cliente BIGINT UNSIGNED NULL,
    DROP FOREIGN KEY fk_agendamento_cliente;
-- Se cliente for deletado, mantém o registro histórico
ALTER TABLE agendamento
    ADD CONSTRAINT fk_agendamento_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente)
        ON UPDATE CASCADE
        ON DELETE SET NULL;

-- add restaurante para isolamento
ALTER TABLE agendamento
  add COLUMN id_restaurante BIGINT UNSIGNED NOT NULL;
ALTER TABLE agendamento
  ADD CONSTRAINT fk_agendamento_restaurante
    FOREIGN KEY (id_restaurante)
    REFERENCES restaurante(id_restaurante)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE agendamento
    -- Campos de dados do cliente (contato direto)
    ADD COLUMN nome_completo VARCHAR(150) NOT NULL AFTER id_cliente,
    ADD COLUMN email VARCHAR(150) NOT NULL AFTER nome_completo,
    ADD COLUMN telefone VARCHAR(20) NOT NULL AFTER email,

    -- Dados da reserva em si
    ADD COLUMN numero_pessoas INT UNSIGNED NOT NULL AFTER telefone,
    ADD COLUMN mensagem TEXT NULL ;

