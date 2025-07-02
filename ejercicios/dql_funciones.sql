
USE examen_mysql;

-- Crea una función llamada `fn_total_clientes_municipio(municipio_id INT)` que retorne el número de clientes en ese municipio.

DELIMITER //

DROP FUNCTION IF EXISTS fn_total_clientes_municipio;    
CREATE FUNCTION fn_total_clientes_municipio(municipio_id INT)
RETURNS INT
DETERMINISTIC
BEGIN 
    DECLARE _total INT;

    SELECT COUNT(cliente_id) INTO _total
    FROM clientes 
    WHERE municipioid = municipio_id;

    RETURN _total;

END //

DELIMITER ;

SELECT fn_total_clientes_municipio(1) AS TOTAL;



-- Crea una función llamada `fn_nombre_municipio(cliente_id INT)` que retorne el nombre del municipio de residencia del cliente.

DELIMITER // 

DROP FUNCTION IF EXISTS fn_nombre_municipio;
CREATE FUNCTION fn_nombre_municipio(p_cliente_id INT)
RETURNS VARCHAR(80)
DETERMINISTIC
BEGIN 
    DECLARE _municipio_id INT;
    DECLARE _mun_nombre VARCHAR(80);

    SELECT municipioid INTO _municipio_id
    FROM clientes
    WHERE cliente_id = p_cliente_id;

    SELECT nombre INTO _mun_nombre
    FROM municipio 
    WHERE id = _municipio_id;

    RETURN _mun_nombre;

END //

DELIMITER ;

SELECT fn_nombre_municipio(1);


-- Crea una función llamada `fn_salario_promedio_sucursal(sucursal_id INT)` que retorne el promedio salarial de los empleados de la sucursal.

DELIMITER //

DROP FUNCTION IF EXISTS fn_salario_promedio_sucursal;
CREATE FUNCTION fn_salario_promedio_sucursal(sucursal_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE _promedio DECIMAL(10,2);

    SELECT AVG(salario) INTO _promedio
    FROM empleados
    WHERE sucursalid = sucursal_id;

    RETURN _promedio;
END //

DELIMITER ;

SELECT fn_salario_promedio_sucursal(1);


-- Crea una función llamada `fn_municipio_por_nombre_cliente(nombre_cliente VARCHAR)` que retorne el nombre del municipio del cliente según su nombre (puede haber duplicados).

DELIMITER //

DROP FUNCTION IF EXISTS fn_municipio_por_nombre_cliente;
CREATE FUNCTION fn_municipio_por_nombre_cliente(nombre_cliente VARCHAR(80))
RETURNS VARCHAR(80)
DETERMINISTIC
BEGIN 
    DECLARE _municipio_id INT;
    DECLARE _mun_nombre VARCHAR(80);

    SELECT municipioid INTO _municipio_id
    FROM clientes
    WHERE nombre = nombre_cliente
    LIMIT 1;

    SELECT nombre INTO _mun_nombre
    FROM municipio 
    WHERE id = _municipio_id
    LIMIT 1;

    RETURN _mun_nombre;

END //

DELIMITER ;

SELECT fn_municipio_por_nombre_cliente('Valentina Mendoza');


