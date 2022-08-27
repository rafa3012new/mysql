-- se pone en uso la base de datos
use dojo2022;


--  se crea la tabla dojos
      create table dojos (
      id int auto_increment not null primary key,
      nombre varchar(100),
      created_at datetime,
      updated_at datetime
      );

-- se crea la tabla ninjas
     create table ninjas (
     id int auto_increment not null primary key,
     nombre varchar(100),
     edad int,
     dojo_id int,
     created_at datetime,
     updated_at datetime
     );



-- se crean 3 dojos nuevos
   insert into dojos (nombre, created_at, updated_at) values ("miyagi do", now(), now());
   insert into dojos (nombre, created_at, updated_at) values ("cobra kai", now(), now());
   insert into dojos (nombre, created_at, updated_at) values ("eagle fang", now(), now());

-- se borran los dojos
   delete from dojos;

-- se crean otros dojos
    insert into dojos (nombre, created_at, updated_at) values ("Tang Soo Do", now(), now());
    insert into dojos (nombre, created_at, updated_at) values ("Shotokan Karate", now(), now());
    insert into dojos (nombre, created_at, updated_at) values ("Wushu Kungfu", now(), now());

-- se insertan 3 ninjas en el primer dojo "Tang Soo Do"
    insert into ninjas (nombre, edad, dojo_id, created_at, updated_at) values ('Chuck Norris',80, '1', now(), now());
    insert into ninjas (nombre, edad, dojo_id, created_at, updated_at) values ('William Zabka',55, '1', now(), now());
    insert into ninjas (nombre, edad, dojo_id, created_at, updated_at) values ('Bob Wall',70, '1', now(), now());

-- se insertan 3 ninjas en el segundo dojo "Shotokan Karate"
    insert into ninjas (nombre, edad, dojo_id, created_at, updated_at) values ('Juan Clude Van Damme',60, '2', now(), now());
    insert into ninjas (nombre, edad, dojo_id, created_at, updated_at) values ('Michael Jai White',45, '2', now(), now());
    insert into ninjas (nombre, edad, dojo_id, created_at, updated_at) values ('Scott Adkins', 40,'2', now(), now());

-- se insertan 3 ninjas en el tercer dojo "Wushu Kungfu"
   insert into ninjas (nombre, edad, dojo_id, created_at, updated_at) values ('Donnie Yen',55, '3', now(), now());
   insert into ninjas (nombre, edad, dojo_id, created_at, updated_at) values ('Jackie Chang',65, '3', now(), now());
   insert into ninjas (nombre, edad, dojo_id, created_at, updated_at) values ('Jet Li',60, '3', now(), now());
 

-- se consultan los registros del primer dojo
 select * from ninjas where dojo = 1;

-- se consultan los registros del tercer dojo
 select * from ninjas where dojo = 3;

-- el dojo del ultimo ninja creado, si se crea otro ninja se actualiza la consulta
  select n.id as "id_ninja", n.nombre as "nombre_ninja" , d.nombre as "nombre_dojo" from ninjas n join dojos d on n.dojo_id = d.id order by n.id desc limit 1;