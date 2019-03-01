#Base de datos para FYCT
#Creacion de la base de datos

create database if not exists base_fyct;

#seleccionar base de datos
use base_fyct;

#Creacion de las tablas

create table if not exists fyct(
nombre varchar(50) not null,
direccion varchar(50) not null,
telefono varchar(50) not null,
primary key(nombre)
)ENGINE=INNODB;

create table if not exists usuarios(
correo varchar(50) not null,
nombre varchar(50) not null,
apellido varchar(50) not null,
contrasenia varchar(20) not null,
direccion varchar(50) not null,
telefono varchar(10) not null,
metodoPago enum('PAYPAL','Pago con tarjeta de credito','Pago por transferencia'),
nombreTienda_fk  varchar(10) not null,

primary key(correo),

constraint fkusuario_fyct
foreign key(nombreTienda_fk)
references fyct(nombre)

)ENGINE=INNODB;


create table if not exists categoria(
categoriaid int not null,
nombreCategoria int not null,

primary key(categoriaid)

)ENGINE=INNODB;


create table if not exists producto(
productoid int not null,
nombre varchar(50) not null,
descripcion varchar(50) not null,
categoria varchar(50) not null,
precio int not null,
correoUsuario_fk varchar(50) not null,
categoriaid_fk int not null,

primary key(productoid),

constraint fkcategoria_productos
foreign key(categoriaid_fk)
references categoria(categoriaid),


constraint fkusuarios_productos
foreign key(correoUsuario_fk)
references usuarios(correo)

)ENGINE=INNODB;

create table if not exists carrito(
carritoid int not null,
costoTotal int not null,

primary key(carritoid)

)ENGINE=INNODB;

create table if not exists articulosCarrito(
articulosCarritoid int not null,
cantidad int not null,
costoTotal int not null,
carritoid_fk int not null,

primary key(articulosCarritoid),

constraint fkcarrito_articulos
foreign key(carritoid_fk)
references carrito(carritoid)

)ENGINE=INNODB;


create table if not exists pago(
pagoid int not null,
cantidad int not null,
metodoPago enum('PAYPAL','Pago con tarjeta de credito','Pago por transferencia'),
correoUsuarios_fk varchar(50) not null,
carritoid_fk int not null,


primary key(pagoid),

constraint fkusuarios_pago
foreign key(correoUsuarios_fk)
references usuarios(correo),

constraint fkcarrito_pago
foreign key(carritoid_fk)
references carrito(carritoid)

)ENGINE=INNODB;

create table if not exists productosArticulos(
productoid_fk int not null,
aCarritoid_fk int not null,

primary key(productoid_fk,aCarritoid_fk),

constraint fkproducto_articulo
foreign key(productoid_fk)
references producto(productoid),

constraint fkarticulo_producto
foreign key(aCarritoid_fk)
references articulosCarrito(articulosCarritoid)
)ENGINE=INNODB;




