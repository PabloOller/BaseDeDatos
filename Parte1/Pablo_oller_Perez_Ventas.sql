/*1. Devuelve un listado con el identificador, nombre y los apellidos de todos los
 clientes que han realizado algún pedido. El listado debe estar ordenado
 alfabéticamente y se deben eliminar los elementos repetidos*/
SELECT
    DISTINCT(c.id),
    c.nombre,
    c.apellido1,
    c.apellido2
FROM
    cliente c,
    pedido p
WHERE
    p.id_cliente = c.id
ORDER BY
    c.nombre ASC;

/*2. Devuelve un listado que muestre todos los pedidos que ha realizado cada
 cliente. El resultado debe mostrar todos los datos de los pedidos y del cliente.
 El listado debe mostrar los datos de los clientes ordenados alfabéticamente.*/
SELECT
    c.*,
    p.*
FROM
    cliente c,
    pedido p
WHERE
    p.id_cliente = c.id
ORDER BY
    c.nombre ASC;

/*3. Devuelve un listado que muestre todos los pedidos en los que ha participado
 un co. El resultado debe mostrar todos los datos de los pedidos y de los
 comerciales. El listado debe mostrar los datos de los comerciales ordenados
 alfabéticamente.*/
SELECT
    c.*,
    p.*
FROM
    comercial c,
    pedido p
WHERE
    p.id_comercial = c.id
ORDER BY
    c.nombre ASC;

/*4. Devuelve un listado que muestre todos los clientes, con todos los pedidos que
 han realizado y con los datos de los comerciales asociados a cada pedido.*/
SELECT
    c.*,
    p.*,
    co.*
FROM
    cliente c,
    pedido p,
    comercial co
WHERE
    c.id = p.id_cliente
    AND p.id_comercial = co.id;

/*5. Devuelve un listado de todos los clientes que realizaron un pedido durante el
 año 2017, cuya cantidad esté entre 300 € y 1000 €.*/
SELECT
    c.*
FROM
    cliente c,
    pedido p
WHERE
    p.fecha LIKE '2017-%-%'
    AND p.total BETWEEN 300
    AND 1000;

/*6. Devuelve el nombre y los apellidos de todos los comerciales que han
 participado en algún pedido realizado por María Santana Moreno.*/
SELECT
    co.nombre,
    co.apellido1,
    co.apellido2
FROM
    comercial co,
    pedido p
    cliente c
WHERE
    p.id_comercial = co.id
    AND c.nombre LIKE 'María'
    AND c.apellido1 LIKE 'Santana'
    AND c.apellido2 LIKE 'Moreno';

/*7. Devuelve el nombre de todos los clientes que han realizado algún pedido con
 el comercial Daniel Sáez Vega*/
SELECT
    c.nombre,
    c.apellido1,
    c.apellido2
FROM
    cliente,
    comercial,
    pedido
WHERE
    cliente.id = pedido.id_cliente
    AND co.nombre LIKE 'Daniel'
    AND co.apellido1 LIKE 'Sáez'
    AND co.apellido2 LIKE 'Vega';

/*1. Devuelve un listado con todos los clientes junto con los datos de los pedidos
 que han realizado. Este listado también debe incluir los clientes que no han
 realizado ningún pedido. El listado debe estar ordenado alfabéticamente por
 el primer apellido, segundo apellido y nombre de los clientes.*/
SELECT
    c.*,
    p.*
FROM
    cliente c
    LEFT JOIN pedido p ON c.id = p.id_cliente
ORDER BY
    c.apellido1 ASC,
    c.apellido2 ASC,
    c.nombre ASC;

/*2. Devuelve un listado con todos los comerciales junto con los datos de los
 pedidos que han realizado. Este listado también debe incluir los comerciales
 que no han realizado ningún pedido. El listado debe estar ordenado
 alfabéticamente por el primer apellido, segundo apellido y nombre de los
 comerciales*/
SELECT
    co.*,
    p.*
FROM
    comercial co
    LEFT JOIN pedido p ON p.id_comercial = co.id
ORDER BY
    co.apellido1 ASC,
    co.apellido2 ASC,
    co.nombre ASC;

/*3. Devuelve un listado que solamente muestre los clientes que no han realizado
 ningún pedido.*/
SELECT
    c.*
FROM
    cliente c
    LEFT JOIN pedido p ON p.id_cliente = c.id
WHERE
    p.id_cliente IS NULL;

/*4. Devuelve un listado que solamente muestre los comerciales que no han
 realizado ningún pedido*/
SELECT
    co.*
FROM
    comercial co
    LEFT JOIN pedido p ON p.id_comercial = co.id
WHERE
    p.id_comercial IS NULL;

/*5. Devuelve un listado con los clientes que no han realizado ningún pedido y de los
 comerciales que no han participado en ningún pedido. Ordene el listado
 alfabéticamente por los apellidos y el nombre.*/
SELECT
    c.*,
    co.*
FROM
    cliente c
    INNER JOIN pedido p on p.id_cliente = c.id
    INNER JOIN comercial co ON p.id_comercial = co.id
ORDER BY
    c.apellido1 ASC,
    c.apellido2 ASC,
    c.nombre,
    co.apellido1 ASC,
    co.apellido2 ASC,
    co.nombre ASC;