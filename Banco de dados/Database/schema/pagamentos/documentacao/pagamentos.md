# Tabela: `pagamento`

## Descrição
Registra **todos os pagamentos realizados** em pedidos da franquia.  
Centraliza informações financeiras, permitindo rastreamento por pedido, cliente, restaurante e forma de pagamento.

**Chave substituta:** `id_pagamento` (autoincrementável)

---

## Estrutura da Tabela

| Campo | Tipo / Restrição | Descrição |
|------|------------------|-----------|
| `id_pagamento` | `BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY` | Identificador único do pagamento |
| `id_pedido` | `BIGINT UNSIGNED NOT NULL` | FK para `pedido(id_pedido)` – **obrigatório** |
| `id_cliente` | `BIGINT UNSIGNED NULL` | FK para `cliente(id_cliente)` – **opcional** (pode ser anônimo) |
| `id_restaurante` | `BIGINT UNSIGNED NOT NULL` | FK para `restaurante(id_restaurante)` – local do pagamento |
| `forma_pagamento` | `INT NOT NULL` | Código da forma (ex: 1=dinheiro, 2=cartão, 3=PIX) |
| `valor_pagamento` | `DECIMAL(10,2) NOT NULL` | Valor total pago (R$ 99999999.99) |
| `data_pagamento` | `DATETIME DEFAULT CURRENT_TIMESTAMP` | Data/hora do pagamento |
| `status_pagamento` | `INT NOT NULL` | Status (ex: 1=pendente, 2=confirmado, 3=falha) |
| `detalhes_transacao` | `JSON NOT NULL` | Dados da transação (ex: bandeira, parcelas, código PIX) |

---

## Integridade Referencial

| FK | Referência | `ON UPDATE` | `ON DELETE` | Comportamento |
|----|-----------|-------------|-------------|-------------|
| `fk_pagamento_pedido` | `pedido(id_pedido)` | `CASCADE` | `RESTRICT` | **Impede exclusão** do pedido se houver pagamento |
| `fk_pagamento_cliente` | `cliente(id_cliente)` | `CASCADE` | `SET NULL` | **Preserva pagamento** se cliente for excluído → `id_cliente = NULL` |
| `fk_pagamento_restaurante` | `restaurante(id_restaurante)` | `CASCADE` | `RESTRICT` | **Impede exclusão** do restaurante se houver pagamento |

---

## Regras de Negócio

| Regra | Detalhe |
|------|--------|
| **Pagamento vinculado a pedido** | Todo pagamento **deve ter um `id_pedido` válido** |
| **Cliente opcional** | Permite pagamentos **sem cliente cadastrado** (ex: balcão) |
| **Restaurante obrigatório** | Pagamento **sempre ligado a um restaurante específico** |
| **Status obrigatório** | Sistema deve gerenciar ciclo de vida do pagamento |
| **Detalhes em JSON** | Flexibilidade para diferentes gateways (ex: Cielo, PagSeguro, PIX) |
| **Valor imutável após confirmação** | `valor_pagamento` não deve ser alterado após `status = confirmado` |

---

## Decisões de Projeto

| Decisão | Justificativa |
|--------|---------------|
| **`id_cliente` NULLABLE + SET NULL`** | Permite **pagamentos anônimos** e **preserva histórico** mesmo se cliente for excluído |
| **`ON DELETE RESTRICT` em pedido e restaurante** | Evita **perda de dados financeiros** (auditoria) |
| **`JSON` para detalhes** | Suporta **múltiplos gateways** sem alterar schema |
| **`forma_pagamento` e `status_pagamento` como `INT`** | Performance + uso com `ENUM` em aplicação (ex: constantes) |
| **`DECIMAL(10,2)`** | Precisão exata para valores monetários |

---

## Exemplos de Uso

### 1. Pagamento com cliente
```json
{
  "id_pagamento": 1,
  "id_pedido": 100,
  "id_cliente": 50,
  "id_restaurante": 3,
  "forma_pagamento": 2,
  "valor_pagamento": 89.90,
  "status_pagamento": 2,
  "detalhes_transacao": {
    "gateway": "Cielo",
    "bandeira": "Visa",
    "parcelas": 3,
    "nsu": "123456789"
  }
}