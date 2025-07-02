
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