DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `regularizar`(entrada decimal(12,2)) RETURNS decimal(12,2)
    DETERMINISTIC
begin
declare valor decimal(12,2);
if (entrada >120) 
	then set valor = entrada / 10;
else
	set valor = entrada;
end if;
if (entrada > 120 and entrada > 1000)
	then set valor = entrada/1000;
end if;

return valor;
end$$
DELIMITER ;
