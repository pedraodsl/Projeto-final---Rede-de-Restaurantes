# Tabela: `produto`

## Descrição
Armazena **todos os produtos** (itens do cardápio) oferecidos pelos **restaurantes da franquia**.  
Cada produto é **vinculado a um restaurante específico**, permitindo cardápios personalizados por unidade.  
O administrador que criou/editou o produto é registrado opcionalmente.

**Chave substituta:** `id_produto` (autoincrementável)

---

## Estrutura da Tabela

| Campo | Tipo / Restrição | Descrição |
|------|------------------|-----------|
| `id_produto` | `BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY` | Identificador único do produto |
| `id_restaurante` | `BIGINT UNSIGNED NOT NULL` | FK para `restaurante(id_restaurante)` – **obrigatório** |
| `id_administrador` | `BIGINT UNSIGNED NULL` | FK para `administrador(id_adm)` – **opcional** (quem cadastrou/editou) |
| `nome` | `VARCHAR(255) NOT NULL` | Nome do produto (ex: "Hambúrguer Clássico") |
| `descricao` | `TEXT NULL` | Descrição detalhada (ingredientes, alergênicos, etc.) |
| `categoria` | `VARCHAR(100) NULL` | Categoria (ex: "Lanches", "Bebidas", "Sobremesas") |
| `preco` | `DECIMAL(10,2) NOT NULL` | Preço atual do produto (R$ 0.01 a R$ 99.999.999,99) |
| `ativo` | `BOOLEAN DEFAULT TRUE` | Indica se o produto está **disponível para venda** |
| `criado_em` | `DATETIME DEFAULT CURRENT_TIMESTAMP` | Data/hora de criação do registro |

---

## Integridade Referencial

| FK | Referência | `ON UPDATE` | `ON DELETE` | Comportamento |
|----|-----------|-------------|-------------|-------------|
| `fk_produto_restaurante` | `restaurante(id_restaurante)` | `CASCADE` | `RESTRICT` | **Impede exclusão** do restaurante se houver produtos |
| `fk_produto_administrador` | `administrador(id_adm)` | `CASCADE` | `SET NULL` | **Preserva produto** se administrador for excluído → `id_administrador = NULL` |

---

## Regras de Negócio

| Regra | Detalhe |
|------|--------|
| **Produto por restaurante** | Cada produto pertence a **apenas um restaurante** |
| **Preço obrigatório e positivo** | `preco > 0.00` — **validado no backend** |
| **Status de disponibilidade** | `ativo = FALSE` remove do cardápio, mas mantém histórico |
| **Administrador opcional** | Permite criação via sistema (ex: importação) sem usuário |
| **Nome único por restaurante** | Evita duplicidade no cardápio (recomendado: `UNIQUE KEY`) |
| **Categoria flexível** | Permite agrupamento em menus e relatórios |

---

## Decisões de Projeto

| Decisão | Justificativa                                                       |
|--------|---------------------------------------------------------------------|
| **`id_restaurante NOT NULL`** | Garante **cardápio local** (evita produtos globais acidentais)      |
| **`id_administrador NULL + SET NULL`** | **Preserva produto** mesmo se admin for desativado/excluído         |
| **`ON DELETE RESTRICT` no restaurante** | Protege **integridade do cardápio** e histórico de vendas           |
| **`ativo BOOLEAN`** | Soft delete: remove da venda, mas mantém em relatórios              |
| **`DECIMAL(10,2)`** | Precisão monetária exata                                            |
| **Validação de `preco > 0` no backend** | Melhor **UX**, **mensagens personalizadas** e **desempenho**        |
| ** `CHECK` constraint no banco** | Verifica e assegura que o banco receberá valores positivos em preço |

---

## Validação de Preço (Backend)

> **Regra:** `preco` **deve ser maior que zero**  
> **Camada:** Aplicação (API/backend)  
> **Comportamento:** Rejeita com erro `400 Bad Request` antes do `INSERT`/`UPDATE`

### Exemplo de resposta de erro
```json
{
  "erro": "preco_invalido",
  "mensagem": "O preço deve ser maior que zero",
  "campo": "preco"
}