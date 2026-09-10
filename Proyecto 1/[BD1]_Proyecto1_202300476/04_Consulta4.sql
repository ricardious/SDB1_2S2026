-- Consulta 4: desempeno por empleado; excluye ventas anuladas.
WITH total_venta AS (
    SELECT id_venta, SUM(subtotal) AS total
    FROM detalle_venta
    GROUP BY id_venta
)
SELECT e.id_empleado AS codigo_empleado,
       pe.nombres || ' ' || pe.apellidos AS empleado,
       c.nombre AS cargo,
       t.nombre AS tienda,
       COUNT(v.id_venta) AS cantidad_ventas_atendidas,
       NVL(SUM(tv.total), 0) AS total_facturado
FROM empleado e
JOIN persona pe ON pe.id_persona = e.id_persona
JOIN cargo c ON c.id_cargo = e.id_cargo
JOIN tienda t ON t.id_tienda = e.id_tienda
LEFT JOIN venta v ON v.id_empleado = e.id_empleado
 AND v.id_estado_venta <> (SELECT id_estado_venta FROM estado_venta WHERE nombre = 'ANULADA')
LEFT JOIN total_venta tv ON tv.id_venta = v.id_venta
GROUP BY e.id_empleado, pe.nombres, pe.apellidos, c.nombre, t.nombre
ORDER BY total_facturado DESC, cantidad_ventas_atendidas DESC, empleado;
