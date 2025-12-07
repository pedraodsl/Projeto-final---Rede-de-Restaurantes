# Módulo Usuários – Documentação do Banco de Dados

---

## Tabela: `usuario`

### Descrição
Armazena informações básicas de todos os usuários do sistema. Serve como base para **herança de atributos** em outras tabelas, como `Cliente` e `Administrador`.

> **Princípio**:  
> - **Todo cliente é usuário**, mas **nem todo usuário é cliente**.  
> - **Todo administrador é usuário**, mas **nem todo usuário é administrador**.

---

### Estrutura da Tabela

| Campo               | Tipo / Restrição                                      | Descrição |
|---------------------|-------------------------------------------------------|-----------|
| `cpf`               | `CHAR(11) NOT NULL PRIMARY KEY`                        | Identificador único do usuário; chave primária. |
| `email`             | `VARCHAR(100) UNIQUE NOT NULL`                        | Email do usuário; obrigatório e único; usado para login e vinculação. |
| `nome`              | `VARCHAR(255) NOT NULL`                               | Nome completo do usuário. |
| `telefone`          | `VARCHAR(12) UNIQUE NOT NULL`                         | Número de telefone; único para evitar duplicidade. |
| `data_cadastro`     | `DATETIME DEFAULT CURRENT_TIMESTAMP`                  | Data de criação do usuário. |
| `data_atualizacao`  | `DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP` | Atualiza automaticamente ao modificar o registro. |

---

### Restrições e Integridade Referencial

- **Chaves únicas**:
  - `cpf` → garante identificação única.
  - `email` e `telefone` → evitam duplicidade de contato.

- **Relacionamentos futuros**:
  - `cpf` → usado como FK em `Cliente` (herança).
  - `email` → usado como FK em `Administrador` (vinculação de login).

---

### Regras de Negócio

- Todo usuário registrado **pode vir a ser** cliente ou administrador.
- Atualizações em `email` ou `cpf` devem ser propagadas com `ON UPDATE CASCADE`.
- Exclusão de usuário é **restrita** se houver dependências em `Administrador` ou `Cliente` → `ON DELETE RESTRICT`.

---

## Tabela: `administrador`

### Objetivo
Registra e controla usuários com privilégios administrativos.  
É uma **especialização da entidade `usuario`**, herdando o `email` como identificador lógico.

> **Tipos de Administrador**:
> - **Normal**: escopo local (vinculado a um restaurante).
> - **Superadmin**: escopo global (não vinculado a restaurante).

---

### Estrutura SQL

```sql
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

🧱 Campos e Funções

Campo	Tipo	Nulidade	Descrição

id_adm	BIGINT UNSIGNED	NOT NULL	Identificador único (autoincrementável).
id_restaurante	BIGINT UNSIGNED	NULL	Restaurante vinculado (apenas para administradores normal).
email	VARCHAR(100)	NOT NULL	Herda do usuario; FK para autenticação e login.
senha_hash	VARCHAR(255)	NOT NULL	Senha criptografada (hash seguro).
data_cadastro	DATETIME	DEFAULT CURRENT_TIMESTAMP	Data de registro do administrador.
nivel_adm	ENUM('normal','superadmin')	DEFAULT 'normal'	Define nível de permissão: normal (local) ou superadmin (global).

🔗 Relacionamentos e Integridade

1. Herança de usuario → Relação (0,1)

Chave: email → usuario(email)

ON UPDATE CASCADE: alteração no e-mail do usuário é refletida automaticamente.

ON DELETE RESTRICT: impede exclusão de usuário com administrador ativo.

2. Vinculação a restaurante → Relação (0,1)

Chave: id_restaurante → restaurante(id_restaurante)

ON UPDATE CASCADE: mudanças no ID do restaurante são propagadas.

ON DELETE RESTRICT: impede exclusão de restaurante com administradores vinculados.

⚙️ Triggers de Validação

O MySQL não permite CHECK em colunas com FOREIGN KEY, portanto, as regras de consistência são aplicadas por triggers.

Trigger: trg_adm_check_insert → BEFORE INSERT
CREATE TRIGGER trg_adm_check_insert
BEFORE INSERT ON administrador
FOR EACH ROW
BEGIN
    IF NEW.nivel_adm = 'normal' AND NEW.id_restaurante IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Administrador normal deve estar vinculado a um restaurante.';
    END IF;

    IF NEW.nivel_adm = 'superadmin' AND NEW.id_restaurante IS NOT NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Superadmin não pode estar vinculado a um restaurante.';
    END IF;
END;

Trigger: trg_adm_check_update → BEFORE UPDATE
CREATE TRIGGER trg_adm_check_update
BEFORE UPDATE ON administrador
FOR EACH ROW
BEGIN
    IF NEW.nivel_adm = 'normal' AND NEW.id_restaurante IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Administrador normal deve estar vinculado a um restaurante.';
    END IF;

    IF NEW.nivel_adm = 'superadmin' AND NEW.id_restaurante IS NOT NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Superadmin não pode estar vinculado a um restaurante.';
    END IF;
END;

🧭 Comportamento Garantido

Regra|	Descrição

Administrador normal|	Sempre possui id_restaurante vinculado.
Superadmin|	Nunca possui id_restaurante.
Alterações em usuario.email ou restaurante.id_restaurante|	Propagadas via CASCADE.
Qualquer violação de escopo| Gera erro SQL imediato.

🧠 Decisões de Projeto

Decisão |	Justificativa

Herança via email	|Simplifica autenticação e login centralizado.
id_restaurante opcional|	Diferencia escopo local (normal) e global (superadmin).
ENUM nivel_adm	|Garante valores válidos e controle claro de permissão.
ON DELETE/UPDATE|	Mantém integridade referencial automática.
Triggers|	Substituem CHECK, garantindo regras de negócio complexas.

👥 Tabela: cliente
🧾 Descrição

Armazena informações de clientes da franquia.
Herda atributos do usuario via cpf.
Clientes podem receber descontos de doações e são visíveis globalmente em toda a rede.

Chave substituta: id_cliente (autoincrementável)

🏗️ Estrutura da Tabela
CREATE TABLE cliente (
    id_cliente BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    cpf CHAR(11) NULL,
    data_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_cliente_usuario
        FOREIGN KEY (cpf) REFERENCES usuario(cpf)
        ON UPDATE CASCADE
        ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

🔗 Integridade Referencial
Ação	|Comportamento
ON UPDATE CASCADE|	Alteração no CPF do usuário é refletida automaticamente.
ON DELETE SET NULL|	Exclusão do usuário define cpf = NULL, preservando o cliente.

cpf é NULLABLE para permitir ON DELETE SET NULL.

⚙️ Regras de Negócio

Regra|	Detalhe
Relação (0,1)	Cada usuário pode ter no máximo um cliente associado.
Descontos por doações|	Clientes recebem descontos gerados por doações.
Visibilidade global	|Todos os restaurantes da franquia acessam dados dos clientes.
Aplicação de desconto|	Usa o desconto mais antigo disponível. Aplica automaticamente ou sugere ao cliente</li><li>Permite apenas um desconto por compra</li></ul>

🧠 Decisões de Projeto

Decisão|	Justificativa
cpf permite NULL|	Necessário para ON DELETE SET NULL.
ON DELETE SET NULL|	Preserva o histórico de clientes mesmo após exclusão do usuário.
ON UPDATE CASCADE|	Garante sincronização automática do CPF.
Triggers + FKs|	Mantêm integridade e coerência das regras de negócio.

---