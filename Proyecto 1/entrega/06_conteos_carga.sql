-- Conteos de las 19 tablas después de importar los datos.
SELECT tabla, filas FROM (
  SELECT 'pais' tabla, COUNT(*) filas FROM pais
  UNION ALL
  SELECT 'departamento' tabla, COUNT(*) filas FROM departamento
  UNION ALL
  SELECT 'municipio' tabla, COUNT(*) filas FROM municipio
  UNION ALL
  SELECT 'tipo_tienda' tabla, COUNT(*) filas FROM tipo_tienda
  UNION ALL
  SELECT 'tipo_identificacion' tabla, COUNT(*) filas FROM tipo_identificacion
  UNION ALL
  SELECT 'cargo' tabla, COUNT(*) filas FROM cargo
  UNION ALL
  SELECT 'categoria' tabla, COUNT(*) filas FROM categoria
  UNION ALL
  SELECT 'marca' tabla, COUNT(*) filas FROM marca
  UNION ALL
  SELECT 'estado_venta' tabla, COUNT(*) filas FROM estado_venta
  UNION ALL
  SELECT 'metodo_pago' tabla, COUNT(*) filas FROM metodo_pago
  UNION ALL
  SELECT 'persona' tabla, COUNT(*) filas FROM persona
  UNION ALL
  SELECT 'tienda' tabla, COUNT(*) filas FROM tienda
  UNION ALL
  SELECT 'empleado' tabla, COUNT(*) filas FROM empleado
  UNION ALL
  SELECT 'cliente' tabla, COUNT(*) filas FROM cliente
  UNION ALL
  SELECT 'producto' tabla, COUNT(*) filas FROM producto
  UNION ALL
  SELECT 'catalogo_producto' tabla, COUNT(*) filas FROM catalogo_producto
  UNION ALL
  SELECT 'venta' tabla, COUNT(*) filas FROM venta
  UNION ALL
  SELECT 'detalle_venta' tabla, COUNT(*) filas FROM detalle_venta
  UNION ALL
  SELECT 'pago' tabla, COUNT(*) filas FROM pago
) ORDER BY tabla;
