-- BONUS --   
/* #### 25.Encuentra todos los actores que han actuado juntos en al menos una película. La consulta
debe mostrar el nombre y apellido de los actores y el número de películas en las que han actuado juntos.*/

 -- Para este ejercicio, necesitamos coincidencias de actor_id con film_id.
 -- Entiendo que hay que hacer dos grupos de actores, para ir comparando uno con todos los demás

 -- Utilizando la tabla film_actor:
 
SELECT a.actor_id, a.first_name, a.last_name, a2.actor_id, a2.first_name, a2.last_name,
 COUNT(f.film_id)
	FROM actor a
	INNER JOIN actor a2
	ON  a2.actor_id = a.actor_id
	INNER JOIN film_actor f
	ON a.actor_id = f.actor_id
	WHERE  a.actor_id < a2.actor_id
	GROUP BY a2.actor_id,  a.actor_id
	HAVING count(*) > 1
	ORDER BY a.actor_id, a2.actor_id;
 
 
 
 select count(*)
 from film_actor
 where actor_id in (1, 2)
 
    


    