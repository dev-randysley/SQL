DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `ID_codigoPostal`(entrada1 varchar(255),entrada2 varchar(255)) RETURNS int
    DETERMINISTIC
begin
declare ID int;
select id_codPostal from codigopostal where localidad = entrada1 and provincia = entrada2 
into ID;
return ID;
end$$
DELIMITER ;
