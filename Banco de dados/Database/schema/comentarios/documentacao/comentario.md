# Tabela: `comentario`  
**Script:** `create_comentario.sql`

---

## Descrição
Armazena **avaliações e comentários** de clientes sobre **produtos** em **restaurantes específicos**.  
Permite **feedback granular** (por unidade e item), com **preservação histórica** mesmo se cliente for excluído.

**Chave substituta:** `id_comentario` (autoincrementável)

---

## Estrutura da Tabela

| Campo | Tipo / Restrição | Descrição |
|------|------------------|-----------|
| `id_comentario` | `BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY` | Identificador único |
| `id_cliente` | `BIGINT UNSIGNED NULL` | Cliente que comentou (FK, opcional) |
| `id_produto` | `BIGINT UNSIGNED NOT NULL` | Produto avaliado (FK) |
| `id_restaurante` | `BIGINT UNSIGNED NOT NULL` | Restaurante onde o produto foi consumido (FK) |
| `conteudo` | `TEXT NOT NULL` | Texto do comentário |
| `nota` | `TINYINT UNSIGNED NOT NULL CHECK (nota BETWEEN 1 AND 5)` | Avaliação de 1 a 5 estrelas |
| `data_criacao` | `DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP` | Data/hora do comentário |

---

## Integridade Referencial

| FK | Referência | `ON UPDATE` | `ON DELETE` | Comportamento |
|----|-----------|-------------|-------------|-------------|
| `fk_comentario_cliente` | `cliente(id_cliente)` | `CASCADE` | `SET NULL` | **Preserva comentário** se cliente for excluído → `id_cliente = NULL` |
| `fk_comentario_produto` | `produto(id_produto)` | `CASCADE` | `CASCADE` | **Remove comentário** se produto for excluído |
| `fk_comentario_restaurante` | `restaurante(id_restaurante)` | `CASCADE` | `CASCADE` | **Remove comentário** se restaurante for excluído |

---

## Regras de Negócio

| Regra | Detalhe |
|------|--------|
| **Cliente opcional** | Permite comentários anônimos ou preservação após exclusão |
| **Nota obrigatória** | `1 a 5` → validado por `CHECK` |
| **Produto + Restaurante** | Avaliação **contextualizada por unidade** |
| **Imutabilidade** | Comentário não pode ser alterado após criação |
| **1 comentário por cliente/produto/restaurante?** | Aplicação deve validar (opcional) |

---

## Decisões de Projeto

| Decisão | Justificativa |
|--------|---------------|
| **`id_cliente` NULLABLE + SET NULL`** | **Preserva feedback histórico** mesmo se cliente for removido |
| **`ON DELETE CASCADE` em produto e restaurante** | Comentário **não faz sentido** sem produto ou unidade |
| **`CHECK (nota BETWEEN 1 AND 5)`** | Validação direta no banco |
| **Índices por entidade** | Otimiza relatórios: média por produto, por restaurante |
| **`IF NOT EXISTS`** | Idempotência em migrações |

---

## Exemplos de Dados

| id_comentario | id_cliente | id_produto | id_restaurante | nota | conteudo |
|---------------|------------|------------|----------------|------|---------|
| 1             | 101        | 50         | 3              | 5    | "Melhor hambúrguer da cidade!" |
| 2             | NULL       | 51         | 3              | 3    | "Batata estava fria." |
| 3             | 103        | 50         | 5              | 4    | "Rápido e saboroso!" |

---

## Índices para Performance

```sql
INDEX idx_comentario_cliente (id_cliente),
INDEX idx_comentario_produto (id_produto),
INDEX idx_comentario_restaurante (id_restaurante)