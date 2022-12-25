-- Calcula la cantidad total de todos los pedidos que aparecen en la tabla pedido.
SELECT
    SUM(total)
FROM
    pedido;

-- Calcula la cantidad media de todos los pedidos que aparecen en la tabla pedido.
SELECT
    AVG(total)
FROM
    pedido;

-- Calcula el número total de comerciales distintos que aparecen en la tabla pedido.
SELECT
    COUNT(id_comercial)
FROM
    pedido;

-- Calcula el número total de clientes que aparecen en la tabla cliente.
SELECT
    COUNT(id)
FROM
    cliente;

-- Calcula cuál es la mayor cantidad que aparece en la tabla pedido.
SELECT
    MAX(total)
FROM
    pedido;

-- Calcula cuál es la menor cantidad que aparece en la tabla pedido.
SELECT
    MIN(total)
FROM
    pedido;

/*Calcula cuál es el valor máximo de categoría para cada una de las
 ciudades que aparece en la tabla cliente*/
SELECT
    ciudad,
    MAX(categoría)
FROM
    cliente
GROUP BY
    ciudad;

/*Calcula cuál es el máximo valor de los pedidos realizados durante el
 mismo día para cada uno de los clientes. Es decir, el mismo cliente
 puede haber realizado varios pedidos de diferentes cantidades el
 mismo día. Se pide que se calcule cuál es el pedido de máximo valor
 para cada uno de los días en los que un cliente ha realizado un
 pedido. Muestra el identificador del cliente, nombre, apellidos, la fecha
 y el valor de la cantidad.
 */
SELECT
    c.nombre,
    c.apellido1,
    c.apellido2,
    p.fecha,
    MAX(p.total)
FROM
    cliente c
    INNER JOIN pedido p ON p.id_cliente = c.id
GROUP BY
    c.id;

/*Calcula cuál es el máximo valor de los pedidos realizados durante el
 mismo día para cada uno de los clientes, teniendo en cuenta que sólo
 queremos mostrar aquellos pedidos que superen la cantidad de 2000
 €.
 */
SELECT
    c.nombre,
    c.apellido1,
    c.apellido2,
    p.fecha,
    MAX(p.total)
FROM
    cliente c
    INNER JOIN pedido p ON p.id_cliente = c.id
GROUP BY
    c.id
HAVING
    MAX(p.total) > 2000;

/*Calcula el máximo valor de los pedidos realizados para cada uno de
 los comerciales durante la fecha 2016-08-17. Muestra el identificador
 del comercial, nombre, apellidos y total.
 */
SELECT
    co.id,
    co.nombre,
    co.apellido1,
    co.apellido2,
    MAX(p.total)
FROM
    comercial co
    INNER JOIN pedido p ON p.id_comercial = co.id
WHERE
    p.fecha LIKE ('2016-08-17')
GROUP BY
    co.id;

/*Devuelve un listado con el identificador de cliente, nombre y apellidos
 y el número total de pedidos que ha realizado cada uno de clientes.
 Tenga en cuenta que pueden existir clientes que no han realizado
 ningún pedido. Estos clientes también deben aparecer en el listado
 indicando que el número de pedidos realizados es 0.
 */
SELECT
    c.id,
    c.nombre,
    c.apellido1,
    c.apellido2,
    COUNT(p.id)
FROM
    cliente c
    LEFT JOIN pedido p ON p.id_cliente = c.id
GROUP BY
    c.id;

/*Devuelve un listado con el identificador de cliente, nombre y apellidos
 y el número total de pedidos que ha realizado cada uno de clientes
 durante el año 2017.
 */
SELECT
    c.id,
    c.nombre,
    c.apellido1,
    c.apellido2,
    COUNT(p.id)
FROM
    cliente c
    LEFT JOIN pedido p ON p.id_cliente = c.id
WHERE
    YEAR(p.fecha) = 2017
GROUP BY
    c.id;

/*Devuelve un listado que muestre el identificador de cliente, nombre,
 primer apellido y el valor de la máxima cantidad del pedido realizado
 por cada uno de los clientes. El resultado debe mostrar aquellos
 clientes que no han realizado ningún pedido indicando que la máxima
 cantidad de sus pedidos realizados es 0. Puede hacer uso de la
 función IFNULL.*/
SELECT
    c.id,
    c.nombre,
    c.apellido1,
    MAX(p.total),
    COUNT(p.id)
FROM
    cliente c
    LEFT JOIN pedido p ON p.id_cliente = c.id
GROUP BY
    c.id;

/*Devuelve cuál ha sido el pedido de máximo valor que se ha realizado
 cada año.
 */
SELECT
    MAX(p.total)
FROM
    pedido p
GROUP BY
    year(p.fecha);