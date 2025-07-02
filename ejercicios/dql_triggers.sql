
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
    WHERE id = OLD.id;

    IF _total >= 1 THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La empresa tiene sucursales';
    END IF;
    
END //

DELIMITER ;

-- 