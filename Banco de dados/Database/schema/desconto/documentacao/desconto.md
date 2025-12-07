# Tabela: `desconto`  
**Script:** `1_create_desconto.sql` (versão atualizada)

---

## Descrição
Armazena **descontos promocionais** criados por administradores, aplicáveis em pedidos da franquia.  
- Pode ser **global** (toda a rede) ou **local** (um restaurante).  
- Pode estar vinculado a uma **doação** (ex: arredondamento solidário).  
- Suporta **percentual** ou **valor fixo**, com período de validade.  
- **Auditoria completa** com **snapshots JSON** do criador/atualizador.

**Chave substituta:** `id_desconto` (autoincrementável)

---

## Estrutura da Tabela

| Campo | Tipo / Restrição | Descrição |
|------|------------------|-----------|
| `id_desconto` | `BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY` | Identificador único |
| `id_restaurante` | `BIGINT UNSIGNED NULL` | Restaurante de origem (FK, opcional) |
| `id_doacao` | `BIGINT UNSIGNED NULL` | Doação geradora do desconto (opcional) |
| `id_adm_criador` | `BIGINT UNSIGNED NOT NULL` | Adm que criou (FK, obrigatório) |
| `criado_por_snapshot` | `JSON NOT NULL` | Snapshot: `{id, nome, cpf, role, email}` |
| `id_adm_atualizador` | `BIGINT UNSIGNED NULL` | Último adm que editou |
| `atualizado_por_snapshot` | `JSON NULL` | Snapshot do atualizador |
| `nome` | `VARCHAR(120) NOT NULL` | Nome do desconto |
| `descricao` | `TEXT DEFAULT NULL` | Descrição detalhada |
| `tipo` | `ENUM('percentual','valor_fixo') NOT NULL` | Tipo do desconto |
| `valor` | `DECIMAL(10,2) NOT NULL CHECK (valor >= 0)` | Valor: % ou R$ |
| `data_inicio` | `DATETIME NOT NULL` | Início da validade |
| `data_fim` | `DATETIME NULL` | Fim da validade (NULL = sem prazo) |
| `ativo` | `BOOLEAN NOT NULL DEFAULT TRUE` | Ativo/inativo |
| `global` | `BOOLEAN NOT NULL DEFAULT FALSE` | Válido em toda a franquia |
| `criado_em` | `DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP` | Data de criação |
| `atualizado_em` | `DATETIME NULL ON UPDATE CURRENT_TIMESTAMP` | Última atualização |

---

## Integridade Referencial

| FK | Referência | `ON UPDATE` | `ON DELETE` | Comportamento |
|----|-----------|-------------|-------------|-------------|
| `fk_desconto_restaurante` | `restaurante(id_restaurante)` | `CASCADE` | `CASCADE` | **Deleta o desconto** se o restaurante for excluído |
| `fk_desconto_doacao` | `doacao(id_doacao)` | `CASCADE` | `SET NULL` | **Desvincula** a doação se for removida |

> **Observação:** Não há FK para `administrador(id_adm)` → **auditoria via snapshot JSON**

---

## Regras de Negócio

| Regra | Detalhe |
|------|--------|
| **Desconto global** | Se `global = TRUE`, `id_restaurante` é ignorado |
| **Validade** | Aplicável se `ativo = TRUE` e `data_inicio ≤ NOW() ≤ data_fim` |
| **Valor válido** | `CHECK (valor >= 0)` → impede descontos negativos |
| **Snapshot obrigatório** | `criado_por_snapshot` **sempre preenchido** |
| **Atualização opcional** | `atualizado_por_snapshot` só é preenchido em `UPDATE` |
| **Doação opcional** | Apenas descontos de arredondamento têm `id_doacao` |

---

## Decisões de Projeto

| Decisão | Justificativa |
|--------|---------------|
| **`id_restaurante` NULLABLE + ON DELETE CASCADE`** | Descontos **locais são removidos** se o restaurante for excluído → **evita dados órfãos** |
| **`ON DELETE SET NULL` em doação** | Preserva o desconto mesmo se a doação for apagada |
| **Sem FK para `administrador`** | Evita bloqueio por exclusão de adm → **auditoria imutável via JSON** |
| **`JSON` para snapshots** | Preserva **dados do adm no momento da ação** (mesmo se alterado depois) |
| **`CHECK (valor >= 0)`** | Validação direta no banco |
| **`ativo` + `global` no índice composto** | Otimiza consulta: `WHERE ativo = TRUE AND global = TRUE` |
| **`utf8mb4_unicode_ci`** | Suporte a emojis, acentos e nomes completos |

---

## Exemplos de Snapshots

### `criado_por_snapshot`
```json
{
  "id": 15,
  "nome": "Ana Silva",
  "cpf": "12345678901",
  "role": "gerente",
  "email": "ana@franquia.com"
}