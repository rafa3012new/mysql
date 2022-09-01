-- se crea la base de datos
-- create database dojo2022;

-- se pone en uso la base de datos
 use dojo2022;

-- se crea la tabla usuarios
  create table usuarios (
  id int auto_increment not null primary key,
  nombre varchar(100),
  apellido varchar(100),
  email varchar(100),
  created_at datetime,
  updated_at datetime
  );

 -- se insertan datos dentro de la tbla usuarios
  insert into usuarios (nombre,apellido,email,created_at,updated_at) values ("Rafael","Fernandez","rafael_fernandez@gmail.com",now(),now());
  insert into usuarios (nombre,apellido,email,created_at,updated_at) values ("Bruce","Wayne","brucewayne@gmail.com",now(),now());
  insert into usuarios (nombre,apellido,email,created_at,updated_at) values ("Clark","Kent","clarkkent@gmail.com",now(),now());
  insert into usuarios (nombre,apellido,email,created_at,updated_at) values ("Barry","Allen","barryallen@gmail.com",now(),now());
  insert into usuarios (nombre,apellido,email,created_at,updated_at) values ("Daiana","Prince","dianaprince@gmail.com",now(),now());
  insert into usuarios (nombre,apellido,email,created_at,updated_at) values ("Victor","Stone","victorstonew@gmail.com",now(),now());


-- se consultan los primeros 3 usuarios (registros) nuevos, comenzando por el registro 0,
 select * from usuarios limit 0,3;

-- se consultan los primeros 3 usuarios de acuerdo al id
 select * from usuarios where id < 4;
-- or
 select * from usuarios where id in (1,2,3);

-- se consultan todos los usuarios
 select * from usuarios;

-- se consulta el ultimo usuario
 select * from usuarios order by id desc limit 1;

-- se modifica el apellido del usuario con el id == 3 a panqueques
 update usuarios set apellido = "panqueques" where id = 3;


-- se borra el usuario #2
 delete from usuarios where id = 2;


-- consultar usuarios con el apellido panqueques
 SELECT * FROM usuarios where apellido = "panqueques";

-- consultar todos los usuarios orenados por su nombre de forma ascendente
 select * from usuarios order by nombre;

-- consultar todos los usuarios orenados por su nombre de forma descendente
 select * from usuarios order by nombre desc;
