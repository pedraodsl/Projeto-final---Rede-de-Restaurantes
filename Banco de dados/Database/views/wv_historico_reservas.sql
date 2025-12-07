CREATE OR REPLACE VIEW vw_reservas_semanais AS
SELECT
    YEARWEEK(a.data, 3) AS semana_iso,
    COUNT(*) AS total_reservas
FROM agendamento a
GROUP BY YEARWEEK(a.data, 3)
ORDER BY semana_iso ASC;
