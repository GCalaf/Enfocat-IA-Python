-- Ejercicios NIVEL Inicial

/*1. Mostrar todos los nombres de los clientes.
Enunciado: Lista los nombres de todos los clientes.*/
SELECT nombre FROM clientes;
/*2. Mostrar las prendas que cuesten más de $30.
Enunciado: Encuentra todas las prendas que tengan un precio mayor a $30.*/
SELECT * FROM prendas WHERE Precio > 30;
/*3. Listar las compras realizadas en octubre de 2023.
Enunciado: Muestra todas las compras que se hicieron en octubre de 2023.*/
SELECT * FROM compras WHERE Fecha_Compra BETWEEN '2023-10-01' AND '2023-10-31';
/*4. Encontrar el precio de una prenda específica.
Enunciado:¿Cuál es el precio de la "Camiseta Roja"?*/
SELECT precio FROM prendas WHERE descripcion = 'Camiseta Roja';
/*5. Mostrar las prendas de talla "M".
Enunciado:Lista todas las prendas que sean de talla "M".*/
SELECT * FROM prendas WHERE talla = 'M';

-- Ejercicios NIVEL Medio

/*6. Contar el número de prendas por talla.
Enunciado:¿Cuántas prendas hay disponibles de cada talla?*/
SELECT talla, COUNT(*) AS Cantidad FROM prendas GROUP BY talla;
/*7. Calcular el precio promedio de las prendas.
Enunciado:¿Cuál es el precio promedio de las prendas disponibles?*/
SELECT AVG(precio) AS Promedio FROM prendas;

-- Ejercicios NIVEL Avanzado

/*8. Mostrar los nombres de los clientes y las prendas que han comprado.
Enunciado: Lista los nombres de los clientes junto con las descripciones de las prendas que han
comprado.*/
SELECT clientes.nombre, prendas.descripcion FROM compras 
JOIN clientes ON compras.id_cliente = clientes.id_cliente
JOIN prendas ON compras.id_prenda = prendas.id_prenda;
/*9. Mostrar los nombres de los clientes, las prendas que han comprado y las fechas de
sus compras.
Enunciado:Lista los nombres de los clientes junto con las descripciones de las prendas que han
comprado y las fechas en que se realizaron dichas compras.*/
SELECT clientes.nombre, prendas.descripcion, Fecha_Compra FROM compras 
JOIN clientes ON compras.id_cliente = clientes.id_cliente
JOIN prendas ON compras.id_prenda = prendas.id_prenda;

-- Ejercicios NIVEL GRAN RETO

/*
10. Aquí tienes un reto que combina la relación entre tres tablas, funciones de
agregación y subconsultas:
Reto: Identificar al cliente que ha gastado el mayor monto en un día específico.
Enunciado: Encuentra al cliente que ha gastado el mayor monto en compras el día '2023-10-
15'. Deberás mostrar el nombre del cliente, la fecha y el monto total gastado.
Seleccionamos el máximo de esos montos.*/
SELECT c.nombre, co.Fecha_Compra, MAX(co.Monto_Total) AS Monto_Total
FROM (
	SELECT id_cliente, Fecha_Compra, SUM(p.precio) AS Monto_Total
	FROM compras co
	JOIN prendas p ON co.id_prenda = p.id_prenda
	WHERE Fecha_Compra = '2023-10-15'
	GROUP BY id_cliente, Fecha_Compra
) co
JOIN clientes c ON co.id_cliente = c.id_cliente
GROUP BY c.nombre, co.Fecha_Compra
ORDER BY Monto_Total DESC
LIMIT 1;