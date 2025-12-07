 USE db_franquia;
CREATE OR REPLACE VIEW vw_reservas AS
SELECT
    r.id_restaurante,
    a.id_agendamento,
    u.nome AS cliente_nome,
    u.telefone AS cliente_telefone,
    a.data AS data_reserva,
    a.hora AS hora_reserva,

    CASE
        WHEN a.status = 'confirmado' THEN 'Gerenciar / Cancelar'
        WHEN a.status = 'cancelado' THEN 'Reserva Cancelada'
        ELSE 'Ação Indisponível'
    END AS acao

FROM agendamento a
JOIN restaurante r ON a.id_restaurante = r.id_restaurante
JOIN cliente c ON a.id_cliente = c.id_cliente
JOIN usuario u ON u.cpf = c.cpf
JOIN mesa m ON a.id_mesa = m.id_mesa;

