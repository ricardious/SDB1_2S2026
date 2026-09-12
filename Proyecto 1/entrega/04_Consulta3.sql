-- Consulta 3: productos mas vendidos; excluye ventas anuladas.
SELECT pr.id_producto AS codigo,
       pr.nombre AS producto,
       c.nombre AS categoria,
       m.nombre AS marca,
       SUM(dv.cantidad) AS unidades_vendidas,
       SUM(dv.subtotal) AS monto_generado
FROM detalle_venta dv
JOIN venta v ON v.id_venta = dv.id_venta
JOIN estado_venta ev ON ev.id_estado_venta = v.id_estado_venta
JOIN producto pr ON pr.id_producto = dv.id_producto
JOIN categoria c ON c.id_categoria = pr.id_categoria
JOIN marca m ON m.id_marca = pr.id_marca
WHERE ev.nombre <> 'ANULADA'
GROUP BY pr.id_producto, pr.nombre, c.nombre, m.nombre
ORDER BY unidades_vendidas DESC, monto_generado DESC, pr.id_producto;
