DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `ID_canal`(entrada varchar(255)) RETURNS int
    DETERMINISTIC
begin
declare ID int;
select id_canal_de_comercializacion from canales_de_comercializacion where canal = entrada 
into ID;
return ID;
end$$
DELIMITER ;
