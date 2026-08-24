-- Universidad de San Carlos de Guatemala
-- Curso: Bases de Datos 1
-- Práctica 2 - Consulta 3
-- Nombre: Alex Ricardo Castañeda Rodríguez
-- Carné: 202300476
-- Sección: B
--
-- Carga de validación por contacto empresarial.
-- Suma las horas validadas durante julio y agosto de 2026.

SELECT contacto_empresarial.nombre AS nombre_contacto,
       empresa.nombre AS nombre_empresa,
       SUM(bitacora.horas_trabajadas) AS total_horas_validadas
FROM contacto_empresarial
JOIN empresa
  ON empresa.id_empresa = contacto_empresarial.id_empresa
JOIN bitacora
  ON bitacora.id_contacto_validador = contacto_empresarial.id_contacto
WHERE bitacora.fecha >= DATE '2026-07-01'
  AND bitacora.fecha < DATE '2026-09-01'
GROUP BY contacto_empresarial.id_contacto,
         contacto_empresarial.nombre,
         empresa.id_empresa,
         empresa.nombre
ORDER BY total_horas_validadas DESC,
         contacto_empresarial.nombre;
