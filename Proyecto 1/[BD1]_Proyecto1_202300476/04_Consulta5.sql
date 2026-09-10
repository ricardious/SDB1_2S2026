-- Consulta 5: clientes con mayor compra; considera solo ventas PAGADA.
WITH total_venta AS (
    SELECT id_venta, SUM(subtotal) AS total
    FROM detalle_venta
    GROUP BY id_venta
)
SELECT c.id_cliente AS codigo_cliente,
       pe.nombres || ' ' || pe.apellidos AS cliente,
       m.nombre AS municipio_residencia,
       COUNT(v.id_venta) AS cantidad_ventas_pagadas,
       SUM(tv.total) AS monto_total_comprado
FROM cliente c
JOIN persona pe ON pe.id_persona = c.id_persona
JOIN municipio m ON m.id_municipio = pe.id_municipio
JOIN venta v ON v.id_cliente = c.id_cliente
JOIN estado_venta ev ON ev.id_estado_venta = v.id_estado_venta AND ev.nombre = 'PAGADA'
JOIN total_venta tv ON tv.id_venta = v.id_venta
GROUP BY c.id_cliente, pe.nombres, pe.apellidos, m.nombre
ORDER BY monto_total_comprado DESC, cantidad_ventas_pagadas DESC, cliente;
