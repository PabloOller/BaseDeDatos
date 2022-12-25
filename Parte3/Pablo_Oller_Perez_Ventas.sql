/*1. Devuelve un listado con todos los pedidos que ha realizado Adela Salas Díaz. (Sin utilizar INNER JOIN).*/
SELECT
    p.*
FROM
    pedido p,
    cliente c
WHERE
    (p.id_cliente = c.id) & & (
        c.nombre LIKE 'Adela' & & c.apellido1 LIKE 'Salas' & & c.apellido2 LIKE 'Díaz'
    );

/*2. Devuelve el número de pedidos en los que ha participado el comercial Daniel Sáez Vega. (Sin utilizar INNER JOIN)*/
SELECT
    COUNT(id)
FROM
    pedido p
WHERE
    p.id_comercial = (
        SELECT
            c.id
        FROM
            comercial c
        WHERE
            c.nombre LIKE 'Daniel' & & c.apellido1 LIKE 'Sáez'
    );

/*3. Devuelve los datos del cliente que realizó el pedido más caro en el año 2019. (Sin utilizar INNER JOIN)*/
SELECT
    c.*
FROM
    cliente c,
    pedido p
WHERE
    c.id = p.id_cliente & & p.total = (
        SELECT
            MAX(p.total)
        FROM
            pedido
        WHERE
            (year(p.fecha) = 2019)
    );

/*4. Devuelve la fecha y la cantidad del pedido de menor valor realizado por el cliente Pepe Ruiz Santana*/
SELECT
    p.fecha,
    p.total
FROM
    pedido p
WHERE
    p.id_cliente = (
        SELECT
            c.id
        FROM
            cliente c
        WHERE
            c.nombre LIKE 'Pepe' & & c.apellido1 LIKE 'Ruiz'
    )
ORDER BY
    p.total ASC
LIMIT
    1;

/*5. Devuelve un listado con los datos de los clientes y los pedidos, de todos los clientes que han realizado un pedido durante el año 2017 con un valor mayor o igual al valor medio de los pedidos realizados durante ese mismo año.*/
SELECT
    c.*,
    p.*
FROM
    cliente c
    INNER JOIN pedido p ON c.id = p.id_cliente
WHERE
    year(p.fecha) = 2017 & & p.total >= (
        SELECT
            avg(pp.total)
        FROM
            pedido pp
        WHERE
            year(pp.fecha) = 2017
    );

/*6. Devuelve el pedido más caro que existe en la tabla pedido si hacer uso de MAX, ORDER BY ni LIMIT.*/
SELECT
    p.*
FROM
    pedido p
WHERE
    total >= ALL (
        SELECT
            total
        FROM
            pedido
    );

/*7. Devuelve un listado de los clientes que no han realizado ningún p. (Utilizando ANY o ALL).*/
SELECT
    c.*
FROM
    cliente c
WHERE
    id <> ALL (
        SELECT
            id_cliente
        FROM
            pedido
    );

/*8. Devuelve un listado de los comerciales que no han realizado ningún p. (Utilizando ANY o ALL).*/
SELECT
    co.*
FROM
    comercial co
WHERE
    co.id <> ALL (
        SELECT
            p.id_comercial
        FROM
            pedido p
    );

/*9. Devuelve un listado de los clientes que no han realizado ningún p. (Utilizando IN o NOT IN).*/
SELECT
    c.*
FROM
    cliente c
WHERE
    c.id NOT IN (
        SELECT
            p.id_cliente
        FROM
            pedido p
    );

/*10. Devuelve un listado de los comerciales que no han realizado ningún p. (Utilizando IN o NOT IN).*/
SELECT
    co.*
FROM
    comercial co
WHERE
    co.id NOT IN (
        SELECT
            p.id_comercial
        FROM
            pedido p
    );

/*11. Devuelve un listado de los clientes que no han realizado ningún p. (Utilizando EXISTS o NOT EXISTS).*/
SELECT
    c.*
FROM
    cliente c
WHERE
    NOT EXISTS (
        SELECT
            p.id_cliente
        FROM
            pedido p
        WHERE
            c.id = p.id_cliente
    );

/*12. Devuelve un listado de los comerciales que no han realizado ningún p. (Utilizando EXISTS o NOT EXISTS).*/
SELECT
    co.*
FROM
    comercial co
WHERE
    NOT EXISTS (
        SELECT
            p.id_comercial
        FROM
            pedido p
        WHERE
            co.id = p.id_comercial
    );