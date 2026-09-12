-- Consulta 8: ventas REGISTRADA y su diferencia pendiente.
WITH total_detalle AS (
    SELECT id_venta, SUM(subtotal) AS total_venta
    FROM detalle_venta
    GROUP BY id_venta
), total_pago AS (
    SELECT id_venta, SUM(monto) AS total_pagado
    FROM pago
    GROUP BY id_venta
)
SELECT v.id_venta AS numero_venta,
       v.fecha_venta,
       t.nombre AS tienda,
       pc.nombres || ' ' || pc.apellidos AS cliente,
       td.total_venta,
       NVL(tp.total_pagado, 0) AS total_pagado,
       td.total_venta - NVL(tp.total_pagado, 0) AS diferencia_pendiente
FROM venta v
JOIN estado_venta ev ON ev.id_estado_venta = v.id_estado_venta
JOIN tienda t ON t.id_tienda = v.id_tienda
JOIN cliente c ON c.id_cliente = v.id_cliente
JOIN persona pc ON pc.id_persona = c.id_persona
JOIN total_detalle td ON td.id_venta = v.id_venta
LEFT JOIN total_pago tp ON tp.id_venta = v.id_venta
WHERE ev.nombre = 'REGISTRADA'
ORDER BY diferencia_pendiente DESC, v.fecha_venta, v.id_venta;
