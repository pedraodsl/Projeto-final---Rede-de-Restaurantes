# Tabela: `pedido`

## Descrição
Registra **todos os pedidos** realizados nos **restaurantes da franquia**.  
Cada pedido é **vinculado a um cliente** (agora **opcional**) e a um **restaurante específico**, com controle de status, valor total e observações.  
Serve como **ponto central** para integração com `item_pedido`, `pagamento` e `descontos`.

**Chave substituta:** `id_pedido` (autoincrementável)

---

## Estrutura da Tabela

| Campo | Tipo / Restrição | Descrição |
|------|------------------|-----------|
| `id_pedido` | `BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY` | Identificador único do pedido |
| `id_cliente` | `BIGINT UNSIGNED NULL` | FK para `cliente(id_cliente)` – **agora opcional** |
| `id_restaurante` | `BIGINT UNSIGNED NOT NULL` | FK para `restaurante(id_restaurante)` – local do pedido |
| `data_pedido` | `DATETIME DEFAULT CURRENT_TIMESTAMP` | Data/hora do registro do pedido |
| `status_pedido` | `ENUM('pendente', 'em_preparo', 'concluido', 'cancelado') DEFAULT 'pendente'` | Ciclo de vida do pedido |
| `valor_pedido` | `DECIMAL(10,2) DEFAULT 0.00` | **Valor total** (calculado a partir dos itens) |
| `forma_pagamento` | `INT NULL` | Código da forma (ex: 1=dinheiro, 2=cartão) – definido no pagamento |
| `observacoes` | `TEXT NULL` | Notas do cliente ou cozinha (ex: "sem cebola", "entrega no balcão") |

---

## Integridade Referencial

| FK | Referência | `ON UPDATE` | `ON DELETE` | Comportamento |
|----|-----------|-------------|-------------|-------------|
| `fk_pedido_cliente` | `cliente(id_cliente)` | `CASCADE` | `SET NULL` | **Cliente removido → campo fica NULL** |
| `fk_pedido_restaurante` | `restaurante(id_restaurante)` | `CASCADE` | `RESTRICT` | **Impede exclusão** do restaurante se houver pedidos |

> **Mudança crítica:**  
> - `ON DELETE RESTRICT` → `SET NULL` na FK do cliente  
> - Permite **exclusão de cliente** mesmo com pedidos existentes  
> - Pedidos “órfãos” mantêm histórico com `id_cliente = NULL`

---

## Regras de Negócio (Atualizadas)

| Regra | Detalhe |
|------|--------|
| **Cliente opcional** | Pedidos balcão ou “visitante” não exigem cadastro |
| **Restaurante obrigatório** | Pedido sempre ocorre em uma unidade |
| **Status controlado** | Transições: `pendente` → `em_preparo` → `concluido` ou `cancelado` |
| **Valor calculado** | `valor_pedido = SUM(item_pedido.quantidade * produto.preco)` |
| **Forma de pagamento opcional** | Preenchida apenas após `pagamento` |
| **Cancelamento** | Só permitido se `status_pedido = 'pendente'` ou `'em_preparo'` |
| **Observações flexíveis** | Campo livre para comunicação cliente/cozinha |

---

## Decisões de Projeto (Atualizadas)

| Decisão | Justificativa |
|--------|---------------|
| **`id_cliente NULL`** | Permite **pedidos anônimos** (balcão, delivery rápido) |
| **`ON DELETE SET NULL`** | Preserva **histórico de vendas** mesmo se cliente for excluído |
| **`ENUM` para status** | Valores fixos, performance e clareza |
| **`valor_pedido` com `DEFAULT 0.00`** | Evita `NULL`; valor é atualizado por trigger |
| **`forma_pagamento NULL`** | Preenchido apenas após pagamento |
| **`observacoes TEXT`** | Suporte a mensagens longas |
| **`ENGINE=InnoDB`** | Transações, FKs e integridade |
| **`utf8mb4`** | Suporte a emojis e acentos |

---

## Script de Migração (para referência)

```sql
ALTER TABLE pedido
MODIFY COLUMN id_cliente BIGINT UNSIGNED NULL;

ALTER TABLE pedido
DROP FOREIGN KEY fk_pedido_cliente;

ALTER TABLE pedido
ADD CONSTRAINT fk_pedido_cliente
  FOREIGN KEY (id_cliente)
  REFERENCES cliente(id_cliente)
  ON DELETE SET NULL
  ON UPDATE CASCADE;