
use db_franquia;
-- Adiciona a constraint (só rejeita se violado)
-- Verifica valore e só os armazena se positivos
ALTER TABLE produto
    ADD CONSTRAINT chk_produto_preco_positivo
    CHECK (preco > 0);

CREATE TABLE produto (
    id_produto BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_restaurante BIGINT UNSIGNED NOT NULL,
    id_administrador BIGINT UNSIGNED NULL,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT NULL,
    categoria VARCHAR(100) NULL,
    preco DECIMAL(10,2) NOT NULL,
    ativo BOOLEAN DEFAULT TRUE,
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_produto_restaurante
        FOREIGN KEY (id_restaurante)
        REFERENCES restaurante(id_restaurante)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_produto_administrador
        FOREIGN KEY (id_administrador)
        REFERENCES administrador(id_adm)
        ON UPDATE CASCADE
        ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

alter table produto
    add column tempo_preparo_min int NOT NULL ;