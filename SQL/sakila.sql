use sakila;

-- clientes de la ciudad 312 London
select cu.customer_id as id_cliente, CONCAT(cu.first_name, " ", last_name) as nombre_cliente, cu.email,
ad.address as direccion, ct.city_id as id_ciudad, ct.city as ciudad
from customer cu
left join address ad on cu.address_id = ad.address_id
left join city ct on ad.city_id = ct.city_id
where ct.city_id = 312;


-- peliculas tipo comedia
select fl.title, fl.description, fl.release_year, fl.rating, fl.special_features, ct.name  from film fl 
left join film_category fc on fl.film_id = fc.film_id
left join category ct on fc.category_id = ct.category_id
where ct.category_id = 5;

-- actorid == 5
select ac.actor_id, CONCAT(ac.first_name,' ', ac.last_name) as actor, 
fl.title as pelicula, fl.description as descripcion, fl.release_year as ano_lanzamiento
from film fl 
left join film_actor fa on fl.film_id = fa.film_id 
left join actor ac on ac.actor_id = fa.actor_id
where ac.actor_id = 5;

-- clientes afiliados a la store_id = 1 y que vivan en las ciudades 1,42,312 y 459
select st.store_id, adst.address, ctst.city as ciudad_tienda,
CONCAT(cu.first_name, " ", cu.last_name) as Cliente,  
ct.city as "ciudad domicilio del cliente", ct.city_id as id_ciudad_cliente
from customer cu
join store st on cu.store_id = st.store_id
join address adst on st.address_id = adst.address_id
join address adcu on cu.address_id = adcu.address_id
join city ct on adcu.city_id = ct.city_id
join city ctst on adst.city_id = ctst.city_id
where st.store_id = 1 and ct.city_id in (1,42,312,459);


-- peliculas calificacion G, con caracteristicas detras de la escena, actor_id = 15
select * from film fl
left join film_actor fa on fl.film_id = fa.film_id
left join actor ac on ac.actor_id = fa.actor_id
where fl.rating = 'G' and fl.special_features like '%Behind the Scenes%' and fa.actor_id = 15;

-- actores de la pelicula film_id 369
select fl.film_id, fl.title as Titulo, fa.actor_id, CONCAT(ac.first_name, " ", ac.last_name) as Actor
from film fl 
left join film_actor fa on fl.film_id = fa.film_id
left join actor ac on ac.actor_id = fa.actor_id
where fa.film_id = 369;

-- peliculas category = drama and film_rate = 2.99
select * from film fl
left join film_category fc on fl.film_id = fc.film_id
left join category ct on ct.category_id = fc.category_id
 where ct.name = 'Drama' and fl.rental_rate = 2.99;
 
 -- peliculas de accion con la actriz Sandra Kilmer
select * from film fl
left join film_actor fa on fl.film_id = fa.film_id
left join actor ac on ac.actor_id = fa.actor_id
left join film_category as fc on fl.film_id = fc.film_id
left join category as ct on fc.category_id = ct.category_id
where ac.first_name = 'SANDRA' and ac.last_name = 'KILMER' and ct.category_id = 1;