CREATE OR REPLACE VIEW vw_mesas_disponibilidade AS
SELECT
    m.id_mesa,
    m.numero,
    m.capacidade,
    r.id_restaurante,
    a.hora AS hora_ocupada,
    a.data AS data_ocupada
FROM mesa m
LEFT JOIN agendamento a
    ON a.id_mesa = m.id_mesa
    AND a.status = 'confirmado'
LEFT JOIN restaurante r
    ON m.id_restaurante = r.id_restaurante;
