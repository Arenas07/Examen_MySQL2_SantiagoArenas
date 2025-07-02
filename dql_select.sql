
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
ORDER BY e.puesto DESC;

-- Mostrar el total de empleados por municipio y el nombre del departamento al que pertenecen.

SELECT dep.nombre, mun.nombre, COUNT(e.empleado_id) AS total_empleados
FROM empleados e
INNER JOIN sucursal suc ON suc.id = e.sucursalid
INNER JOIN municipio mun ON mun.id = suc.municipioid
INNER JOIN departamento dep ON dep.id = mun.depid
GROUP BY dep.nombre, mun.nombre;

-- Mostrar todos los municipios con sucursales activas (que tengan al menos un empleado).

SELECT mun.nombre
FROM municipio mun
INNER JOIN sucursal suc ON mun.id = suc.municipioid 
INNER JOIN empleados e ON  suc.id = e.sucursalid
GROUP BY mun.nombre
HAVING COUNT(e.empleado_id) >= 1;