
-- punto 1
select count(*) estaciones_servicio, localidad, provincia from facturacion
inner join estaciones_normalizada on facturacion.nro_inscripcion = estaciones_normalizada.nro_inscripcion
inner join codigopostal on  estaciones_normalizada.id_codPostal = codigopostal.id_codPostal
group by localidad, provincia;

-- punto 2
select count(*) estaciones_servicio,provincia from facturacion
inner join estaciones_normalizada on facturacion.nro_inscripcion = estaciones_normalizada.nro_inscripcion
inner join codigopostal on  estaciones_normalizada.id_codPostal = codigopostal.id_codPostal
group by provincia;

-- punto 3
select distinct facturacion.nro_inscripcion numero_estacion from facturacion
inner join estaciones_normalizada on facturacion.nro_inscripcion = estaciones_normalizada.nro_inscripcion
where exentos like 'f';

-- punto 4
select sum(volumen * 1000) as Volumen, nro_inscripcion as Volumen from facturacion
group by nro_inscripcion;

-- punto 5
select nro_inscripcion as numero_estacion ,producto, round(avg(precio_surtidor),2) as promedio_precio, mes from facturacion
left join productos on facturacion.id_producto = productos.id_producto
group by producto, nro_inscripcion having mes in (1,2,3);

-- punto 6
select nro_inscripcion, producto, abs(precio_con_impuestos-precio_surtidor) as diferencia from facturacion
inner join productos on facturacion.id_producto = productos.id_producto
group by producto, nro_inscripcion
order by nro_inscripcion;
