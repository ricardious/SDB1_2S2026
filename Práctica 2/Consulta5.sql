-- Universidad de San Carlos de Guatemala
-- Curso: Bases de Datos 1
-- Práctica 2 - Consulta 5
-- Nombre: Alex Ricardo Castañeda Rodríguez
-- Carné: 202300476
-- Sección: B
--
-- Auditoría de bitácoras.
-- Busca colocaciones activas sin bitácoras durante el último mes transcurrido.

SELECT colocacion.id_colocacion AS numero_colocacion,
       estudiante.nombre_completo AS nombre_estudiante,
       catedratico.nombre AS nombre_catedratico_supervisor,
       estado_colocacion.nombre AS estado_actual
FROM colocacion
JOIN estudiante
  ON estudiante.carne = colocacion.id_estudiante
JOIN catedratico
  ON catedratico.id_catedratico = colocacion.id_catedratico
JOIN estado_colocacion
  ON estado_colocacion.id_estado = colocacion.id_estado
LEFT JOIN bitacora
  ON bitacora.id_colocacion = colocacion.id_colocacion
 AND bitacora.fecha >= ADD_MONTHS(TRUNC(SYSDATE), -1)
WHERE estado_colocacion.nombre = 'Activa'
GROUP BY colocacion.id_colocacion,
         estudiante.nombre_completo,
         catedratico.nombre,
         estado_colocacion.nombre
HAVING COUNT(bitacora.id_bitacora) = 0
ORDER BY colocacion.id_colocacion;
