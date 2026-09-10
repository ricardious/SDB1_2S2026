-- Validaciones de reglas que abarcan mas de una tabla.
-- Cada consulta debe devolver 0.

-- 1. Empleado asignado a una tienda distinta de la venta.
SELECT COUNT(*) AS empleados_tienda_incorrecta
FROM venta v
JOIN empleado e ON e.id_empleado = v.id_empleado
WHERE e.id_tienda <> v.id_tienda;

-- 2. Pagos distintos al total en ventas PAGADA.
WITH total_detalle AS (
    SELECT id_venta, SUM(subtotal) total FROM detalle_venta GROUP BY id_venta
), total_pago AS (
    SELECT id_venta, SUM(monto) total FROM pago GROUP BY id_venta
)
SELECT COUNT(*) AS ventas_pagadas_monto_incorrecto
FROM venta v
JOIN estado_venta ev ON ev.id_estado_venta = v.id_estado_venta
LEFT JOIN total_detalle td ON td.id_venta = v.id_venta
LEFT JOIN total_pago tp ON tp.id_venta = v.id_venta
WHERE ev.nombre = 'PAGADA'
  AND (td.total IS NULL OR tp.total IS NULL OR td.total <> tp.total);

-- 3. Ventas que no tienen al menos un detalle.
SELECT COUNT(*) AS ventas_sin_detalle
FROM venta v
WHERE NOT EXISTS (SELECT 1 FROM detalle_venta dv WHERE dv.id_venta = v.id_venta);

-- 4. Fechas de contratacion posteriores al dia de ejecucion.
SELECT COUNT(*) AS contrataciones_futuras
FROM empleado
WHERE fecha_contratacion > TRUNC(SYSDATE);
