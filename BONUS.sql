-- BONUS --   
/* #### 25.Encuentra todos los actores que han actuado juntos en al menos una película. La consulta
debe mostrar el nombre y apellido de los actores y el número de películas en las que han actuado juntos.*/

 -- Para este ejercicio, necesitamos coincidencias de actor_id con film_id.
 -- Entiendo que hay que hacer dos grupos de actores, para ir comparando uno con todos los demás

 -- Utilizando la tabla film_actor:
 
WITH ActoresRelacionados AS ( 
  SELECT a1.actor_id AS actor_id1, a2.actor_id AS actor_id2, 
COUNT(*) AS cantidad_actuaciones 
  FROM film_actor a1 
  JOIN film_actor a2 ON a1.film_id = a2.film_id AND 
a1.actor_id < a2.actor_id 
  GROUP BY a1.actor_id, a2.actor_id 
  HAVING COUNT(*) >= 1 
) 
SELECT actor1.first_name AS actor1_nombre, actor1.last_name AS 
actor1_apellido, 
       actor2.first_name AS actor2_nombre, actor2.last_name AS 
actor2_apellido, 
       cantidad_actuaciones 
FROM ActoresRelacionados 
JOIN actor AS actor1 ON actor1.actor_id = actor_id1 
JOIN actor AS actor2 ON actor2.actor_id = actor_id2 
ORDER BY cantidad_actuaciones DESC;
 
 
 select count(*)
 from film_actor
 where actor_id in (1, 2)
 
    


    