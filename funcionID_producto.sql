DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `ID_producto`(entrada varchar(255)) RETURNS int
    DETERMINISTIC
begin
declare ID int;
select id_producto from productos where producto = entrada 
into ID;
return ID;
end$$
DELIMITER ;
