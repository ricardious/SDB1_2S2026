-- Consulta 6: facturacion por categoria y marca; excluye anuladas.
SELECT c.nombre AS categoria,
       m.nombre AS marca,
       SUM(dv.cantidad) AS unidades_vendidas,
       SUM(dv.subtotal) AS total_facturado
FROM detalle_venta dv
JOIN venta v ON v.id_venta = dv.id_venta
JOIN estado_venta ev ON ev.id_estado_venta = v.id_estado_venta
JOIN producto p ON p.id_producto = dv.id_producto
JOIN categoria c ON c.id_categoria = p.id_categoria
JOIN marca m ON m.id_marca = p.id_marca
WHERE ev.nombre <> 'ANULADA'
GROUP BY c.id_categoria, c.nombre, m.id_marca, m.nombre
ORDER BY total_facturado DESC, unidades_vendidas DESC, c.nombre, m.nombre;
