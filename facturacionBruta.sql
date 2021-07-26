use practico;

DELIMITER $$
CREATE PROCEDURE FacturacionBrutaPorMesMayorA(IN cantidad bigint)
BEGIN
-- declaracion de variables locales
DECLARE CANT SMALLINT;
DECLARE EOF BOOLEAN DEFAULT FALSE;
DECLARE nro_estacion INT;
DECLARE facturacion BIGINT;
DECLARE mes tinyint;
-- declaracion del cursor
DECLARE C1 CURSOR FOR
	select (sum(precio_surtidor) * sum(volumen) * 1000) as facturacion_bruta, nro_inscripcion as estacion from facturacion
	group by nro_inscripcion, mes having facturacion_bruta > @cantidad;
-- declaracion del handler para el caso de no encontrar valores
DECLARE CONTINUE HANDLER FOR NOT FOUND
BEGIN
	SET EOF=TRUE;
END;
SET CANT=0;
-- abrimos el cursor
OPEN C1;
-- comenzamos la iteracion
WHILE EOF=FALSE DO
	FETCH C1 INTO facturacion ,nro_estacion;
	IF EOF=FALSE THEN
		SELECT nro_estacion as estacion, facturacion;
	ELSE
		IF CANT=0 THEN
			SELECT CONCAT('NO EXISTEN ESTACIONES CON FACTURACION EN BRUTO MAYOR AL MONTO INGRESADO.') AS MENSAJE;
		END IF;
	END IF;
	SET CANT=CANT+1;
END WHILE;
CLOSE C1;
END $$
DELIMITER ;