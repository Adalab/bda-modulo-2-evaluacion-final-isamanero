-- BONUS --   
/* #### 25.Encuentra todos los actores que han actuado juntos en al menos una película. La consulta
debe mostrar el nombre y apellido de los actores y el número de películas en las que han actuado juntos.*/

 -- Para este ejercicio, necesitamos coincidencias de actor_id con film_id.
 -- Utilizando la tabla film_actor:
 
 SELECT actor_id, film_id
	FROM film_actor
	WHERE actor_id = 1;
    
-- Entiendo que hay que hacer dos grupos de actores, para ir comparando uno con todos los demás


    