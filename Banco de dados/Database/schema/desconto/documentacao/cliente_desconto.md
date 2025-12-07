# Tabela: `cliente_desconto`  
**Script:** `create_cliente_desconto.sql`

---

## Descrição
Registra **descontos atribuídos a clientes**, permitindo rastreamento completo do ciclo de vida:  
**atribuição → uso → expiração/cancelamento**.  

- Relaciona **1 cliente** com **1 desconto** (concessão individual).  
- Permite **auditoria financeira** com `valor_aplicado`.  
- Armazena **origem da concessão** (`doação` ou `restaurante`).  
- Suporta **descontos de doação** (ex: arredondamento).

**Chave substituta:** `id_cliente_desconto` (autoincrementável)

---

## Estrutura da Tabela

| Campo | Tipo / Restrição | Descrição |
|------|------------------|-----------|
| `id_cliente_desconto` | `BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY` | Identificador único da concessão |
| `id_cliente` | `BIGINT UNSIGNED NOT NULL` | Cliente beneficiário (FK) |
| `id_desconto` | `BIGINT UNSIGNED NOT NULL` | Desconto concedido (FK) |
| `id_doacao` | `BIGINT UNSIGNED NULL` | Doação que gerou o desconto (opcional) |
| `status` | `ENUM('disponivel','usado','expirado','cancelado') NOT NULL DEFAULT 'disponivel'` | Estado atual |
| `data_atribuicao` | `DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP` | Quando foi concedido |
| `data_utilizacao` | `DATETIME NULL` | Quando foi usado |
| `valor_aplicado` | `DECIMAL(10,2) NULL` | Valor **real abatido** no pedido |
| `id_restaurante_origem` | `BIGINT UNSIGNED NULL` | Restaurante que concedeu (redundância histórica) |

---

## Integridade Referencial

| FK | Referência | `ON UPDATE` | `ON DELETE` | Comportamento |
|----|-----------|-------------|-------------|-------------|
| `fk_cd_cliente` | `cliente(id_cliente)` | `CASCADE` | `CASCADE` | **Remove concessões** se cliente for excluído |
| `fk_cd_desconto` | `desconto(id_desconto)` | `CASCADE` | `CASCADE` | **Remove concessões** se desconto for excluído |
| `fk_cd_doacao` | `doacao(id_doacao)` | `CASCADE` | `SET NULL` | **Desvincula doação** se removida |
| `fk_cd_restaurante_origem` | `restaurante(id_restaurante)` | `CASCADE` | `CASCADE` | **Remove referência** se restaurante for excluído |

---

## Regras de Negócio

| Regra | Detalhe |
|------|--------|
| **1 desconto por concessão** | Cada linha = **1 uso possível** |
| **Ciclo de vida** | `disponivel` → `usado` (preenche `data_utilizacao` + `valor_aplicado`) |
| **Expirado/Cancelado** | Gerenciado pela aplicação ou trigger |
| **Valor aplicado** | **Não é o valor do desconto**, mas o **abatido no pedido** (ex: R$ 5,00 de R$ 10,00) |
| **Restaurante origem** | Redundância útil para **relatórios por unidade** |
| **Doação opcional** | Só preenchido se desconto veio de arredondamento |

---

## Decisões de Projeto

| Decisão | Justificativa |
|--------|---------------|
| **`ON DELETE CASCADE` em `cliente`, `desconto`, `restaurante`** | **Evita dados órfãos** — concessão não existe sem cliente ou desconto |
| **`ON DELETE SET NULL` em `doacao`** | Preserva histórico mesmo se doação for apagada |
| **`status` com `ENUM`** | Garante consistência no ciclo de vida |
| **`valor_aplicado` NULLABLE** | Só preenchido quando `status = 'usado'` |
| **`id_restaurante_origem` redundante** | Permite **análise por unidade** sem JOIN com `desconto` |
| **Índices por entidade e status** | Otimiza consultas: `WHERE id_cliente = X AND status = 'disponivel'` |

---

## Exemplos de Uso

### 1. Desconto disponível (de doação)
```json
{
  "id_cliente": 101,
  "id_desconto": 50,
  "id_doacao": 33,
  "status": "disponivel",
  "data_atribuicao": "2025-10-29 14:30:00",
  "id_restaurante_origem": 7
}