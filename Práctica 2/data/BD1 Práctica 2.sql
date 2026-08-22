SELECT estudiante.carne AS carne_estudiante,
       estudiante.nombre_completo AS nombre_estudiante,
       empresa.nombre AS nombre_empresa,
       plaza.especialidad_tecnica AS especialidad_plaza
FROM estudiante
JOIN colocacion
  ON colocacion.id_estudiante = estudiante.carne
JOIN plaza
  ON plaza.id_plaza = colocacion.id_plaza
JOIN empresa
  ON empresa.id_empresa = plaza.id_empresa
JOIN estado_colocacion
  ON estado_colocacion.id_estado = colocacion.id_estado
WHERE estado_colocacion.nombre = 'Activa'
ORDER BY estudiante.carne;


SELECT empresa.nombre AS nombre_empresa,
       COUNT(plaza.id_plaza) AS cantidad_total_plazas
FROM empresa
LEFT JOIN plaza
  ON plaza.id_empresa = empresa.id_empresa
GROUP BY empresa.id_empresa, empresa.nombre
ORDER BY cantidad_total_plazas DESC, empresa.nombre;


SELECT contacto_empresarial.nombre AS nombre_contacto,
       empresa.nombre AS nombre_empresa,
       SUM(bitacora.horas_trabajadas) AS total_horas_validadas
FROM contacto_empresarial
JOIN empresa
  ON empresa.id_empresa = contacto_empresarial.id_empresa
JOIN bitacora
  ON bitacora.id_contacto_validador = contacto_empresarial.id_contacto
WHERE bitacora.fecha >= DATE '2026-07-01'
  AND bitacora.fecha <  DATE '2026-09-01'
GROUP BY contacto_empresarial.id_contacto,
         contacto_empresarial.nombre,
         empresa.id_empresa,
         empresa.nombre
ORDER BY total_horas_validadas DESC,
         contacto_empresarial.nombre;


SELECT estudiante.nombre_completo AS nombre_estudiante,
       instituto.nombre AS nombre_instituto,
       contacto_empresarial.nombre AS nombre_contacto,
       estado_colocacion.nombre AS estado_actual_colocacion
FROM estudiante
JOIN instituto
  ON instituto.id_instituto = estudiante.id_instituto
JOIN colocacion
  ON colocacion.id_estudiante = estudiante.carne
JOIN estado_colocacion
  ON estado_colocacion.id_estado = colocacion.id_estado
JOIN plaza
  ON plaza.id_plaza = colocacion.id_plaza
JOIN contacto_empresarial
  ON contacto_empresarial.id_contacto = plaza.id_contacto
WHERE estudiante.es_repitencia = 1
ORDER BY estudiante.nombre_completo;


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


