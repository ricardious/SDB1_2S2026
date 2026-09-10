-- Consulta 7: uso de metodos de pago; excluye pagos de ventas anuladas.
SELECT mp.nombre AS metodo_pago,
       COUNT(p.id_pago) AS cantidad_pagos,
       NVL(SUM(p.monto), 0) AS monto_total_recibido
FROM metodo_pago mp
LEFT JOIN pago p ON p.id_metodo_pago = mp.id_metodo_pago
LEFT JOIN venta v ON v.id_venta = p.id_venta
LEFT JOIN estado_venta ev ON ev.id_estado_venta = v.id_estado_venta
WHERE ev.nombre IS NULL OR ev.nombre <> 'ANULADA'
GROUP BY mp.id_metodo_pago, mp.nombre
ORDER BY monto_total_recibido DESC, mp.nombre;
