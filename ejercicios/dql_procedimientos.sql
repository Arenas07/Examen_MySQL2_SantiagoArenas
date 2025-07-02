
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
  'adrian.ruiz@gmail.com', 
  '3123456789', 
  'Calle 123 #45-67', 
  '2025-02-01', 
  5
);

SELECT * FROM clientes WHERE cliente_id = LAST_INSERT_ID();



-- 