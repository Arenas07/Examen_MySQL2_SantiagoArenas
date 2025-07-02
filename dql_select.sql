
USE examen_mysql;


-- Mostrar los empleados junto al país donde laboran.

SELECT e.nombre, pa.nombre
FROM empleados e
INNER JOIN sucursal suc ON e.sucursalid = suc.id
INNER JOIN municipio mun ON mun.id = suc.municipioid
INNER JOIN departamento dep ON dep.id = mun.depid
INNER JOIN pais pa ON pa.id = dep.paisid;

-- Listar el nombre de cada cliente con su municipio, departamento y país.

SELECT cl.nombre, mun.nombre, dep.nombre, pa.nombre
FROM clientes cl
INNER JOIN municipio mun ON cl.municipioid = mun.id
INNER JOIN departamento dep ON dep.id = mun.depid
INNER JOIN pais pa ON pa.id = dep.paisid;

-- Obtener los nombres de los empleados cuyo puesto existe en más de una sucursal.

/*
SELECT suc.id, e.puesto
FROM sucursal suc
INNER JOIN empleados e ON e.sucursalid = suc.id
*/
-- CONSULTA DE PRUEBA PARA VER QUE

SELECT DISTINCT(suc.id), e.nombre, e.puesto
FROM sucursal suc
INNER JOIN empleados e ON e.sucursalid = suc.id
ORDER BY e.puesto DESC
