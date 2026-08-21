# Enunciado oficial — Práctica 2

Universidad San Carlos de Guatemala
Facultad de ingeniería.
Ingeniería en ciencias y sistemas 

![image](https://cdn-mineru.openxlab.org.cn/result/2026-08-28/cbe5401f-988d-48f2-bfc7-599eca5ee6b1/fe890431694e1779b74c542c2c33aa29e053fe6ae2421dd63e4731b7a2f93306.jpg)


![image](https://cdn-mineru.openxlab.org.cn/result/2026-08-28/cbe5401f-988d-48f2-bfc7-599eca5ee6b1/6e48e9bc309d898aba3513c716e9dd88339fd2228c01affbd0a22dc04e9ac2ee.jpg)


![image](https://cdn-mineru.openxlab.org.cn/result/2026-08-28/cbe5401f-988d-48f2-bfc7-599eca5ee6b1/ea774cf3a3ca28cefb984143b2070a75870b0c8f08911b09249d65637fa35071.jpg)


![image](https://cdn-mineru.openxlab.org.cn/result/2026-08-28/cbe5401f-988d-48f2-bfc7-599eca5ee6b1/3dc49bbf9fa5132a4926c8d3d18bf5d3d5341ecd2f38d96369148df34927f248.jpg)


# Consultas Avanzadas, Agrupaciones y Reportería Relacional (Sistema EPS)

PONDERACIÓN: 5.35 pts 

Tiempo estimado: 15 hrs/min 

## Índice

1. MARCO FORMATIVO .... 3
1.1. Valor.... 3
1.2. Competencia(s).... 3
1.3. Habilidad(es) blandas a formar.... 3
2. Resultado del Aprendizaje .... 4
2.1. Objetivo SMART.... 4
3. Enunciado de la Práctica.... 4
3.1 Descripción del problema a resolver.... 4
3.2 Alcance de la práctica.... 5
3.3 Guía Recomendada para la Importación de Datos.... 5
3.4 Requerimientos técnicos.... 6
4. Entregables.... 6
5. Material de apoyo.... 7
6. Recursos y herramientas a utilizar.... 7
7. Cronograma.... 7
8. Rúbrica de Calificación.... 8
8.1 Requisitos para optar a la calificación.... 8
8.2 Resumen de Puntuaciones.... 9
Detalle de la Calificación.... 10
Comentarios Generales.... 11 

## 1. MARCO FORMATIVO

## 1.1. Valor

<table><tr><td>Nombre del valor</td><td>¿Cómo se aplica en tu laboratorio?</td></tr><tr><td>Integridad académica</td><td>El estudiante debe construir sus propias sentencias SQL y realizar la carga de datos de forma individual, sin copiar soluciones de otros compañeros ni compartir sus consultas, ya que forma parte esencial de su criterio y lógica profesional.</td></tr></table>

## 1.2. Competencia(s)

Con la elaboración de esta práctica usted adquirirá la siguiente competencia: 

Implementa y explota bases de datos relacionales mediante la carga de datos transacciones y el desarrollo de consultas avanzadas en SQL (utilizando funciones de agregación, agrupaciones y uniones múltiples), capaces de resolver requerimientos analíticos del ámbito educativo. 

## 1.3. Habilidad(es) blandas a formar

La práctica le permitirá desarrollar las siguientes habilidades: 

Pensamiento analítico y resolución de problemas: capacidad de leer un requerimiento de negocio o reporte solicitado y transformarlo en una sentencia SQL eficiente que extraiga la información exacta requerida. 

## 2. Resultado del Aprendizaje

## 2.1. Objetivo SMART

Define el/los objetivo(s) que se pretende cumplir con la práctica planteada, con un enfoque SMART, tomando en consideración que un objetivo SMART va enfocado a la habilidad (y no tanto a la teoría). 

<table><tr><td>Específico(¿Qué?)</td><td>Medible(¿Cuánto?)</td><td>Alcanzable(¿Cómo?)</td><td>Realista (¿Para qué?)</td><td>A Tiempo(¿Cuándo?)</td></tr><tr><td>Importar datos estructurados (CSV/Excel) al modelo físico y desarrollar 5 consultas SQL relacionales para el Sistema de Gestión de Prácticas Profesionales Supervisadas (EPS).</td><td>Entregando un manual de carga de datos detallado y 5 scripts SQL funcionales que generen los reportes solicitados.</td><td>Utilizando Oracle SQL Developer para la importación y aplicando comandos DQL (JOIN, GROUP BY, funciones de agregación) aprendidos en clase.</td><td>Para adquirir la habilidad técnica de poblar bases de datos y transformar datos crudos en información analítica valiosa para la toma de decisiones empresariales.</td><td>Durante el plazo de elaboración establecido en el cronograma de la práctica.</td></tr></table>

## 3. Enunciado de la Práctica

Esta sección define de manera clara y detallada los aspectos específicos que los estudiantes deberán abordar en la práctica. Se incluye el problema a resolver, el alcance, y los entregables esperados. 

## 3.1 Descripción del problema a resolver

En base al modelo relacional construido e implementado durante la Práctica 1 para el control del programa de Prácticas Profesionales Supervisadas (EPS), la Dirección Académica requiere realizar una auditoría operativa. 

Para ello, se le proporcionará un conjunto de datos en formato Excel/CSV que representa las transacciones históricas. Su primera tarea será utilizar el asistente de importación para poblar todas las tablas del modelo, respetando la integridad referencial. Posteriormente, al final de cada ciclo, se deben presentar los siguientes reportes estadísticos: 

1. Directorio de Estudiantes Activos: Generar un listado que muestre el carné, el nombre completo del estudiante, el nombre de la empresa donde se encuentra y la especialidad de la plaza. Este reporte debe filtrar únicamente las colocaciones que se encuentren en estado "Activa". 

2. Oferta de Plazas por Empresa: Mostrar el nombre de cada empresa afiliada junto con la cantidad total de plazas de práctica que ofrecen. El resultado debe ordenarse mostrando primero las empresas que ofrecen más plazas. 

3. Carga de Validación por Contacto Empresarial: En base a un rango de fechas (mes de julio a agosto de 2026), listar el nombre del contacto empresarial, el nombre de la empresa a la que pertenece y la suma total de horas que ha validado en las bitácoras de los estudiantes. 

4. Estudiantes en Repitencia: Listar a todos los estudiantes que se encuentran realizando su práctica en calidad de repitencia (es_repitencia = 1). Se debe mostrar el nombre del estudiante, el nombre del instituto del que proviene, el nombre del contacto empresarial que valida sus bitácoras y el estado actual de su colocación. 

5. Auditoría de Bitácoras: Mostrar un listado de las colocaciones que están en estado "Activa", pero que no tienen ningún registro en la tabla de bitácoras durante el último mes, evidenciando el nombre del catedrático supervisor responsable para su respectivo llamado de atención. 

## 3.2 Alcance de la práctica

Establece los límites de la práctica para que los estudiantes sepan hasta dónde deben llegar. Esto incluye las funcionalidades esenciales que deben desarrollarse, como también las que son opcionales o recomendadas. 

- La práctica abarca la importación de datos hacia Oracle respetando las restricciones de llaves primarias y foráneas. 

- Es obligatorio el uso de sentencias explícitas de JOIN y cláusulas GROUP BY para las consultas. 

- El alcance se limita únicamente a los 5 reportes descritos. 

## 3.3 Guía Recomendada para la Importación de Datos

Para garantizar el éxito en la carga inicial de información y evitar violaciones de Integridad Referencial (restricciones de llaves foráneas), se sugiere aplicar el siguiente orden secuencial utilizando el asistente de importación de Oracle SQL Developer: 

• SECTOR_ECONOMICO 

- DEPARTAMENTO 

• ESTADO_COLOCACION 

- TIPO_EVALUACION 

- CRITERIO 

- INSTITUTO 

• MUNICIPIO (Depende de Departamento) 

• EMPRESA (Depende de Sector) 

• CATEDRATICO (Depende de Instituto) 

- CONTACTO_EMPRESARIAL (Depende de Empresa) 

- ESTUDIANTE 

• COLOCACION (Depende de Estudiante, Plaza, Catedrático y Estado) 

• BITACORA (Depende de Colocación y Contacto) 

- EVALUACION (Depende de Colocación, Catedrático y Tipo) 

• DETALLE_EVALUACION 

## 3.4 Requerimientos técnicos

Define las tecnologías, herramientas o lenguajes de programación que los estudiantes deberán utilizar o integrar en el desarrollo de la práctica. 

- Software/Herramientas: Oracle SQL Developer y Motor Oracle Database. 

- Lenguaje: Sentencias DQL (Data Query Language) estándar compatibles con Oracle. 

## 4. Entregables

Describe los productos concretos que se espera que los estudiantes entreguen al finalizar la práctica. Pueden ser prototipos, informes técnicos, documentación, etc. 

<table><tr><td>Tipo</td><td>Descripción</td></tr><tr><td>Manual de Carga</td><td>Documento que describe paso a paso cómo se realizó la importación de los archivos Excel/CSV hacia Oracle SQL Developer, explicando el orden jerárquico utilizado para evitar errores de integridad referencial. Este deberá incluir también capturas de los resultados obtenidos de las consultas solicitadas.Formato PDF: Manual.pdf</td></tr><tr><td>Scripts de Consultas</td><td>Creación de un script por cada consulta solicitada (5 scripts en total), garantizando que se ejecuten correctamente.Formatos SQL: Consulta1.sql, Consulta2.sql, Consulta3.sql, Consulta4.sql, Consulta5.sql.</td></tr></table>

- Todos los archivos deben ir dentro de una carpeta comprimida con el formato: [BD1]_Practica2_#carnet.zip. Ejemplo: [BD1]_Practica2_201709196.zip 

## 5. Material de apoyo

- Documentación oficial de Oracle SQL Data Modeler. 

- Guía institucional de modelado Entidad-Relación (material del curso). 

- Guía de normalización de bases de datos hasta 3FN (material del curso). 

- Guía de consultas de bases de datos relacionales (material del curso). 

## 6. Recursos y herramientas a utilizar

Listado de materiales que los estudiantes deberán usar o investigar: 

- Software/Hardware: Oracle SQL Data Modeler, Oracle Database (XE o superior), computadora con al menos 4 GB de RAM disponibles. 

- Plataformas: UEDI (para entrega), Classroom (respaldo de entrega). 

- Lecturas recomendadas: Manual de modelado ER, guía de normalización y guía de consultas compartidos por la cátedra. 

## 7. Cronograma

<table><tr><td>Tipo</td><td>Fecha Inicio</td><td>Fecha Fin</td></tr><tr><td>Asignación de Práctica</td><td>viernes 21 de agosto de 2026</td><td>viernes 21 de agosto de 2026</td></tr><tr><td>Elaboración</td><td>viernes 21 de agosto de 2026</td><td>Jueves 27 de agosto de 2026</td></tr><tr><td>Entrega Final (UEDI / Classroom)</td><td>Jueves 27 de agosto de 2026</td><td>Jueves 27 de agosto de 2026, 23:59 PM</td></tr><tr><td>Calificación</td><td>sábado 29 de agosto de 2026</td><td>sábado 29 de agosto de 2026</td></tr></table>

## 8. Rúbrica de Calificación

## 8.1 Requisitos para optar a la calificación

Antes de la evaluación de la práctica, los estudiantes deben cumplir con los requisitos que se indiquen en esta sección. 

<table><tr><td>Tema</td><td>Descripción</td><td>Cumple (Sí/No)</td></tr><tr><td>Tecnología establecida</td><td>La importación y las consultas deben ejecutarse bajo un motor Oracle utilizando SQL Developer.</td><td></td></tr><tr><td>Gestión y entregas</td><td>Entregar la carpeta comprimida con el formato [BD1]_Practica2_#carnet.zip con todos los archivos.</td><td></td></tr><tr><td>Documentación</td><td>Incluir el Manual de Procedimiento de carga en PDF que incluya evidencia de los resultados de las consultas.</td><td></td></tr></table>

La evaluación de la práctica se realizará en función de varios criterios clave, teniendo en cuenta tanto los aspectos técnicos como las habilidades blandas demostradas a lo largo del desarrollo. 


8.2 Resumen de Puntuaciones


<table><tr><td>Área</td><td>Puntos Totales</td><td>Puntos Obtenidos</td></tr><tr><td>1. Habilidades</td><td></td><td></td></tr><tr><td>Manual de Procedimiento y Resultado de Consultas</td><td>15</td><td></td></tr><tr><td>Presentación y orden de los entregables</td><td>5</td><td></td></tr><tr><td>Pregunta teórica</td><td>5</td><td></td></tr><tr><td>Sub-Total Habilidades</td><td>25</td><td></td></tr><tr><td>2. Conocimiento</td><td></td><td></td></tr><tr><td>Importación de Datos</td><td>10</td><td></td></tr><tr><td>Consulta 1</td><td>10</td><td></td></tr><tr><td>Consulta 2</td><td>10</td><td></td></tr><tr><td>Consulta 3</td><td>10</td><td></td></tr><tr><td>Consulta 4</td><td>10</td><td></td></tr><tr><td>Consulta 5</td><td>10</td><td></td></tr><tr><td>Ejercicio práctico</td><td>15</td><td></td></tr><tr><td>Sub-Total Conocimiento</td><td>75</td><td></td></tr><tr><td>TOTAL</td><td>100</td><td></td></tr></table>

## Detalle de la Calificación

## 1. Habilidades (40 pts)

<table><tr><td>No.</td><td>Criterio de evaluación</td><td>Punteo máximo</td><td>Satisfactorio 100% - 61%</td><td>Necesita mejorar 60% - 0%</td><td>Punteo Obtenido</td></tr><tr><td>1.1</td><td>Manual de Procedimiento y Resultado de Consultas</td><td>15</td><td>El manual describe de forma clara y estructurada el procedimiento de importación, justificando el orden de carga para cuidar la integridad referencial y además incluye la evidencia de las consultas ejecutadas mostrando el resultado de estas. (Rango: 15 - 10 pts)</td><td>El manual es confuso, incompleto, o no justifica correctamente el manejo de las llaves foráneas durante la carga. No incluye evidencia de las consultas anteriormente ejecutadas en la base de datos. (Rango: 9 - 0 pts)</td><td></td></tr><tr><td>1.2</td><td>Pregunta teórica</td><td>5</td><td>El estudiante responde con seguridad y precisión los conceptos teóricos consultados por el calificador sobre el álgebra relacional o sentencias DQL. (Rango: 5 - 3 pts)</td><td>El estudiante presenta dudas graves o errores conceptuales en sus respuestas teóricas. (Rango: 2 - 0 pts)</td><td></td></tr><tr><td>1.3</td><td>Presentación y orden de los entregables</td><td>5</td><td>Los archivos entregados cumplen el formato y nomenclatura solicitados. (Rango: 5 – 3 pts)</td><td>Los archivos no cumplen el formato o nomenclatura solicitados. (Rango: 2 – 0 pts)</td><td></td></tr></table>

## 2. Conocimiento (60 pts)

<table><tr><td>No.</td><td>Criterio de evaluación</td><td>Punteo máximo</td><td>Satisfactorio 100% - 61%</td><td>Necesita mejorar 60% - 0%</td><td>Punteo Obtenido</td></tr><tr><td>2.1</td><td>Importación de Datos</td><td>10</td><td>La importación de datos se ha finalizado completamente respetando el orden de registro. (Rango: 10 – 6 pts)</td><td>No ha sido posible la carga completa de datos debido a incongruencias con la estructura de la base de datos (no se adaptó a los registros) o tuvo complicaciones al ingresarlas debido a la regla de llaves primarias y foráneas. (Rango: 5 – 0 pts)</td><td></td></tr><tr><td>2.2</td><td>Consultas (1-5)</td><td>50</td><td>El script de cada consulta se ejecuta correctamente utilizando las cláusulas correctas para obtener los resultados esperados. (Rango: 10 – 6 pts C/U)</td><td>El script de la consulta no presenta toda la información requerida por el negocio o está mal estructurada. (Rango: 5 – 0 pts C/U)</td><td></td></tr><tr><td>2.3</td><td>Ejercicio práctico</td><td>15</td><td>El estudiante resuelve de forma lógica, fluida y en el tiempo estipulado la modificación o nueva consulta solicitada en vivo por el auxiliar. (Rango: 15 – 10 pts)</td><td>El estudiante no logra formular la consulta solicitada en vivo o demuestra no conocer la estructura de su propio script. (Rango: 9 - 0 pts)</td><td></td></tr></table>
