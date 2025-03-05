/*
Ejercicio 1: Consulta de Películas y Categorías
Enunciado:
Usando la base de datos Sakila, escribe una consulta SQL que liste todas las películas (film) junto con su
categoría (category). La lista debe contener el título de la película, la descripción y el nombre de la
categoría. Ordena los resultados por el nombre de la categoría de manera ascendente.
*/
USE sakila;
SELECT F.title, F.description, C.name AS category_name
FROM film F
JOIN film_category FC ON F.film_id = FC.film_id
JOIN category C ON FC.category_id = C.category_id;

/*Ejercicio 2: Consulta de Clientes y Alquileres
Enunciado:
Crea una consulta SQL que muestre la cantidad de películas alquiladas por cada cliente en la base de
datos Sakila. El resultado debe incluir el ID del cliente, su nombre completo (nombre y apellido) y el
número total de películas que ha alquilado. Ordena los resultados por el número total de alquileres de
manera descendente. */
SELECT 
    C.customer_id, 
    CONCAT(C.first_name, ' ', C.last_name) AS full_name, 
    COUNT(R.rental_id) AS total_rentals
FROM customer C
JOIN rental R ON C.customer_id = R.customer_id
GROUP BY C.customer_id, full_name
ORDER BY total_rentals DESC;

/*Ejercicio 3: Búsqueda de Películas por Actor
Enunciado:
Escribe una consulta SQL que encuentre todas las películas en las que ha participado el actor "JOHNNY
LOLLOBRIGIDA". Debes mostrar el título de la película y la descripción. Ordena el resultado por el título
de la película de manera ascendente.*/
SELECT F.title, F.description
FROM film F
JOIN film_actor FA ON F.film_id = FA.film_id
JOIN actor A ON FA.actor_id = A.actor_id
WHERE A.first_name = 'JOHNNY' AND A.last_name = 'LOLLOBRIGIDA'
ORDER BY F.title ASC;

/*Ejercicio 4: Alquileres Por Mes
Enunciado:
Crea una consulta SQL que muestre el número de películas alquiladas en cada mes del año 2005. El
resultado debe incluir el mes y el total de alquileres, ordenados por mes.*/
SELECT 
    MONTH(R.rental_date) AS month,
    COUNT(F.film_id) AS total_rentals
FROM film F
JOIN inventory I ON F.film_id = I.film_id
JOIN rental R ON I.inventory_id = R.inventory_id
WHERE YEAR(R.rental_date) = 2005
GROUP BY month;

/*Ejercicio 5: Películas No Alquiladas
Enunciado:
Genera una consulta SQL para encontrar las películas que nunca han sido alquiladas. Muestra el título
de la película y la descripción.*/
SELECT F.title, F.description
FROM film F
LEFT JOIN inventory I ON F.film_id = I.film_id
LEFT JOIN rental R ON I.inventory_id = R.inventory_id
WHERE R.inventory_id IS NULL;

/*Ejercicio 6: Clientes Morosos
Enunciado:
Escribe una consulta SQL que identifique a los clientes que tienen alquileres sin devolver pasados más
de 3 días de la fecha esperada de retorno. Incluye el ID del cliente, nombre completo y el número de
días de retraso.*/
SELECT 
    C.customer_id,
    CONCAT(C.first_name, ' ', C.last_name) AS full_name,
    SUM(TIMESTAMPDIFF(DAY, R.rental_date, R.return_date)) AS delay_days
FROM customer C
JOIN rental R ON C.customer_id = R.customer_id
WHERE R.rental_date IS NOT NULL AND R.return_date IS NOT NULL
  AND TIMESTAMPDIFF(DAY, R.rental_date, R.return_date) > 3
GROUP BY C.customer_id;

/*Ejercicio 7: Ingresos Por Categoría de Película
Enunciado:
Desarrolla una consulta SQL que calcule el total de ingresos generados por cada categoría de películas.
Incluye el nombre de la categoría y el total de ingresos, ordenando de mayor a menor ingreso.*/
SELECT cat.name AS category_name, SUM(p.amount) AS total_income
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category cat ON fc.category_id = cat.category_id
GROUP BY cat.name
ORDER BY total_income DESC;

/*Ejercicio 8: Duración Promedio de Alquiler por Categoría
Enunciado:
Crea una consulta SQL que determine la duración promedio de alquiler de las películas por categoría.
Debe mostrar el nombre de la categoría y la duración promedio de alquiler en días.*/
SELECT cat.name AS category_name, AVG(DATEDIFF(r.return_date, r.rental_date)) AS
average_rental_duration
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category cat ON fc.category_id = cat.category_id
WHERE r.return_date IS NOT NULL
GROUP BY cat.name;

/*Ejercicio 9: Actores Con Más Películas
Enunciado:
Escribe una consulta SQL que liste los actores que han participado en 15 o más películas. Muestra el
nombre completo del actor y el número de películas en las que ha participado.*/
SELECT CONCAT(a.first_name, ' ', a.last_name) AS actor_name, COUNT(fa.film_id) AS movies_count
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
HAVING movies_count >= 15;

/*Ejercicio 10: Diferencia de Ingresos Entre Categorías
Enunciado:
Desarrolla una consulta SQL que compare los ingresos totales generados entre dos categorías
específicas: "Action" y "Sci-Fi". El resultado debe incluir el nombre de la categoría y el total de ingresos.*/
SELECT cat.name AS category_name, SUM(p.amount) AS total_income
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category cat ON fc.category_id = cat.category_id
WHERE cat.name IN ('Action', 'Sci-Fi')
GROUP BY cat.name;

/*Ejercicio Intermedio: Clientes con Máximo Alquiler en una Ciudad
Enunciado:
Usando la base de datos Sakila, escribe una consulta SQL que identifique al cliente que ha realizado más
alquileres en cada ciudad. Suponiendo que cada cliente pertenece a una única ciudad a través de su dirección. El
resultado debe incluir el nombre de la ciudad, el nombre completo del cliente (nombre y apellido), y el total de
alquileres realizados por ese cliente. En caso de empates, incluye todos los clientes que compartan el máximo
número de alquileres en su ciudad.*/
SELECT
ci.city,
CONCAT(c.first_name, ' ', c.last_name) AS full_name,
COUNT(r.rental_id) AS total_rentals
FROM
customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY ci.city, c.customer_id
ORDER BY ci.city ASC, total_rentals DESC;