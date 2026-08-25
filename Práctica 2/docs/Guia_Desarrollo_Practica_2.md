# Práctica 2 — Guía de desarrollo

## Fuente de verdad utilizada

Esta guía está alineada con:

- El enunciado de la práctica contenido en `Enunciado_Oficial_Practica_2.md`.
- Las 16 hojas y columnas reales de `data/Dataset_Practica2.xlsx`.
- El modelo lógico y relacional adaptado de la Práctica 1.
- El DDL actualizado `Practica2.ddl`.

La práctica requiere **Oracle Database XE o superior** y **Oracle SQL Developer**.

> No utilices `Práctica 1/MODELO_RELACIONAL_EPS.ddl`: ese archivo es la versión antigua de 11 tablas. El DDL correcto es `Práctica 2/Practica2.ddl` y crea 16 tablas.

---

## 1. Preparar el ambiente de trabajo

### 1.1 Requisitos

- Oracle Database XE o superior.
- Oracle SQL Developer.
- `data/Dataset_Practica2.xlsx`.
- El modelo físico implementado y el DDL actualizado `Practica2.ddl`.

### 1.2 Conectarse al esquema de trabajo

Abre SQL Developer y utiliza el esquema personal donde implementarás el modelo. No ejecutes las tablas de la práctica dentro del esquema administrativo `SYSTEM`.

Verifica el usuario de la sesión:

```sql
SELECT USER AS usuario
FROM dual;
```

📸 **Captura recomendada 1:** resultado de `SELECT USER`, mostrando únicamente el
nombre del esquema. Oculta la contraseña y cualquier dato sensible de la conexión.

Antes de ejecutar el DDL, confirma que el esquema no contenga una implementación anterior:

```sql
SELECT COUNT(*) AS total_tablas
FROM user_tables;
```

Si ya existen tablas de una versión anterior, utiliza un esquema limpio para evitar conflictos de nombres y restricciones.

---

## 2. Crear las 16 tablas

1. Abre `Practica2.ddl` en SQL Developer.
2. Selecciona la conexión `BD1 Práctica 2`.
3. Ejecútalo como script con **F5**.
4. Revisa el panel **Script Output** y confirma que no existan errores `ORA-`.

📸 **Captura recomendada 2:** parte final de **Script Output**, donde se observe que
el DDL terminó sin errores `ORA-`. No es necesario capturar las 16 sentencias
`CREATE TABLE` por separado.

El script utiliza tipos y restricciones compatibles con Oracle (`NUMBER`, `VARCHAR2`, `DATE`, PK, UK y FK).

No vuelvas a ejecutar el DDL sobre el mismo esquema: produciría `ORA-00955` porque las tablas ya existirían.

### 2.1 Verificar tablas

```sql
SELECT table_name
FROM user_tables
ORDER BY table_name;
```

Deben aparecer exactamente estas 16 tablas:

```text
BITACORA
CATEDRATICO
COLOCACION
CONTACTO_EMPRESARIAL
CRITERIO
DEPARTAMENTO
DETALLE_EVALUACION
EMPRESA
ESTADO_COLOCACION
ESTUDIANTE
EVALUACION
INSTITUTO
MUNICIPIO
PLAZA
SECTOR_ECONOMICO
TIPO_EVALUACION
```

Verifica el total:

```sql
SELECT COUNT(*) AS total_tablas
FROM user_tables;
```

Resultado esperado: `16`.

📸 **Captura recomendada 3:** resultado de la consulta a `USER_TABLES`, procurando
que se vean los nombres de las 16 tablas o, como mínimo, el conteo total igual a 16.

### 2.2 Verificar restricciones

```sql
SELECT constraint_type, COUNT(*) AS cantidad
FROM user_constraints
WHERE constraint_type IN ('P', 'R', 'U')
GROUP BY constraint_type
ORDER BY constraint_type;
```

Resultados esperados:

| Tipo | Significado | Cantidad |
|---|---|---:|
| `P` | Primary Key | 16 |
| `R` | Foreign Key | 19 |
| `U` | Unique | 7 |

📸 **Captura recomendada 4:** resultado de la consulta de restricciones mostrando
los tres conteos: `P = 16`, `R = 19` y `U = 7`.

---

## 3. Importar `data/Dataset_Practica2.xlsx`

La carga debe realizarse de padres a hijos para respetar las llaves foráneas.

### 3.1 Orden correcto y conteos esperados

| Orden | Hoja/tabla | Depende de | Filas esperadas |
|---:|---|---|---:|
| 1 | `SECTOR_ECONOMICO` | — | 5 |
| 2 | `DEPARTAMENTO` | — | 4 |
| 3 | `ESTADO_COLOCACION` | — | 3 |
| 4 | `TIPO_EVALUACION` | — | 2 |
| 5 | `CRITERIO` | — | 5 |
| 6 | `INSTITUTO` | — | 3 |
| 7 | `MUNICIPIO` | DEPARTAMENTO | 8 |
| 8 | `EMPRESA` | SECTOR_ECONOMICO | 5 |
| 9 | `CATEDRATICO` | INSTITUTO | 5 |
| 10 | `CONTACTO_EMPRESARIAL` | EMPRESA | 7 |
| 11 | `ESTUDIANTE` | MUNICIPIO, INSTITUTO | 7 |
| 12 | `PLAZA` | EMPRESA, CONTACTO_EMPRESARIAL | 7 |
| 13 | `COLOCACION` | ESTUDIANTE, PLAZA, CATEDRATICO, ESTADO_COLOCACION | 7 |
| 14 | `BITACORA` | COLOCACION, CONTACTO_EMPRESARIAL | 9 |
| 15 | `EVALUACION` | COLOCACION, CATEDRATICO, TIPO_EVALUACION | 4 |
| 16 | `DETALLE_EVALUACION` | EVALUACION, CRITERIO | 17 |

Justificación para el manual: una fila hija no puede insertarse hasta que existan todas las filas padre referidas por sus FK. Por ejemplo, `COLOCACION` requiere que ya existan el estudiante, la plaza, el catedrático y el estado.

### 3.2 Procedimiento por cada hoja

1. En **Connections**, busca la tabla correspondiente.
2. Clic derecho sobre la tabla → **Import Data**.
3. Selecciona `data/Dataset_Practica2.xlsx` y la hoja que tenga el mismo nombre de la tabla.
4. Indica que la primera fila contiene encabezados.
5. Revisa que cada encabezado quede asociado a la columna del mismo nombre.
6. Comprueba especialmente:
   - Fechas → columnas `DATE`.
   - `CARNE` e identificadores → columnas `NUMBER`.
   - Teléfonos e identificación del catedrático → `VARCHAR2` sin notación científica.
   - `ES_REPITENCIA` → `NUMBER(1)` con valores `0` o `1`.
7. Ejecuta la importación.
8. Confirma filas importadas y errores `0`.
9. Ejecuta `COMMIT;` si el asistente no confirmó automáticamente la transacción.

📸 **Captura recomendada 5:** durante la importación de la primera tabla
(`SECTOR_ECONOMICO`), muestra la hoja seleccionada y el mapeo entre los encabezados
del Excel y las columnas de Oracle. Esta captura documenta cómo se utilizó el
asistente; no hace falta repetir el mapeo para las 16 tablas.

📸 **Captura recomendada 6:** resumen exitoso de una importación donde se observen
las filas procesadas y `0` errores. Si alguna tabla requirió una configuración
especial —por ejemplo, una fecha— conviene capturar también ese caso.

> Aunque cada hoja contiene pocos registros reales, el libro puede mostrar filas vacías
> con formato aplicado. Antes de finalizar cada importación, verifica que el asistente
> únicamente incluya las filas con datos y que el total coincida con la tabla de conteos
> esperados de la sección 3.1.

Si tu versión del asistente no permite seleccionar hojas de un mismo libro, guarda cada hoja como CSV UTF-8 y conserva exactamente sus encabezados.

### 3.3 Verificación completa de filas

Ejecuta este reporte después de importar todo:

```sql
SELECT 'SECTOR_ECONOMICO' AS tabla, COUNT(*) AS filas FROM sector_economico
UNION ALL SELECT 'DEPARTAMENTO', COUNT(*) FROM departamento
UNION ALL SELECT 'MUNICIPIO', COUNT(*) FROM municipio
UNION ALL SELECT 'ESTADO_COLOCACION', COUNT(*) FROM estado_colocacion
UNION ALL SELECT 'TIPO_EVALUACION', COUNT(*) FROM tipo_evaluacion
UNION ALL SELECT 'CRITERIO', COUNT(*) FROM criterio
UNION ALL SELECT 'EMPRESA', COUNT(*) FROM empresa
UNION ALL SELECT 'CONTACTO_EMPRESARIAL', COUNT(*) FROM contacto_empresarial
UNION ALL SELECT 'PLAZA', COUNT(*) FROM plaza
UNION ALL SELECT 'INSTITUTO', COUNT(*) FROM instituto
UNION ALL SELECT 'CATEDRATICO', COUNT(*) FROM catedratico
UNION ALL SELECT 'ESTUDIANTE', COUNT(*) FROM estudiante
UNION ALL SELECT 'COLOCACION', COUNT(*) FROM colocacion
UNION ALL SELECT 'BITACORA', COUNT(*) FROM bitacora
UNION ALL SELECT 'EVALUACION', COUNT(*) FROM evaluacion
UNION ALL SELECT 'DETALLE_EVALUACION', COUNT(*) FROM detalle_evaluacion
ORDER BY 1;
```

Guarda una captura del resultado para el manual.

📸 **Captura recomendada 7:** resultado completo de esta consulta, con los conteos
de las 16 tablas visibles. Esta es la evidencia principal de que la carga terminó.

---

## 4. Crear y probar las cinco consultas

Cada consulta debe guardarse en un archivo independiente y ejecutarse dentro del esquema donde se cargaron las 16 tablas.

### Consulta 1 — Directorio de estudiantes activos

```sql
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
```

Lectura paso a paso:

1. `ESTUDIANTE` proporciona el carné y el nombre completo.
2. `COLOCACION` relaciona al estudiante con la plaza y con su estado actual.
3. `PLAZA` proporciona la especialidad técnica y permite localizar la empresa.
4. `EMPRESA` proporciona el nombre de la empresa.
5. `ESTADO_COLOCACION` permite conservar únicamente las colocaciones cuyo nombre es `Activa`.

📸 **Captura obligatoria 8:** código ejecutado y cuadrícula de resultados de la
Consulta 1. Deben verse las cuatro columnas solicitadas y únicamente colocaciones
activas.

### Consulta 2 — Oferta de plazas por empresa

```sql
SELECT empresa.nombre AS nombre_empresa,
       COUNT(plaza.id_plaza) AS cantidad_total_plazas
FROM empresa
LEFT JOIN plaza
  ON plaza.id_empresa = empresa.id_empresa
GROUP BY empresa.id_empresa, empresa.nombre
ORDER BY cantidad_total_plazas DESC, empresa.nombre;
```

Lectura paso a paso:

1. `EMPRESA` proporciona el nombre de cada empresa afiliada.
2. `LEFT JOIN` relaciona sus plazas y también conserva empresas que no tengan ninguna.
3. `COUNT(plaza.id_plaza)` cuenta cuántas plazas tiene cada empresa.
4. `GROUP BY` forma un grupo por empresa para calcular un conteo independiente.
5. `ORDER BY ... DESC` muestra primero las empresas con más plazas.

📸 **Captura obligatoria 9:** código ejecutado y resultado de la Consulta 2,
mostrando empresa y total de plazas en orden descendente.

### Consulta 3 — Carga de validación por contacto empresarial

El dataset no contiene `FECHA_VALIDACION`. El rango se aplica correctamente sobre `BITACORA.FECHA`.

```sql
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
```

Lectura paso a paso:

1. `CONTACTO_EMPRESARIAL` proporciona el nombre del contacto que validó las bitácoras.
2. `EMPRESA` permite mostrar la empresa a la que pertenece el contacto.
3. `BITACORA` proporciona la fecha y las horas trabajadas que fueron validadas.
4. `WHERE` incluye desde el 1 de julio y excluye el 1 de septiembre; así cubre julio y agosto completos.
5. `SUM` suma las horas correspondientes a cada contacto.
6. `GROUP BY` genera un total independiente por contacto y empresa.

El límite superior exclusivo evita problemas si las fechas contienen una hora además del día.

📸 **Captura obligatoria 10:** código ejecutado y resultado de la Consulta 3. Deben
verse contacto, empresa y total de horas validadas para julio-agosto de 2026.

### Consulta 4 — Estudiantes en repitencia

```sql
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
```

Lectura paso a paso:

1. `ESTUDIANTE` proporciona el nombre y el indicador `ES_REPITENCIA`.
2. `INSTITUTO` proporciona el instituto del que proviene el estudiante.
3. `COLOCACION` permite conocer su plaza y el estado de su colocación.
4. `ESTADO_COLOCACION` proporciona el nombre del estado actual.
5. `PLAZA` permite encontrar al contacto empresarial asignado.
6. `CONTACTO_EMPRESARIAL` proporciona el nombre de ese contacto.
7. `WHERE estudiante.es_repitencia = 1` conserva únicamente a los repitentes.

El contacto se obtiene desde la plaza asignada y no desde `BITACORA`. Esto incluye a
los estudiantes en repitencia aunque todavía no tengan entradas de bitácora. Con el
dataset proporcionado debe aparecer Pedro Samayoa, cuyo contacto empresarial es Jorge
Cifuentes y cuya colocación está finalizada.

📸 **Captura obligatoria 11:** código ejecutado y resultado de la Consulta 4. Con el
dataset proporcionado debe verse la fila de Pedro Samayoa.

### Consulta 5 — Auditoría de bitácoras

Esta versión interpreta “último mes” como el mes transcurrido hacia atrás desde la fecha de ejecución.

El resultado depende de `SYSDATE`; por ello, la captura del manual debe indicar la
fecha en que se ejecutó la consulta.

```sql
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
```

Lectura paso a paso:

1. `COLOCACION` es la tabla principal del reporte.
2. `ESTUDIANTE` permite mostrar quién ocupa la colocación.
3. `CATEDRATICO` proporciona el supervisor responsable.
4. `ESTADO_COLOCACION` permite conservar únicamente las colocaciones activas.
5. `LEFT JOIN BITACORA` busca bitácoras recientes sin eliminar las colocaciones que no tengan ninguna.
6. La condición ubicada dentro del `LEFT JOIN` considera solamente registros del último mes.
7. `GROUP BY` forma un grupo por colocación.
8. `HAVING COUNT(bitacora.id_bitacora) = 0` conserva los grupos que no tienen ninguna bitácora reciente.

Si el auxiliar define “último mes” como mes calendario actual, reemplaza la condición por:

```sql
bitacora.fecha >= TRUNC(SYSDATE, 'MM')
```

📸 **Captura obligatoria 12:** código ejecutado y resultado de la Consulta 5. Incluye
en el texto del manual la fecha de ejecución y la interpretación utilizada para
“último mes”. Si la consulta no devuelve filas, captura igualmente la cuadrícula
vacía y explica que no se encontraron colocaciones que cumplieran la condición.

---

## 5. Guardar los scripts

Crea exactamente estos archivos:

```text
Consulta1.sql
Consulta2.sql
Consulta3.sql
Consulta4.sql
Consulta5.sql
```

Cada archivo debe incluir nombre, carné, curso, sección y una descripción breve en comentarios. No incluyas dos variantes de una consulta en el mismo archivo final.

---

## 6. Elaborar `Manual.pdf`

Estructura recomendada:

1. Portada: universidad, curso, práctica, nombre, carné, sección y fecha.
2. Objetivo de la práctica.
3. Ambiente utilizado: Oracle Database XE o superior y Oracle SQL Developer.
4. Creación de las 16 tablas mediante `Practica2.ddl`.
5. Orden de importación con explicación de integridad referencial.
6. Capturas del asistente de importación: archivo/hoja, mapeo y resultado sin errores.
7. Captura del conteo de las 16 tablas.
8. Para cada consulta: requerimiento, código, explicación de joins/filtros/agrupación y captura del resultado.
9. Conclusiones.

No muestres contraseñas en las capturas.

### 6.1 Plan exacto de capturas

El enunciado exige expresamente capturas de los resultados de las cinco consultas.
Por tanto, las capturas **8 a 12 son obligatorias**. Las capturas **1 a 7 son
recomendadas** para demostrar el procedimiento de creación e importación solicitado
en el manual.

| N.º | Momento de la captura | Qué debe verse | Carácter |
|---:|---|---|---|
| 1 | Después de `SELECT USER` | Nombre del esquema personal | Recomendada |
| 2 | Después de ejecutar el DDL con F5 | Final de Script Output sin errores `ORA-` | Recomendada |
| 3 | Después de consultar `USER_TABLES` | Las 16 tablas o el total 16 | Recomendada |
| 4 | Después de consultar restricciones | `P = 16`, `R = 19`, `U = 7` | Recomendada |
| 5 | Primera importación | Hoja y mapeo Excel → Oracle | Recomendada |
| 6 | Al terminar una importación | Filas procesadas y 0 errores | Recomendada |
| 7 | Al terminar toda la carga | Conteos de las 16 tablas | Recomendada |
| 8 | Ejecutar Consulta 1 | SQL y resultado | **Obligatoria** |
| 9 | Ejecutar Consulta 2 | SQL y resultado | **Obligatoria** |
| 10 | Ejecutar Consulta 3 | SQL y resultado | **Obligatoria** |
| 11 | Ejecutar Consulta 4 | SQL y resultado | **Obligatoria** |
| 12 | Ejecutar Consulta 5 | SQL, resultado y fecha de ejecución | **Obligatoria** |

Para cada consulta, procura que una sola captura muestre simultáneamente la sentencia
SQL y la cuadrícula de resultados. Si no caben de forma legible, utiliza dos capturas:
una para el código y otra para el resultado. Recorta ventanas ajenas a SQL Developer,
pero conserva suficiente contexto para identificar la consulta ejecutada.

---

## 7. Preparación para evaluación oral y ejercicio en vivo

Debes poder explicar:

- Orden lógico: `FROM/JOIN → WHERE → GROUP BY → HAVING → SELECT → ORDER BY`.
- Diferencia entre `WHERE` y `HAVING`.
- `INNER JOIN` frente a `LEFT JOIN`.
- Funciones `COUNT`, `SUM`, `AVG`, `MIN` y `MAX`.
- Tratamiento de `NULL` en agregaciones.
- Por qué se agrupan todas las columnas no agregadas del `SELECT`.
- Selección (σ), proyección (π), producto cartesiano, join, unión y diferencia.
- Por qué los catálogos se unen por ID pero se filtran o muestran por nombre.

Variantes para practicar:

```sql
-- Total de horas por estudiante
SELECT e.carne,
       e.nombre_completo,
       SUM(b.horas_trabajadas) AS total_horas
FROM estudiante e
JOIN colocacion c
  ON c.id_estudiante = e.carne
JOIN bitacora b
  ON b.id_colocacion = c.id_colocacion
GROUP BY e.carne, e.nombre_completo
ORDER BY total_horas DESC;
```

```sql
-- Cantidad de estudiantes por instituto
SELECT i.nombre AS instituto,
       COUNT(e.carne) AS total_estudiantes
FROM instituto i
LEFT JOIN estudiante e
  ON e.id_instituto = i.id_instituto
GROUP BY i.id_instituto, i.nombre
ORDER BY total_estudiantes DESC;
```

---

## 8. Empaquetar la entrega

El ZIP final debe contener únicamente:

```text
[BD1]_Practica2_#carnet.zip
├── Manual.pdf
├── Consulta1.sql
├── Consulta2.sql
├── Consulta3.sql
├── Consulta4.sql
└── Consulta5.sql
```

No incluyas el DDL, el Excel, el `.dmd`, capturas sueltas ni carpetas adicionales dentro del ZIP.

---

## Checklist final

- [ ] Trabajo realizado con un usuario propio, no con `SYSTEM`.
- [ ] `Practica2.ddl` ejecutado sin errores.
- [ ] Existen 16 tablas, 16 PK, 19 FK y 7 UK.
- [ ] Las 16 hojas fueron importadas en orden y con los conteos esperados.
- [ ] Las cinco consultas se ejecutan sin errores y usan `JOIN` explícito.
- [ ] Las consultas con agregación tienen un `GROUP BY` correcto.
- [ ] `Manual.pdf` incluye procedimiento, justificación y capturas de resultados.
- [ ] `Manual.pdf` contiene, como mínimo, las capturas obligatorias 8 a 12.
- [ ] Los cinco scripts tienen los nombres exactos solicitados.
- [ ] El ZIP contiene exactamente los seis entregables.
- [ ] Se practicaron variaciones de las consultas para la evaluación en vivo.
