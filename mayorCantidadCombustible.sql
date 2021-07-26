use practico;

delimiter //
create function mayorCantidadCombustible(entrada varchar(100)) returns decimal(12,2)
deterministic
begin
declare valor decimal(12,2);
declare temporal varchar(200);
-- agrego el producto al select porque si no da error al utilizarlo en el having
select sum(volumen), producto from facturacion
left join estaciones_normalizada on facturacion.nro_inscripcion = estaciones_normalizada.nro_inscripcion
left join productos on facturacion.id_producto = productos.id_producto
group by facturacion.nro_inscripcion having producto like entrada
order by sum(volumen) DESC limit 1
into valor, temporal;
return valor;
end //

-- select mayorCantidadCombustible('Nafta (súper) entre 92 y 95 Ron');
-- select mayorCantidadCombustible(producto) as Volumen, provincia from estaciones
-- group by provincia;






