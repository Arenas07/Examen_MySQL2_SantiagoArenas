
USE examen_mysql;


-- Define un evento llamado `ev_actualizar_emails_nulos` que actualiza registros con email NULL o vacío por defecto: correo_desconocido@dominio.com, cada día a las 02:00 am.

DELIMITER //

DROP PROCEDURE IF EXISTS actualizar_correos;
CREATE PROCEDURE actualizar_correos()
BEGIN

    UPDATE clientes
    SET email = 'correo_desconocido@dominio.com'
    WHERE email IS NULL;

END //

DELIMITER ;

DELIMITER //

DROP EVENT IF EXISTS ev_actualizar_emails_nulos;
CREATE EVENT ev_actualizar_emails_nulos
ON SCHEDULE EVERY 1 DAY 
STARTS '2025-07-03 02:00:00'
DO 
BEGIN
    CALL actualizar_correos();
END //

DELIMITER ;

-- Define un evento llamado `ev_cierre_empleados_inactivos` que actualiza estado de empleados con salario 0 como inactivos, semanal.

ALTER TABLE empleados ADD COLUMN estado VARCHAR(80);

DELIMITER //

DROP PROCEDURE IF EXISTS ev_cierre_empleados_inactivos;
CREATE PROCEDURE ev_cierre_empleados_inactivos()
BEGIN

    UPDATE empleados
    SET estado = 'inactivo'
    WHERE salario = 0;

END //

DELIMITER ;


DELIMITER //

DROP EVENT IF EXISTS ev_cierre_empleados_inactivos;
CREATE EVENT ev_cierre_empleados_inactivos
ON SCHEDULE EVERY 1 WEEK
DO 
BEGIN
    CALL ev_cierre_empleados_inactivos();
END //

DELIMITER ;
