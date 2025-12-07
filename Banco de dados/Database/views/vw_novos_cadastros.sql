USE db_franquia;
    CREATE VIEW vw_novos_cadastros AS
    SELECT
         DATE (u.data_cadastro) AS data_cadastro, 
        COUNT(c.id_cliente) AS total_novos_clientes
    FROM cliente c
    INNER JOIN usuario u ON c.cpf = u.cpf
    GROUP BY DATE(u.data_cadastro)
    ORDER BY data_cadastro DESC;
