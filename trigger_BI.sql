use practico;

DELIMITER //
CREATE TRIGGER facturacion_BI
BEFORE INSERT ON facturacion
FOR EACH ROW
BEGIN
DECLARE MENSAJE VARCHAR(80);
DECLARE cantidad_filas INT;
SET MENSAJE=CONCAT('EL NUMERO INGRESADO DE PRODUCTO ',NEW.id_producto,' NO PERTENECE A NINGUNO DE LOS PRODUCTOS VENDIDOS');
select count(*) into cantidad_filas
from facturacion where id_producto = NEW.id_producto;
if cantidad_filas > 0 then -- quiere decir que el id de producto ya esta registrado y se toma como valido
	insert into facturacion
    (nro_inscripcion,id_producto,id_canal_de_comercializacion,anio,mes,precio_sin_impuestos,precio_con_impuestos,precio_surtidor,volumen)
    values 
    (NEW.nro_inscripcion,NEW.id_producto,NEW.id_canal_de_comercializacion,NEW.anio,NEW.mes,NEW.precio_sin_impuestos,NEW.precio_con_impuestos,NEW.precio_surtidor,NEW.volumen);
else
	signal sqlstate '50000'
	set message_text = mensaje;
end if;

END //
DELIMITER ;