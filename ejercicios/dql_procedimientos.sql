
USE examen_mysql;

DELIMITER //

DROP PROCEDURE IF EXISTS ps_registrar_cliente_unico;
CREATE PROCEDURE ps_registrar_cliente_unico(
    IN p_nombre VARCHAR(80), 
    IN p_correo VARCHAR(50), 
    IN p_telefono VARCHAR(15), 
    IN p_direccion VARCHAR(50), 
    IN p_fecha_registro DATE, 
    IN p_municipio INT)
BEGIN
    INSERT INTO clientes (nombre, email, telefono, direccion, fecha_registro, municipioid) VALUES
    (p_nombre, p_correo, p_telefono, p_direccion, p_fecha_registro, p_municipio);

END //

DELIMITER ;

CALL ps_registrar_cliente_unico(
  'Adrian Ruiz', 
  'adrian.rddduiz@gmail.com', 
  '3123456789', 
  'Calle 123 #45-67', 
  '2025-02-01', 
  5
);

SELECT * FROM clientes WHERE cliente_id = LAST_INSERT_ID();



-- Cree un procedimiento por nombre `ps_obtener_clientes_por_municipio` donde liste todos los clientes de un municipio.

DELIMITER //

DROP PROCEDURE IF EXISTS ps_obtener_clientes_por_municipio;
CREATE PROCEDURE ps_obtener_clientes_por_municipio(
    IN p_municipio VARCHAR(80)
    )
BEGIN
    SELECT cl.cliente_id, cl.nombre, cl.email
    FROM municipio mun
    INNER JOIN clientes cl ON mun.id = cl.municipioid
    WHERE mun.nombre = 'Cali';

END //

DELIMITER ;

CALL ps_obtener_clientes_por_municipio('Cali');