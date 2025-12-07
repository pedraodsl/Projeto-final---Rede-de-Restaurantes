USE db_franquia;
    CREATE OR REPLACE VIEW vw_cliente_detalhes AS
    SELECT
        c.id_cliente,
        u.cpf,
        u.nome,
        u.email,
        u.telefone,
        c.data_registro,
        c.status
    FROM cliente c
    INNER JOIN usuario u
     ON c.cpf = u.cpf;

-- Usar em telas de perfil de cliente ou listagens administrativas.
-- Evita joins desnecessários com reservas ou pagamentos.