/*Encuentra  actor que ha participado en más películas, pero que a su vez,
la suma de las duraciones de esas películas sea la menor posible. 
Muestra el nombre y apellido del actor, la cantidad de películas en las que ha participado 
y la suma total de la duración de esas películas.*/

USE sakila;
SELECT
    CONCAT(a.first_name, ' ', a.last_name) AS nombre_completo,
    COUNT(fa.film_id) AS cantidad_peliculas,
    SUM(f.length) AS duracion_total
FROM actor AS a
JOIN film_actor AS fa ON a.actor_id = fa.actor_id
JOIN film AS f ON fa.film_id = f.film_id
GROUP BY nombre_completo
ORDER BY cantidad_peliculas DESC, duracion_total ASC
LIMIT 1;