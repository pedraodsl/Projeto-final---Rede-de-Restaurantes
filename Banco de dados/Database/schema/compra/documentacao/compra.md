# Tabela: `compra`

## Descrição
Registra **todas as transações de compra** realizadas na franquia, independentemente do canal (`presencial`, `online`, `delivery`).  
É o **registro final de venda**, agregando **pagamento**, **cliente**, **valor total** e **tipo de operação**.  
Serve como **fonte principal para relatórios de faturamento, desempenho por canal e auditoria**.

**Chave substituta:** `id_compra` (autoincrementável)

---

## Estrutura da Tabela

| Campo | Tipo / Restrição | Descrição |
|------|------------------|-----------|
| `id_compra` | `BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY` | Identificador único da compra |
| `id_pagamento` | `BIGINT UNSIGNED NULL` | FK para `pagamento(id_pagamento)` – **opcional** (ex: compra sem pagamento imediato) |
| `id_cliente` | `BIGINT UNSIGNED NULL` | FK para `cliente(id_cliente)` – **opcional** (venda anônima) |
| `id_restaurante` | `BIGINT UNSIGNED NOT NULL` | FK para `restaurante(id_restaurante)` – unidade da venda |
| `valor_total` | `DECIMAL(10,2) NOT NULL` | Valor final da compra (com descontos, taxas, etc.) |
| `data_compra` | `DATETIME DEFAULT CURRENT_TIMESTAMP` | Data/hora da finalização da compra |
| `tipo_compra` | `ENUM('presencial', 'online', 'delivery') DEFAULT 'presencial'` | Canal da venda |
| `observacoes` | `TEXT NULL` | Notas (ex: "Cliente pediu recibo", "Entrega no apto 301") |

---

## Integridade Referencial

| FK | Referência | `ON UPDATE` | `ON DELETE` | Comportamento |
|----|-----------|-------------|-------------|-------------|
| `fk_compra_pagamento` | `pagamento(id_pagamento)` | `CASCADE` | `SET NULL` | **Preserva compra** se pagamento for excluído → `id_pagamento = NULL` |
| `fk_compra_cliente` | `cliente(id_cliente)` | `CASCADE` | `SET NULL` | **Preserva compra** se cliente for excluído → `id_cliente = NULL` |
| `fk_compra_restaurante` | `restaurante(id_restaurante)` | `CASCADE` | `RESTRICT` | **Impede exclusão** do restaurante se houver compras |

---

## Restrições de Integridade

| Constraint | Regra | Justificativa |
|-----------|-------|---------------|
| `CHECK (valor_total > 0)` | Valor total **maior que zero** | Evita compras com valor nulo ou negativo |

---

## Regras de Negócio

| Regra | Detalhe |
|------|--------|
| **Restaurante obrigatório** | Toda compra ocorre em uma **unidade física** |
| **Cliente opcional** | Permite vendas **anônimas** (balcão, delivery sem login) |
| **Pagamento opcional** | Compra pode ser registrada **antes do pagamento** (ex: conta a pagar) |
| **Valor total positivo** | `valor_total > 0` — validado no banco |
| **Tipo de compra controlado** | Garante análise por canal |
| **Auditoria completa** | Mesmo com exclusão de cliente/pagamento, a **venda permanece** |
| **Descontos aplicados aqui** | `valor_total` já inclui descontos (ex: doações, promoções) |

---

## Decisões de Projeto

| Decisão | Justificativa |
|--------|---------------|
| **`id_cliente` e `id_pagamento` NULL + SET NULL`** | **Preserva histórico de vendas** mesmo com exclusão de registros relacionados |
| **`ON DELETE RESTRICT` no restaurante** | Garante **auditoria total** — vendas não podem ser apagadas |
| **`CHECK (valor_total > 0)`** | Validação **no banco** — segurança crítica |
| **`ENUM` para tipo_compra** | Valores fixos, performance e clareza em relatórios |
| **`valor_total` armazenado** | Evita recalcular em relatórios; valor final é **imutável após registro** |
| **`observacoes TEXT`** | Flexibilidade para anotações operacionais |

---

## Exemplo de Registro

```json
{
  "id_compra": 301,
  "id_pagamento": 150,
  "id_cliente": 42,
  "id_restaurante": 5,
  "valor_total": 67.90,
  "data_compra": "2025-10-29 12:45:00",
  "tipo_compra": "presencial",
  "observacoes": "Cliente usou desconto de doação"
}