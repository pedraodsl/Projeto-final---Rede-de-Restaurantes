-- ==========================================================
-- Tabela: cliente
-- Descrição: Representa os usuários que são clientes no sistema.
-- Cada cliente herda o CPF da tabela 'usuario', garantindo integridade
-- e vínculo direto com o cadastro principal de usuários.
-- ==========================================================
use db_franquia;
CREATE TABLE cliente (
    id_cliente BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- Identificador único do cliente
    cpf CHAR(11) NOT NULL,                                 -- CPF do cliente (mesmo do usuário)
    data_registro DATETIME DEFAULT CURRENT_TIMESTAMP,       -- Data de criação do registro
    data_atualizacao DATETIME DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,                       -- Atualiza automaticamente a cada modificação

    CONSTRAINT fk_cliente_usuario
        FOREIGN KEY (cpf) REFERENCES usuario(cpf)
        ON UPDATE CASCADE                                   -- Se o CPF for atualizado no usuário, reflete aqui
        ON DELETE CASCADE                                  -- Possibilita a exclusão de um usuário vinculado a um cliente
);

-- Observação:
-- - A relação (0,1) indica que um cliente pode existir apenas se for também um usuário,
--   mas nem todo usuário precisa ser cliente.
-- - A restrição ON UPDATE CASCADE garante sincronismo no CPF herdado.
-- - O ON DELETE RESTRICT evita inconsistências caso tentem remover um usuário ativo como cliente.
ALTER TABLE cliente
    add column status boolean default true;