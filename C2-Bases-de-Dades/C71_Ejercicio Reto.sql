USE sakila;
# Reto 1
/*La dirección del cliente de 'ARGENTINA' que ha alquilado más
películas del género de accion, con actores que contenga la
letra 'a' en su apellido. Que haya alquilado peliculas entre
2006 y 2007 y que se haya gastado dos cifras en su alquiler
(ejemplo 12,32$)*/
SELECT 
    cu.customer_id AS Cid,
    CONCAT(cu.first_name, ' ', cu.last_name) AS clientName,
    ad.address AS direccion,
    SUM(p.amount) AS total_gastado,
    COUNT(r.rental_id) AS total_rentas
FROM customer cu
JOIN address ad ON cu.address_id = ad.address_id
JOIN city ci ON ad.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
JOIN rental r ON cu.customer_id = r.customer_id
JOIN payment p ON r.rental_id = p.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category cat ON fc.category_id = cat.category_id
WHERE 
    co.country = 'Argentina' AND
    a.last_name LIKE '%a%' AND
    cat.name = 'Action' AND
    r.rental_date BETWEEN '2006-01-01' AND '2007-12-31'
GROUP BY cu.customer_id
HAVING total_gastado BETWEEN 10 AND 99.99;
# Reto 2
/*Selecciona el número de los clientes que
han alquilado una película en el periodo entre 2023-12-31
y 2024-01-01 y que viva en Nueva York*/
SELECT COUNT(cu.customer_id) AS num_personas
FROM customer cu
JOIN address ad ON cu.address_id = ad.address_id
JOIN city ci ON ad.city_id = ci.city_id
JOIN rental r ON cu.customer_id = r.customer_id
WHERE 
    r.rental_date BETWEEN '2005-01-01' AND '2005-12-31' AND
    ci.city = 'Moscow';
# Reto 3
/* Encuentra el total de ingresos generados por cada actor
a través de las películas en las que ha participado. El
resultado debe incluir:
- El nombre completo del actor.
- El total de ingresos generados por sus películas (suma
de los pagos).
Ordena el resultado de mayor a menor ingreso generado. */
SELECT 
    CONCAT(a.first_name, ' ', a.last_name) AS nombre_completo,
    SUM(p.amount) AS total_ingresos
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY a.actor_id
ORDER BY total_ingresos DESC;

# Reto 4
/* Lista los clientes que han alquilado una pelicula, que
peliculas ha alquilado y cuando
que se imprima maximo 5 resultados, se tiene que imprimir
el nombre y el apellido como si fuera
un unico campo, */
SELECT
	cu.customer_id,
    CONCAT(cu.first_name, ' ', cu.last_name) AS customer_name,
    f.title,
    r.rental_date
FROM customer cu
JOIN rental r ON cu.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
ORDER BY r.rental_date DESC
LIMIT 5;