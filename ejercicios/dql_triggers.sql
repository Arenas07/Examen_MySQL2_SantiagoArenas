
USE examen_mysql;


-- Define un trigger llamado `trg_fecha_registro_cliente_default` que antes de insertar en clientes, si fecha_registro es NULL, se asigna la fecha actual.

DELIMITER //

DROP TRIGGER IF EXISTS trg_fecha_registro_cliente_default;
CREATE TRIGGER trg_fecha_registro_cliente_default
BEFORE INSERT ON clientes
FOR EACH ROW
BEGIN
    IF NEW.fecha_registro = NULL THEN
        UPDATE clientes
        SET fecha_registro = CURDATE()
        WHERE cliente_id = NEW.cliente_id;
    END IF;

END //

DELIMITER ;

