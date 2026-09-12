-- Consulta 1: ventas por tienda y ubicacion; excluye ventas anuladas.
WITH total_venta AS (
    SELECT id_venta, SUM(subtotal) AS total
    FROM detalle_venta
    GROUP BY id_venta
)
SELECT t.nombre AS tienda,
       m.nombre AS municipio,
       d.nombre AS departamento,
       p.nombre AS pais,
       COUNT(v.id_venta) AS cantidad_ventas,
       NVL(SUM(tv.total), 0) AS total_facturado
FROM tienda t
JOIN municipio m ON m.id_municipio = t.id_municipio
JOIN departamento d ON d.id_departamento = m.id_departamento
JOIN pais p ON p.id_pais = d.id_pais
LEFT JOIN venta v ON v.id_tienda = t.id_tienda
 AND v.id_estado_venta <> (SELECT id_estado_venta FROM estado_venta WHERE nombre = 'ANULADA')
LEFT JOIN total_venta tv ON tv.id_venta = v.id_venta
GROUP BY t.id_tienda, t.nombre, m.nombre, d.nombre, p.nombre
ORDER BY total_facturado DESC, t.nombre;
