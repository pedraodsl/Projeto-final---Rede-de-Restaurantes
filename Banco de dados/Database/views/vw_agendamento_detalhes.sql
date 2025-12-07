USE db_franquia;
    CREATE OR REPLACE VIEW vw_agendamento_detalhes AS
    SELECT
        a.id_agendamento,
        a.id_cliente,
        u.nome AS nome_cliente,
        a.data,
        a.hora,
        a.numero_pessoas,
        a.mensagem,
        r.id_restaurante,
        r.nome AS restaurante,
        CONCAT(
            COALESCE(JSON_UNQUOTE(JSON_EXTRACT(r.endereco, '$.logradouro')), ''),
            ', ',
            COALESCE(JSON_UNQUOTE(JSON_EXTRACT(r.endereco, '$.numero')), ''),
            ' - ',
            COALESCE(JSON_UNQUOTE(JSON_EXTRACT(r.endereco, '$.bairro')), ''),
            ', ',
            COALESCE(JSON_UNQUOTE(JSON_EXTRACT(r.endereco, '$.cidade')), ''),
            ' - ',
            COALESCE(JSON_UNQUOTE(JSON_EXTRACT(r.endereco, '$.uf')), '')
        ) AS endereco_restaurante
    FROM agendamento a
    INNER JOIN cliente c
        ON a.id_cliente = c.id_cliente
    INNER JOIN usuario u
        ON c.cpf = u.cpf
    INNER JOIN restaurante r
        ON a.id_restaurante = r.id_restaurante;
-- Listagem de reservas e histórico de agendamentos.
--
-- Pode ser usada para relatórios de ocupação, controle de mesas etc.