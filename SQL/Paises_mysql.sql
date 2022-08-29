-- se usa la base de datos
use world;

-- Paises que hablan cada idioma con su porcentaje ordenamos por pais alfabetiamnete
-- Y por porcentaje de cual idioma se habla de mas alto a mas bajo
-- Filtrando por Eloveno
 select c.name as Pais, l.language as Idioma, CONCAT(l.percentage," %") as Porcentaje from country c join languages l on c.code = l.country_code
 where l.language = "Slovene"
 order by l.percentage desc;
 
 
 
 -- consulta ue devuelve la cantidad de ciudades por pais
 select co.name as pais,  count(ct.name) as ciudades from country co 
 left join city ct on co.code = ct.countrycode 
 group by co.name order by ciudades desc;
 
 
 -- Ciudades de Mexico que tiene una poblacion mayor a 500 mil, con el separador de miles qe se usa en Chile
 select co.name as Pais, ct.name as Ciudad, FORMAT(ct.population,0,"es_CL") as poblacion from country co 
 join city ct on co.code = ct.countrycode
 where co.name = "Mexico" and ct.population > 500000
 order by co.name asc, ct.population desc;
 
 -- pais que hable cuya poblacion hable mas de 89% un idioma
 select c.name as Pais, l.language as Idioma, CONCAT(l.percentage," %") as Porcentaje from country c 
 join languages l on c.code = l.country_code
 where l.percentage > 89
 order by l.percentage desc;
 
 
  -- consulta ue devuelve la cantidad de paises con superficie de area menor a 501 y
  -- poblacion mayor a 100000
select name as Pais, format(surfacearea,2,"es_CL") as Area_Superfice, FORMAT(population,0,"es_CL") as Poblacion from country
where  surfacearea < 501 and population > 100000;
 
  -- consulta ue devuelve paises con govierno de monarquia constitucional, capital > 200 y
  -- expectativa de vida mayor a 75 anos
select Name as Pais, GovernmentForm as Gobierno, capital, format(LifeExpectancy,2,"es_CL") as "Esperanza de Vida" from country
where GovernmentForm = "Constitutional Monarchy" and
capital > 200 and LifeExpectancy > 75;
 
 
 -- ciudades de distrito buenos aires en argentina cuya poblacion sea mayor a 500000
 select co.name as pais, ct.name as ciudad, ct.district, ct.Population from country co join city ct on co.code = ct.countrycode
where co.name = "Argentina" and ct.District = "Buenos Aires"and ct.population > 500000;

-- consulta de paises por region
select region, count(*) as paises from country group by region order by paises desc;