# **EVALUACIÓN MÓDULO 2: Extracción de Información de Web y Bases de Datos**

En este módulo, se ha trabajado con la base de datos Sakila, poniendo en práctica diversas herramientas de SQL, como queries avanzadas, JOINS, y subconsultas. Utilizando MySQL, se ha accedido a la base de datos para obtener y analizar datos clave de películas, actores y clientes.

Documento MySQL: [pinche aquí](https://github.com/Adalab/bda-modulo-2-evaluacion-final-isamanero/blob/main/Evaluacion_mod2.sql)

Diagrama de la Base de Datos
![alt text](Diagrama.png)
*Este diagrama ilustra la estructura de las tablas de la base de datos Sakila.*

## ✨ Resultados Destacados ✨
A continuación, se muestran algunos de los hallazgos más interesantes durante este análisis de la base de datos de Sakila:


- En la base de datos de Sakila existen **1000 películas** del 2006(ejercicio 16) sin títulos de películas repetidas (ejercicio 1), de las cuales **223 son películas con clasificación PG-13** (ejercicio 2)


- **48** del conjunto de películas, contienen en su descripción la palabra **amazing**.


- <span style="color:green">**45,7%**</span> del conjunto de películas, tienen una duración mayor a 120 minutos (457 películas, respecto a 1000 total).


- Sólo uno de los actores registrados, se apellida Gibson.


- Más del <span style="color:green">**57%**</span> del conjunto de películas, tienen clasificación: PG,G, o NC-17. (ejercicio 8). Se ha utilizado por ejemplo, esta query para calcularlo:

`SELECT title,rating
    FROM film
    WHERE rating NOT IN ("R","PG-13");`


- Se han contabilizado las películas 🎞️ según su clasificación (ejercicio 9), y el número de alquileres por clasificación (ejercicio 12).


- **Eleanor Hunt** es la cliente con mayo número de películas alquiladas 🏆.


- En la película Indian Love, participaron 10 actores registrados.


- Se han encontrado las categorías de películas que tienen un promedio de duración superior a 120 minutos.


- El <span style="color:green">**95,7%**</span> de las películas fueron alquiladas por 5 días o más.


- Sólo 3 películas de comedia 😂 duran más de 3 horas: Control Anthem, Saturn Name y Searchers Wait.


## Conclusión 👌

En este análisis de la base de datos Sakila, se ha podido obtener datos interesantes sobre las películas, actores y clientes. A través de queries avanzadas, se han identificado patrones sobre la duración de las películas, las clasificaciones, los actores involucrados, y el comportamiento de alquiler de los clientes.

Este ejercicio ha sido clave para mejorar las habilidades de consulta en bases de datos y análisis de grandes volúmenes de información.