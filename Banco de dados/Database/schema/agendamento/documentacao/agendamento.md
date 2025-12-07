# Tabela: `agendamento`  
**Script:** `create_agendamento_with_constraints.sql`  
**Status:** **Pronto para produção com integridade total**

---

## Descrição
Gerencia **reservas de mesas** por clientes em restaurantes da franquia.  
Garante **exclusividade de uso** (1 mesa, 1 horário) e **integridade referencial**.  
Ideal para **app de reservas**, **PDV** e **painel de ocupação**.

**Chave substituta:** `id_agendamento` (autoincrementável)

---

## Estrutura da Tabela

| Campo | Tipo / Restrição | Descrição |
|------|------------------|-----------|
| `id_agendamento` | `BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY` | Identificador único |
| `id_cliente` | `BIGINT UNSIGNED NOT NULL` | Cliente que fez a reserva (FK) |
| `id_mesa` | `BIGINT UNSIGNED NOT NULL` | Mesa reservada (FK) |
| `data` | `DATE NOT NULL` | Data da reserva |
| `hora` | `TIME NOT NULL` | Hora da reserva |
| `status` | `ENUM('confirmado','cancelado','concluido') NOT NULL DEFAULT 'confirmado'` | Estado do agendamento |

---

## Integridade Referencial

| FK | Referência | `ON UPDATE` | `ON DELETE` | Comportamento |
|----|-----------|-------------|-------------|-------------|
| `fk_agendamento_cliente` | `cliente(id_cliente)` | `CASCADE` | `CASCADE` | Remove reservas se cliente for excluído |
| `fk_agendamento_mesa` | `mesa(id_mesa)` | `CASCADE` | `CASCADE` | Remove reservas se mesa for excluída |

---

## Restrições de Unicidade

```sql
CONSTRAINT uq_agendamento_mesa_data_hora UNIQUE (id_mesa, data, hora)
#Impede dois agendamentos na mesma mesa, data e hora
#Garante exclusividade física