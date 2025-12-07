# Tabela: `mesa`  
**Script:** `create_mesa.sql`

---

## Descrição
Armazena **mesas físicas** de cada restaurante da franquia.  
Permite controle de **ocupação em tempo real** e associação direta com pedidos.  
Garante **identificação única por restaurante** (número + restaurante).

**Chave substituta:** `id_mesa` (autoincrementável)

---

## Estrutura da Tabela

| Campo | Tipo / Restrição | Descrição |
|------|------------------|-----------|
| `id_mesa` | `BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY` | Identificador único global |
| `id_restaurante` | `BIGINT UNSIGNED NOT NULL` | Restaurante ao qual a mesa pertence (FK) |
| `numero` | `INT UNSIGNED NOT NULL` | Número da mesa **dentro do restaurante** (ex: 1, 2, 3...) |
| `status` | `ENUM('disponivel','reservada','ocupada') NOT NULL DEFAULT 'disponivel'` | Estado atual da mesa |

---

## Integridade Referencial

| FK | Referência | `ON UPDATE` | `ON DELETE` | Comportamento |
|----|-----------|-------------|-------------|-------------|
| `fk_mesa_restaurante` | `restaurante(id_restaurante)` | `CASCADE` | `CASCADE` | **Remove todas as mesas** se o restaurante for excluído |

---

## Regras de Negócio

| Regra | Detalhe |
|------|--------|
| **Número único por restaurante** | `(id_restaurante, numero)` deve ser único → **não pode haver mesa 1 em dois restaurantes diferentes com mesmo número** |
| **Status obrigatório** | Sempre `disponivel`, `reservada` ou `ocupada` |
| **Uso em pedidos** | Mesa pode estar vinculada a um `pedido` ativo |
| **Reserva futura** | Aplicação pode gerenciar reservas com data/hora |

---

## Decisões de Projeto

| Decisão | Justificativa |
|--------|---------------|
| **`ON DELETE CASCADE`** | Se restaurante for excluído, **todas as mesas desaparecem** → evita dados órfãos |
| **`numero` sem FK** | Simplicidade: número é **lógico por restaurante** |
| **`status` com `ENUM`** | Garante consistência e performance em filtros |
| **Índice em `id_restaurante`** | Otimiza consultas: `WHERE id_restaurante = X` |
| **`IF NOT EXISTS`** | Idempotência em scripts de migração |

---

## Exemplos de Dados

| id_mesa | id_restaurante | numero | status |
|---------|----------------|--------|--------|
| 1       | 3              | 1      | ocupada |
| 2       | 3              | 2      | disponivel |
| 3       | 5              | 1      | reservada |

---

## Índices para Performance

```sql
INDEX idx_mesa_restaurante (id_restaurante)