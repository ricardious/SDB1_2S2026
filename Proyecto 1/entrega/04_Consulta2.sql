-- Consulta 2: ventas por tipo de tienda; excluye ventas anuladas.
WITH total_venta AS (
    SELECT id_venta, SUM(subtotal) AS total
    FROM detalle_venta
    GROUP BY id_venta
)
SELECT tt.nombre AS tipo_tienda,
       COUNT(DISTINCT t.id_tienda) AS cantidad_tiendas,
       COUNT(v.id_venta) AS cantidad_ventas,
       NVL(SUM(tv.total), 0) AS monto_facturado
FROM tipo_tienda tt
LEFT JOIN tienda t ON t.id_tipo_tienda = tt.id_tipo_tienda
LEFT JOIN venta v ON v.id_tienda = t.id_tienda
 AND v.id_estado_venta <> (SELECT id_estado_venta FROM estado_venta WHERE nombre = 'ANULADA')
LEFT JOIN total_venta tv ON tv.id_venta = v.id_venta
GROUP BY tt.id_tipo_tienda, tt.nombre
ORDER BY monto_facturado DESC, tt.nombre;
