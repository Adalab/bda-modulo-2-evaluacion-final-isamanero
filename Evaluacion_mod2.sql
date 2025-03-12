## EJERCICIO DE EVALUACIÓN - MÓDULO 2 ##

USE sakila;


-- 1 Selecciona todos los nombres de las películas sin que aparezcan duplicados.

-- Primero observo como son los datos de mi tabla, film que contiene el nombre de las películas
SELECT *
	FROM film;
-- Utilizo DISTINCT, que me permite eliminar duplicados:
SELECT DISTINCT title
	FROM film;

-- No existen películas duplicadas.

-- 2 Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".

/*Utilizando un where, podemos filtrar estas películas clasificadas en PG-13, he añadido la columna para
el ejercicio, pero no sería necesaria*/

SELECT title, rating
	FROM film
    WHERE rating = "PG-13";


/*-- 3 Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su
   descripción.*/
   
/* description aparece en azul, como palabra reservada en SQL, pero la consulta es funcional, se puede
solucionar entrecomillándolo, con acentos invertidos, pero la palabra aparece en rojo y tiene una estética
que resulta más errónea*/
   
SELECT title, description
	FROM film
    WHERE description LIKE '%amazing%';
   
   
 -- 4 Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.
 
 -/*Al igual que el ejercicio anterior, he añadido la columna length (duración) para facilitar
 las comprobaciones del ejercicio, pero no es necesaria */
 
 SELECT title, length
	FROM film
    WHERE length > 120;
 
 -- 5 Recupera los nombres de todos los actores.
 
 -- Uitlizando la tabla actor
 
 SELECT first_name
	FROM actor;
 
 -- 6 Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.
 
  SELECT first_name, last_name
	FROM actor
    WHERE last_name LIKE '%Gibson%';
 
 
 -- 7 Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
 
 -- Podríamos añadir actor_id en las columnas del resultado, para comprobaciones.
 
  SELECT first_name
	FROM actor
    WHERE actor_id BETWEEN 10 AND 20;
 
 
 /* 8 Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su
 clasificación.*/
 
 SELECT title, rating
	FROM film
    WHERE rating NOT IN ("R","PG-13");
 
 
 /* 9 Encuentra la cantidad total de películas en cada clasificación de la tabla film
 y muestra la clasificación junto con el recuento.*/
 
 SELECT rating AS Clasificacion, COUNT(rating)
	FROM film
    GROUP BY rating;
 
 
 /* 10 Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su
 nombre y apellido junto con la cantidad de películas alquiladas.*/
 
 /*Aquí necesito sacar información de dos tablas, por un lado la información de los clientes (nombre y apellido)
 y la información de película (cantidad de películas alquiladas)*/
 
 SELECT customer_id, first_name, last_name
	FROM customer;

SELECT *
	FROM rental;

-- Necesitamos estas dos tablas, que podemos relacionar ya que tienen customer_id en común:

SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) -- Aquí hacemos un COUNT para hacer recuento, podemos renombrar la columna.
	FROM customer AS c
    INNER JOIN rental AS r
    USING (customer_id)
    GROUP BY c.customer_id, c.first_name, c.last_name
    ORDER BY COUNT(r.rental_id) DESC;
    
-- Ejemplo usando un alias para la columna, queda más limpia la query:

    SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS peliculas_alquiladas
	FROM customer AS c
    INNER JOIN rental AS r
    USING (customer_id)
    GROUP BY c.customer_id, c.first_name, c.last_name
    ORDER BY peliculas_alquiladas DESC;

 
 /* 11 Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría
 junto con el recuento de alquileres.*/
 
 /* Aquí hacemos una relación parecida a la anterior, pero con la tabla film (pero tenemos que buscar
 un nexo intermedio entre las dos tablas, ya que no tienen en común.
 La tabla inventory, contiene film_id(de la tabla film) e inventory_id(que también la tiene la tabla rental)
 ese es nuestro nexo. En conclusión, tenemos que unir 3 tablas para relacionar nuestros datos*/
 
SELECT f.rating AS categoría, COUNT(r.rental_id) AS peliculas_alquiladas
	FROM film AS f -- primera tabla
    INNER JOIN inventory AS i -- segunda tabla
    USING (film_id)
    INNER JOIN rental AS r -- tercera tabla
    USING (inventory_id)
    GROUP BY f.rating;
 

/* 12 Encuentra el promedio de duración de las películas para cada clasificación de la tabla film
 y muestra la clasificación junto con el promedio de duración.*/
 
 SELECT rating AS clasificacion,AVG(length) AS promedio_duracion
	FROM film
    GROUP BY rating;
 
-- 13 -Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".

/*Tenemos que relacionar dos tablas, nos piden estos datos:
- first_name, last_name de los actores de la película Indian Love (where)
Desde la tabla actor pasamos por la tabla film_actor, para recoger el film_id
y relacionarlo con la tabla film (para poder filtrar por película)*/

SELECT a.first_name, a.last_name, f.title
	FROM actor AS a
    INNER JOIN film_actor AS f_a -- relación tabla actor con tabla film_actor
    ON a.actor_id = f_a.actor_id -- recogemos el actor_id que es común
    INNER JOIN film AS f -- relacionamos la tabla film con la tabla film_actor
    ON f_a.film_id = f.film_id -- para acceder a los datos de film, para relacionarlos con actor
    WHERE f.title = "Indian Love"
    ORDER BY a.first_name ASC; -- Lo he ordenado alfabéticamente, aunque el ejercicio no lo pedía.

-- 14 -Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.

SELECT title
	FROM film
    WHERE description LIKE '%dog%' OR description LIKE '%cat%';

-- 15 Hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor

/*Podríamos responder a esta query de dos formas, en la primera, como actor_id
se asocia con film_id, búsqueda de valores nulos. Si hay algun actor/actriz
que no aparezca en alguna pelicula no tendrá film_id asociado. */

SELECT *
	FROM film_actor
    WHERE actor_id IS NULL OR film_id IS NULL;

-- También podemos crear una subconsulta de la siguiente forma:
    
SELECT actor_id
	FROM film_actor; -- Aquí obtenemos todos los actores que tienen id, pero queremos los que no están asociados con pelicula:

SELECT first_name, last_name
	FROM actor
    WHERE actor_id NOT IN (SELECT actor_id
	FROM film_actor); -- Aquí metemos la consulta anterior, y NOT IN, por que nos piden que no aparezca en ninguna película.
    -- Como además se especifica de la tabla film_actor, por eso está dentro de la subconsulta.
    
-- 16 Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.

SELECT title, release_year
	FROM film
    WHERE release_year BETWEEN 2005 AND 2010
    ORDER BY release_year ASC;

-- Obtenemos el mismo número de datos, es decir todas las películas fueron lanzadas entre 2005 y 2010:

SELECT release_year, COUNT(release_year)
		FROM film
        GROUP BY release_year; -- Con esta comprobación, podemos ver que además, todas son de 2006.

-- 17 Encuentra el título de todas las películas que son de la misma categoría que "Family".

/* El nombre de las categorías
SELECT *
	FROM category;

-- 18 Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.


/* 19 Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la
tabla film*/

/* 20 Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra
el nombre de la categoría junto con el promedio de duración.*/


/* 21 Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto
 con la cantidad de películas en las que han actuado*/
 
 
 
 /* 22 Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una
 subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las
 películas correspondientes.*/
 
 
 
/* 23 Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría
 "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la
 categoría "Horror" y luego exclúyelos de la lista de actores.*/
 
 
 
 
 /* 24 Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en
 la tabla film.*/