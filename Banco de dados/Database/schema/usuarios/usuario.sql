-- 🔹 TABELA: USUÁRIO
use db_franquia;

CREATE TABLE usuario (
    cpf CHAR(11) NOT NULL,                                   -- CPF é a chave primária e identificador único
    email VARCHAR(100) UNIQUE NOT NULL,                      -- E-mail único para login ou contato
    nome VARCHAR(255) NOT NULL,                              -- Nome completo do usuário
    telefone VARCHAR(12) UNIQUE NOT NULL,                    -- Telefone único (DDD + número)
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,         -- Data de criação do registro
    data_atualizacao DATETIME DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,                         -- Atualiza automaticamente na modificação

    PRIMARY KEY (cpf)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE usuario
ADD COLUMN senha_hash VARCHAR(255) NOT NULL AFTER telefone;

-- 📘 Comentário técnico:
-- A tabela `usuario` armazena informações básicas e de autenticação.
-- O CPF atua como chave primária, garantindo unicidade nacional.
-- Email e telefone são únicos para evitar duplicidade de contas.
-- O controle automático de data de atualização mantém integridade temporal.
