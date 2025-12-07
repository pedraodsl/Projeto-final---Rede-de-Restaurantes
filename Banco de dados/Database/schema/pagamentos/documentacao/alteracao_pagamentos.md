# Alteração: `2_alter_pagamento_cliente_desconto.sql`  
**Tabela afetada:** `pagamento`  
**Objetivo:** Vincular pagamento ao **desconto usado** (via `cliente_desconto`)

---

## Resumo da Alteração
```sql
ALTER TABLE pagamento
    ADD COLUMN id_cliente_desconto BIGINT UNSIGNED NULL AFTER id_cliente,
    ADD CONSTRAINT fk_pagamento_cliente_desconto 
        FOREIGN KEY (id_cliente_desconto) REFERENCES cliente_desconto(id_cliente_desconto)
        ON UPDATE CASCADE
        ON DELETE SET NULL;