
-- conectando a la base de datos
use dojo2022;

-- creando la tabla usuarios
create table usuarios (
id int auto_increment not null primary key,
nombre varchar(255),
apellido varchar(255),
created_at datetime,
updated_at datetime
);

create table libros (
id int auto_increment not null primary key,
title varchar(250),
numofpages int,
created_at datetime,
updated_at datetime
);

create table favoritos (
user_id int not null,
book_id int not null,
primary key(user_id, book_id),
foreign key (user_id) REFERENCES Usuarios(id) ON DELETE CASCADE ON UPDATE CASCADE,
foreign key (book_id) REFERENCES libros(id) ON DELETE CASCADE ON UPDATE CASCADE
);

insert into usuarios (nombre, apellido, created_at, updated_at) values ('Jane', 'Austin', now(), now());
insert into usuarios (nombre, apellido, created_at, updated_at) values ('Emily', 'Dickinson', now(), now());
insert into usuarios (nombre, apellido, created_at, updated_at) values ('Fyodor', 'Dostoevsky', now(), now());
insert into usuarios (nombre, apellido, created_at, updated_at) values ('William', 'Shakespeare', now(), now());
insert into usuarios (nombre, apellido, created_at, updated_at) values ('Lau', 'Tzu', now(), now());

insert into libros (title, numofpages, created_at, updated_at) values ('C Sharp', 1000, now(), now());
insert into libros (title, numofpages, created_at, updated_at) values ('Java', 1000, now(), now());
insert into libros (title, numofpages, created_at, updated_at) values ('Python', 1000, now(), now());
insert into libros (title, numofpages, created_at, updated_at) values ('PHP', 1000, now(), now());
insert into libros (title, numofpages, created_at, updated_at) values ('Ruby', 1000, now(), now());

update libros set title = 'C#' WHERE id = 1;

update usuarios set nombre = 'Bill' where id = 4;
-- una alternativa de especificamente el 4to registro seria
-- update apellido set nombre = 'Bill' where id in (select id from usuarios limit 3,1);

-- primer usuario marca como favorito los primeros 2 libros de manera estatica
insert into favoritos (user_id, book_id) values (1,1);
insert into favoritos (user_id, book_id) values (1,2);


-- segundo usuario marca como favorito los primeros 3 libros de manera estatica
insert into favoritos (user_id, book_id) values (2,1);
insert into favoritos (user_id, book_id) values (2,2);
insert into favoritos (user_id, book_id) values (2,3);

-- tercer usuario marca como favorito los primeros 1 libros de manera estatica
insert into favoritos (user_id, book_id) values (3,1);
insert into favoritos (user_id, book_id) values (3,2);
insert into favoritos (user_id, book_id) values (3,3);
insert into favoritos (user_id, book_id) values (3,4);

-- tercer usuario marca como favorito los primeros 1 libros de manera estatica
insert into favoritos (user_id, book_id) values (4,1);
insert into favoritos (user_id, book_id) values (4,2);
insert into favoritos (user_id, book_id) values (4,3);
insert into favoritos (user_id, book_id) values (4,4);
insert into favoritos (user_id, book_id) values (4,5);

-- se borra el primer usuario de los favoritos del tercer libro
delete from favoritos where user_id =  2 and book_id = 3;

-- recupera todos los usarios que marcaron como favorito el tercer libro
-- si se borran los registros de libros o cambian los id no afecta la consulta
-- porque se basa estrictamente en el tercer registro de la tabla de libros
-- a tarves de una subconsulta en la clausula where
SELECT CONCAT(u.nombre, " ", u.apellido) as usuario, l.title as 'libro favorito'
FROM favoritos f
JOIN usuarios u ON f.user_id = u.id
JOIN libros l ON f.book_id = l.id
WHERE l.id = (select id from libros limit 2,1); 

-- el quint usuario marca como favorito el segundo libro
insert into favoritos (user_id,book_id) values (5,2);

-- se confirma la consulta anterior
SELECT CONCAT(u.nombre, " ", u.apellido) as usuario, l.title as 'libro favorito'
FROM favoritos f
JOIN usuarios u ON f.user_id = u.id
JOIN libros l ON f.book_id = l.id
WHERE l.id = (select id from libros limit 1,1); 

-- todos los libros que el tercer usuario marca como favorito
-- con sulta independiente si se modifica los registros de la tabla
-- se basa en el tercer registro de la tabla usuario
select u.id, CONCAT(u.nombre, " ", u.apellido) as 'usuario', l.title as "Libro Favorito"  from favoritos f 
join usuarios u on f.user_id = u.id 
join libros l on f.book_id = l.id 
where user_id = (select id from usuarios limit 2,1);

-- Consulta de todos los usuarios que marcan como favorito el quinto libro
select u.id as "id usuario", CONCAT(u.nombre, " ", u.apellido) as "usuario",l.id as "id libro", 
l.title as "libro favorito" from favoritos f 
join usuarios u on f.user_id = u.id 
join libros l on f.book_id = l.id 
where book_id = (select id from libros limit 4,1);