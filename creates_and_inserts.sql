-- Entidad empresas
create table empresas (cuit bigint not null,nombre varchar(100) not null, primary key(cuit) );
insert into empresas (cuit,nombre) select cuit, operador from estaciones group by cuit;

-- Entidad Banderas
create table banderas (id_bandera int not null auto_increment, nombre varchar (50) not null, primary key(id_bandera));
insert into banderas (nombre) select distinct bandera from estaciones;

-- Entidad canales de comercializacion
 create table canales_de_comercializacion (id_canal_de_comercializacion int not null auto_increment, canal varchar(50),primary key(id_canal_de_comercializacion));
 insert into canales_de_comercializacion (canal) select distinct canal_de_comercializacion from estaciones;

-- Entidad codigo postal
 create table codigoPostal (id_codPostal int not null auto_increment,localidad varchar(255) not null,
							 provincia varchar(255) not null, primary key(id_codPostal));
 insert into codigopostal (localidad,provincia) select distinct localidad, provincia from estaciones;

-- Entidad productos
 create table productos (id_producto int not null auto_increment, producto varchar (100), primary key(id_producto));
 insert into productos (producto) select distinct producto from estaciones;

-- Entidad intermedia entre productos y canales de comercializacion
 create table producto_canal (id_producto int not null, id_canal_de_comercializacion int not null,
							 primary key(id_producto,id_canal_de_comercializacion),
                             foreign key(id_producto) references productos(id_producto),
                             foreign key(id_canal_de_comercializacion) references canales_de_comercializacion(id_canal_de_comercializacion));
-- insert con funciones ID_producto y ID_canal para obtener el correspondiente ID
 insert into producto_canal (id_producto,id_canal_de_comercializacion)
 select distinct ID_producto(producto),ID_canal(canal_de_comercializacion) from estaciones; 


-- Entidad estaciones normalizada
 create table estaciones_normalizada (nro_inscripcion int not null, id_bandera int not null, cuit bigint not null,
									 id_codPostal int not null,tipo_negocio varchar(100) not null, direccion varchar(255) not null, 
                                     exentos char(1), no_movimientos char(2), primary key(nro_inscripcion), 
                                     foreign key(id_bandera) references banderas(id_bandera), 
                                     foreign key(cuit) references empresas(cuit), 
                                     foreign key(id_codPostal) references codigopostal(id_codPostal));

-- insert en tabla normalizada
 insert ignore into estaciones_normalizada (nro_inscripcion,id_bandera,cuit,id_codPostal,tipo_negocio, direccion, exentos,no_movimientos)
 select nro_inscripcion, ID_bandera(bandera), cuit, ID_codigoPostal(localidad, provincia), tipo_negocio, direccion, exentos, no_novimientos from estaciones group by nro_inscripcion;


-- Entidad facturacion
create table facturacion (id_facturacion int not null auto_increment ,nro_inscripcion int not null, id_producto int not null,
					 id_canal_de_comercializacion int not null,
					 anio int not null, mes tinyint not null,
					 precio_sin_impuestos decimal(12,2) not null, precio_con_impuestos decimal(12,2) not null,
                     precio_surtidor decimal(12,2) not null, volumen decimal(12,2) not null,
                     primary key(id_facturacion), foreign key(nro_inscripcion) references estaciones_normalizada(nro_inscripcion),
                     foreign key(id_producto,id_canal_de_comercializacion) references producto_canal(id_producto,id_canal_de_comercializacion));

-- insert en la tabla
insert into facturacion (nro_inscripcion, id_producto,id_canal_de_comercializacion, anio, mes, precio_sin_impuestos, precio_con_impuestos, precio_surtidor, volumen )
select nro_inscripcion, ID_producto(producto), ID_canal(canal_de_comercializacion), anio, mes, regularizar(precio_sin_impuestos), regularizar(precio_con_impuestos), regularizar(precio_surtidor), volumen from estaciones;
