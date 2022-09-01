use lead_gen_business;

SET lc_time_names = 'es_CL';

-- 1. ¿Qué consulta ejecutarías para obtener los ingresos totales de marzo de 2012?
select MONTHNAME(charged_datetime) AS Month, format(sum(amount),2,'es_CL') amount from billing
where month(charged_datetime) = 3 and year(charged_datetime) = 2012;

-- 2. ¿Qué consulta ejecutarías para obtener los ingresos totales recaudados del cliente con id de 2?
SELECT cl.client_id, CONCAT(cl.first_name, ' ' , cl.last_name) AS Cliente, 
format(sum(amount),2,'es_CL') monto_total from billing bl
LEFT JOIN clients cl on bl.client_id = cl.client_id
where bl.client_id = 2;

-- 3. ¿Qué consulta ejecutarías para obtener todos los sitios que posee el cliente con id de 10?
SELECT st.site_id, st.domain_name as sitio_web, cl.client_id as id_cliente, CONCAT(cl.first_name, ' ' , cl.last_name) AS Cliente 
From sites st LEFT JOIN clients cl on st.client_id = cl.client_id
where st.client_id = 10;

-- 4-a. ¿Qué consulta ejecutarías para obtener el número total de sitios creados por mes por 
-- año para el cliente con id de 1? ¿Qué pasa con el cliente con id de 20?
-- 4-a. ¿Qué consulta ejecutarías para obtener el número total de sitios creados por mes por 
-- año para el cliente con id de 1? ¿Qué pasa con el cliente con id de 20?
select cl.client_id as id_cliente, CONCAT(cl.first_name, ' ' , cl.last_name) AS Cliente,
count(*) as sitios_creados, monthname(created_datetime) as mes, year(created_datetime) as ano
from sites st left join clients cl on st.client_id = cl.client_id
where cl.client_id = 1
group by cl.client_id, mes, ano
order by year(created_datetime), month(created_datetime) asc;

-- 4-b. ¿Qué consulta ejecutarías para obtener el número total de sitios creados por mes por 
-- año para el cliente con id de 1? ¿Qué pasa con el cliente con id de 20?
select cl.client_id as id_cliente, CONCAT(cl.first_name, ' ' , cl.last_name) AS Cliente,
count(*) as sitios_creados, monthname(created_datetime) as mes, year(created_datetime) as ano
from sites st left join clients cl on st.client_id = cl.client_id
where cl.client_id = 20
group by cl.client_id, mes, ano
order by year(created_datetime), month(created_datetime) asc;


-- 5. ¿Qué consulta ejecutarías para obtener el número total de clientes potenciales generados (registered)
-- para cada uno de los sitios entre el 1 de enero de 2011 y el 15 de febrero de 2011?
select st.site_id, st.domain_name, ld.registered_datetime, count(leads_id) as clientes_potenciales 
from leads ld  left join sites st on ld.site_id = st.site_id
where DATE(ld.registered_datetime) >= '2011-01-01' and DATE(ld.registered_datetime) <= '2011-02-15'
group by st.site_id order by st.created_datetime asc;

use lead_gen_business;

-- 6. ¿Qué consulta ejecutarías para obtener el número total de clientes potenciales que 
-- hemos generado para cada uno de nuestros clientes entre el 1 de enero de 2011 y el 31 de diciembre de 2011?

select cl.client_id , CONCAT(cl.first_name, ' ', cl.last_name) , count(ld.leads_id) as clientes_potenciales 
from clients cl  
left join sites st on cl.client_id = st.client_id
left join leads ld on ld.site_id = st.site_id 
where DATE(ld.registered_datetime) >= '2011-01-01' and DATE(registered_datetime) <= '2011-12-31'
group by cl.client_id;

-- 7. ¿Qué consulta ejecutarías para obtener una lista de nombres de clientes y 
-- el número total de clientes potenciales que hemos generado para cada cliente, 
-- cada mes, entre los meses 1 y 6 del año 2011?

select cl.client_id , CONCAT(cl.first_name, ' ', cl.last_name) , 
count(ld.leads_id) as clientes_potenciales, monthname(ld.registered_datetime), year(ld.registered_datetime)
from clients cl  
left join sites st on cl.client_id = st.client_id
left join leads ld on ld.site_id = st.site_id 
where MONTH(ld.registered_datetime) in (1,2,3,4,5,6)  and YEAR(registered_datetime) = 2011
group by cl.client_id, month(ld.registered_datetime);


-- 8-a. ¿Qué consulta ejecutarías para obtener una lista de nombres de clientes y el número 
-- total de clientes potenciales que hemos generado para cada uno de los sitios de nuestros 
-- clientes entre el 1 de enero de 2011 y el 31 de diciembre de 2011? Solicita esta consulta 
-- por id de cliente. 

select cl.client_id , CONCAT(cl.first_name, ' ', cl.last_name) as cliente, 
st.site_id , st.domain_name as sitio_web,
count(ld.leads_id) as clientes_potenciales
from clients cl  
left join sites st on cl.client_id = st.client_id
left join leads ld on ld.site_id = st.site_id 
where DATE(ld.registered_datetime) >= '2011-01-01' and DATE(ld.registered_datetime) <= '2011-12-31'
group by cl.client_id, st.site_id
order by client_id, sitio_web;

-- 8 -b. Realiza una segunda consulta que muestre todos los clientes, los nombres 
-- del o los sitios y el número total de clientes potenciales generados en cada sitio para todos 
-- los tiempos

select cl.client_id , CONCAT(cl.first_name, ' ', cl.last_name) as cliente, 
st.site_id , st.domain_name as sitio_web,
count(ld.leads_id) as clientes_potenciales
from clients cl  
left join sites st on cl.client_id = st.client_id
left join leads ld on ld.site_id = st.site_id 
group by cl.client_id, st.site_id
order by client_id, sitio_web;



-- 9-a. Escribe una única consulta que recupere los ingresos totales recaudados por cada cliente 
-- durante cada mes del año. Haz la consulta por id de cliente. Primero intenta esto con el 
-- número del mes, luego con el nombre del mes.   Se necesitará una subconsulta SELECT para el 
-- segundo desafío. 

-- con el numero del mes
SELECT cl.client_id, CONCAT(cl.first_name, ' ' , cl.last_name) AS Cliente, 
format(sum(bl.amount),2,'es_CL') as total_revenue,
month(bl.charged_datetime) as mes, year(bl.charged_datetime) as ano
from clients cl
LEFT JOIN billing bl on bl.client_id = cl.client_id
group by cl.client_id, month(bl.charged_datetime), year(bl.charged_datetime)
order by cl.client_id, year(bl.charged_datetime),  month(bl.charged_datetime);

-- con el nombre del mes
SELECT cl.client_id, CONCAT(cl.first_name, ' ' , cl.last_name) AS Cliente, 
format(sum(bl.amount),2,'es_CL') as total_revenue,
monthname(bl.charged_datetime) as mes, year(bl.charged_datetime) as ano
from clients cl
LEFT JOIN billing bl on bl.client_id = cl.client_id
group by cl.client_id, month(bl.charged_datetime), year(bl.charged_datetime)
order by cl.client_id, year(bl.charged_datetime),  month(bl.charged_datetime);

-- 10. Escribe una única consulta que recupere todos los sitios que posee cada cliente.  
-- Agrupa los resultados para que todos los sitios de cada cliente se muestren en un solo campo. 
-- Se volverá más claro cuando agregues un nuevo campo llamado “sitios” que tiene todos los sitios 
-- que posee el cliente. (PISTA: usa GROUP_CONCAT)

select cl.client_id, CONCAT(cl.first_name, ' ', cl.last_name) as Cliente,
GROUP_CONCAT(st.domain_name SEPARATOR ' / ') as Sitios
from clients cl
left join sites st on st.client_id = cl.client_id
group by cl.client_id
order by cl.client_id;