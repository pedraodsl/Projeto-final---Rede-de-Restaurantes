# Tabela: `item_pedido`

## Descrição
Armazena **cada item** (produto + quantidade) de um **pedido**.  
É a tabela de **relacionamento N:N** entre `pedido` e `produto`, com cálculo automático do subtotal.  
Garante **integridade de preços** e **auditoria completa** do que foi pedido.

**Chave substituta:** `id_item` (autoincrementável)

---

## Estrutura da Tabela

| Campo | Tipo / Restrição | Descrição |
|------|------------------|-----------|
| `id_item` | `BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY` | Identificador único do item |
| `id_pedido` | `BIGINT UNSIGNED NOT NULL` | FK para `pedido(id_pedido)` – pedido pai |
| `id_produto` | `BIGINT UNSIGNED NOT NULL` | FK para `produto(id_produto)` – produto solicitado |
| `quantidade` | `INT NOT NULL` | Quantidade do produto (mínimo 1) |
| `valor_unitario` | `DECIMAL(10,2) NOT NULL` | **Preço do produto no momento do pedido** |
| `subtotal` | `DECIMAL(10,2) GENERATED ALWAYS AS (quantidade * valor_unitario) STORED` | **Calculado automaticamente** |

---

## Integridade Referencial

| FK | Referência | `ON UPDATE` | `ON DELETE` | Comportamento |
|----|-----------|-------------|-------------|-------------|
| `fk_item_pedido` | `pedido(id_pedido)` | `CASCADE` | `CASCADE` | **Item é excluído** se o pedido for excluído |
| `fk_item_produto` | `produto(id_produto)` | `CASCADE` | `RESTRICT` | **Impede exclusão** do produto se houver itens ativos |

---

## Restrições de Integridade

| Constraint | Regra | Justificativa |
|-----------|-------|---------------|
| `chk_valor_unitario_pos` | `CHECK (valor_unitario > 0)` | Garante preço **positivo** no momento do pedido |

> **Importante:** `valor_unitario` **congela o preço do produto** no momento do pedido  
> → Evita inconsistência se o preço do produto mudar depois

---

## Regras de Negócio

| Regra | Detalhe |
|------|--------|
| **Quantidade mínima** | `quantidade >= 1` (validação em backend ou trigger) |
| **Preço congelado** | `valor_unitario` = preço do `produto` **no momento do pedido** |
| **Subtotal automático** | `subtotal = quantidade × valor_unitario` (coluna gerada) |
| **Exclusão em cascata** | Se o pedido for excluído, **todos os itens vão junto** |
| **Produto protegido** | Não pode excluir produto com pedidos ativos |
| **Auditoria de preço** | Histórico de quanto o cliente **realmente pagou** |

---

## Decisões de Projeto

| Decisão | Justificativa |
|--------|---------------|
| **`ON DELETE CASCADE` em `pedido`** | Pedido é **dono** dos itens → exclusão limpa |
| **`ON DELETE RESTRICT` em `produto`** | Evita **perda de histórico de vendas** |
| **`valor_unitario` armazenado** | Garante **preço correto** mesmo se produto for alterado |
| **`GENERATED ALWAYS ... STORED`** | Cálculo automático + performance (índice possível) |
| **`CHECK (valor_unitario > 0)`** | Validação **no banco** (segurança) |
| **`quantidade` sem `CHECK`** | Validado no **backend** (melhor UX) |
| **`ENGINE=InnoDB`** | Suporte a colunas geradas e FKs |

---

## Exemplo de Registro

```json
{
  "id_item": 501,
  "id_pedido": 1001,
  "id_produto": 101,
  "quantidade": 2,
  "valor_unitario": 29.90,
  "subtotal": 59.80
}