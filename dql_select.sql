
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