
USE examen_mysql;


-- Define un trigger llamado `trg_fecha_registro_cliente_default` que antes de insertar en clientes, si fecha_registro es NULL, se asigna la fecha actual.

DELIMITER //

DROP TRIGGER IF EXISTS trg_fecha_registro_cliente_default;
CREATE TRIGGER trg_fecha_registro_cliente_default
BEFORE INSERT ON clientes
FOR EACH ROW
BEGIN
    IF NEW.fecha_registro IS NULL THEN
        UPDATE clientes
        SET fecha_registro = CURDATE()
        WHERE cliente_id = NEW.cliente_id;
    END IF;

END //

DELIMITER ;


-- Define un trigger llamado `trg_prevenir_borrado_empresa_con_sucursales` que antes de borrar en empresa, verifica que no tenga sucursales asociadas.


DELIMITER //

DROP TRIGGER IF EXISTS trg_prevenir_borrado_empresa_con_sucursales;
CREATE TRIGGER trg_prevenir_borrado_empresa_con_sucursales
BEFORE DELETE ON empresa
FOR EACH ROW
BEGIN 
    DECLARE _total INT;

    SELECT COUNT(suc.id) INTO _total
    FROM empresa e
    INNER JOIN sucursal suc ON e.id = suc.empresaid
    WHERE id = NEW.id;

    IF _total >= 1 THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La empresa tiene sucursales';
    END IF;
    
END //

DELIMITER ;

-- Define un trigger llamado `trg_bloquear_duplicado_email` que antes de insertar en clientes, bloquea si el email ya existe hacendo uso de `SIGNAL`.


DELIMITER //

DROP TRIGGER IF EXISTS trg_bloquear_duplicado_email;
CREATE TRIGGER trg_bloquear_duplicado_email
BEFORE INSERT ON clientes
FOR EACH ROW
BEGIN 
    DECLARE _email VARCHAR(80);
    
    SELECT email INTO _email
    FROM clientes
    WHERE cliente_id = NEW.cliente_id;

    IF _email = NEW.email THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Correo en uso';
    END IF;
END //

DELIMITER ;

-- Define un trigger llamado `trg_normalizar_nombre_empleado` que antes  de insertar en empleados, convierte el nombre a mayúsculas.

DELIMITER //

DROP TRIGGER IF EXISTS trg_normalizar_nombre_empleado;
CREATE TRIGGER trg_normalizar_nombre_empleado
BEFORE INSERT ON empleados
FOR EACH ROW
BEGIN 
    UPDATE empleados
    SET nombre = UPPER(NEW.nombre)
    WHERE empleado_id = NEW.empleado_id; 

END //

DELIMITER ;