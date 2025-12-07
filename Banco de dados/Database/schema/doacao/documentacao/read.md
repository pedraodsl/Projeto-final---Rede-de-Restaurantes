# Tabela: `doacao`

## Descrição
Registra **todas as doações realizadas por clientes** em restaurantes da franquia.  
As doações podem ser direcionadas a **entidades beneficentes** (`destino_doacao`) e geram **descontos automáticos** para o cliente (conforme regra de negócio).  
A doação é **opcionalmente vinculada a um cliente** (anônima ou identificada).

**Chave substituta:** `id_doacao` (autoincrementável)

---

## Estrutura da Tabela

| Campo | Tipo / Restrição | Descrição |
|------|------------------|-----------|
| `id_doacao` | `BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY` | Identificador único da doação |
| `id_cliente` | `BIGINT UNSIGNED NULL` | FK para `cliente(id_cliente)` – **opcional** (doação anônima) |
| `id_restaurante` | `BIGINT UNSIGNED NOT NULL` | FK para `restaurante(id_restaurante)` – local da doação |
| `destino_doacao` | `BIGINT UNSIGNED NOT NULL` | FK para entidade beneficente (ex: tabela `entidade_beneficente`) |
| `valor_doacao` | `DECIMAL(10,2) NOT NULL` | Valor doado (R$ 0.01 a R$ 99.999.999,99) |
| `data_doacao` | `DATETIME DEFAULT CURRENT_TIMESTAMP` | Data/hora da doação |
| `observacao` | `VARCHAR(255)` | Campo livre (ex: "Em memória de...", "Arredondamento") |

---

## Integridade Referencial

| FK | Referência | `ON UPDATE` | `ON DELETE` | Comportamento |
|----|-----------|-------------|-------------|-------------|
| `fk_doacao_cliente` | `cliente(id_cliente)` | `CASCADE` | `SET NULL` | **Preserva doação** se cliente for excluído → `id_cliente = NULL` |
| `fk_doacao_restaurante` | `restaurante(id_restaurante)` | `CASCADE` | `RESTRICT` | **Impede exclusão** do restaurante se houver doações |

> **Nota:** `destino_doacao` **deve referenciar uma tabela de entidades** (ex: `entidade_beneficente`).  
> **Sugestão:** Crie `fk_doacao_destino` com `ON DELETE RESTRICT`.

---

## Regras de Negócio

| Regra | Detalhe |
|------|--------|
| **Cliente opcional** | Doações podem ser **anônimas** (`id_cliente = NULL`) |
| **Restaurante obrigatório** | Toda doação ocorre em um **restaurante específico** |
| **Valor positivo** | `valor_doacao > 0.00` (validação em aplicação ou trigger) |
| **Geração de desconto** | Cada doação **gera um desconto proporcional** para o cliente (ex: 1 doação = 1 desconto) |
| **Desconto FIFO** | Descontos são aplicados na ordem mais antiga (ver tabela `cliente`) |
| **Observação opcional** | Campo para mensagens ou contexto |

---

## Decisões de Projeto

| Decisão | Justificativa |
|--------|---------------|
| **`id_cliente NULLABLE + SET NULL`** | Permite **doações anônimas** e **preserva histórico** mesmo se cliente for excluído |
| **`ON DELETE RESTRICT` no restaurante** | Garante **auditoria completa** (doações não podem ser perdidas) |
| **`destino_doacao` como FK** | Padroniza entidades e evita valores inválidos |
| **`observacao` como `VARCHAR(255)`** | Flexibilidade para mensagens curtas |
| **`DECIMAL(10,2)`** | Precisão monetária exata |

---

## Exemplo de Registro

```json
{
  "id_doacao": 1,
  "id_cliente": 42,
  "id_restaurante": 5,
  "destino_doacao": 3,
  "valor_doacao": 5.00,
  "data_doacao": "2025-10-29 14:30:00",
  "observacao": "Arredondamento do troco"
}