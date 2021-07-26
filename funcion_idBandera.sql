DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `ID_bandera`(entrada varchar(255)) RETURNS int
    DETERMINISTIC
begin
declare ID int;
select id_bandera from banderas where nombre = entrada 
into ID;
return ID;
end$$
DELIMITER ;
