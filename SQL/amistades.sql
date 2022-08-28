use dojo2022;

-- creando la tabla usuarios
create table usuarios (
id int auto_increment not null primary key,
nombre varchar(255),
apellido varchar(255),
created_at datetime,
updated_at datetime
);

-- creando la tabla amistades
CREATE TABLE amistades (
id int auto_increment not null primary key,
user_id INT,
friend_id INT,
created_at datetime,
updated_at datetime,
CONSTRAINT primera foreign key (user_id) REFERENCES usuarios(id) ,
CONSTRAINT segunda foreign key (friend_id) REFERENCES usuarios(id)
);

-- se insertan los datos a la tabla usuarios del primer grupo de usuarios
insert into usuarios (nombre, apellido, created_at, updated_at) values ("Amy","Giver",now(),now());
insert into usuarios (nombre, apellido, created_at, updated_at) values ("Eli","Byers",now(),now());
insert into usuarios (nombre, apellido, created_at, updated_at) values ("Big","Bird",now(),now());
insert into usuarios (nombre, apellido, created_at, updated_at) values ("La Rana","Rene",now(),now());
insert into usuarios (nombre, apellido, created_at, updated_at) values ("Marky","Mark",now(),now());

-- se insertan los registros en amistades
insert into amistades (user_id, friend_id, created_at, updated_at) values (1,2,now(),now());
insert into amistades (user_id, friend_id, created_at, updated_at) values (1,3,now(),now());
insert into amistades (user_id, friend_id, created_at, updated_at) values (1,4,now(),now());
insert into amistades (user_id, friend_id, created_at, updated_at) values (2,4,now(),now());
insert into amistades (user_id, friend_id, created_at, updated_at) values (2,5,now(),now());
insert into amistades (user_id, friend_id, created_at, updated_at) values (5,3,now(),now());


-- se insertan 6 nuevos usuarios del segundo grupo de usuarios
insert into usuarios (nombre, apellido, created_at, updated_at) values ("Condorito","",now(),now());
insert into usuarios (nombre, apellido, created_at, updated_at) values ("Yayita","",now(),now());
insert into usuarios (nombre, apellido, created_at, updated_at) values ("Ungenio","Gonzalez",now(),now());
insert into usuarios (nombre, apellido, created_at, updated_at) values ("Pepe","Cortizona",now(),now());
insert into usuarios (nombre, apellido, created_at, updated_at) values ("Don","Chuma",now(),now());
insert into usuarios (nombre, apellido, created_at, updated_at) values ("Cone","",now(),now());

-- usuario 6 amigo de los usuarios 7,9,11
insert into amistades (user_id, friend_id, created_at, updated_at) values (6,7,now(),now());
insert into amistades (user_id, friend_id, created_at, updated_at) values (6,9,now(),now());
insert into amistades (user_id, friend_id, created_at, updated_at) values (6,11,now(),now());

-- amistad entre usuario 7 amigo de los usuarios 6,8,10
insert into amistades (user_id, friend_id, created_at, updated_at) values (7,6,now(),now());
insert into amistades (user_id, friend_id, created_at, updated_at) values (7,8,now(),now());
insert into amistades (user_id, friend_id, created_at, updated_at) values (7,10,now(),now());

-- amistad entre usuario 8 amigo de los usuarios 7,10
insert into amistades (user_id, friend_id, created_at, updated_at) values (8,7,now(),now());
insert into amistades (user_id, friend_id, created_at, updated_at) values (8,10,now(),now());

-- amistad entre usuario 9 amigo de los usuarios 8
insert into amistades (user_id, friend_id, created_at, updated_at) values (9,8,now(),now());

-- amistad entre usuario 10 amigo de los usuarios 6 y 11
insert into amistades (user_id, friend_id, created_at, updated_at) values (10,6,now(),now());
insert into amistades (user_id, friend_id, created_at, updated_at) values (10,11,now(),now());

-- amistad entre usuario 11 amigo de los usuarios 7 y 8
insert into amistades (user_id, friend_id, created_at, updated_at) values (11,7,now(),now());
insert into amistades (user_id, friend_id, created_at, updated_at) values (11,8,now(),now());


-- solo se consulta la relaciones de amistad de los primeros usuarios agregados
select CONCAT(u.nombre, " ", u.apellido) usuario, CONCAT(u2.nombre, " " , u2.apellido) as amigo from usuarios u 
join amistades a on u.id = a.user_id
left join usuarios as u2 on u2.id = a.friend_id
where u.id in (1,2,3,4,5); 


-- solo se consulta la relaciones de amistad de los ultimos usuarios agregados
select CONCAT(u.nombre, " ", u.apellido) usuario, CONCAT(u2.nombre, " " , u2.apellido) as amigo from usuarios u 
join amistades a on u.id = a.user_id
left join usuarios as u2 on u2.id = a.friend_id
where u.id in (6,7,8,9,10,11); 


-- consulta todas las relaciones de amistad
select CONCAT(u.nombre, " ", u.apellido) usuario, CONCAT(u2.nombre, " " , u2.apellido) as amigo from usuarios u 
join amistades a on u.id = a.user_id
left join usuarios as u2 on u2.id = a.friend_id; 

-- consulta los usuarios amigos del primer usuario del segundo grupo
select CONCAT(u.nombre, " ", u.apellido) usuario, CONCAT(u2.nombre, " " , u2.apellido) as amigo from usuarios u 
join amistades a on u.id = a.user_id
left join usuarios as u2 on u2.id = a.friend_id
where a.friend_id = 6; 

-- consulta la cantidad de amigos de los usuarios del segundo grupo
select u.id, CONCAT(u.nombre, " ", u.apellido) usuario, COUNT(*) AS amigos from usuarios u 
join amistades a on u.id = a.user_id
left join usuarios as u2 on u2.id = a.friend_id
where u.id in (6,7,8,9,10,11)
GROUP BY u.id order by amigos desc;

-- amigos del tercer usuario de la segunda lista
select CONCAT(u.nombre, " ", u.apellido) usuario, CONCAT(u2.nombre, " " , u2.apellido) as amigo from usuarios u 
join amistades a on u.id = a.user_id
left join usuarios as u2 on u2.id = a.friend_id
where u.id = 8; 
