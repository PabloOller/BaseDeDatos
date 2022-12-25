/*1. ⦁	¿Cuántos empleados hay en la compañía?*/
SELECT
    COUNT(codigo_empleado)
FROM
    empleado;

/*2. ⦁	¿Cuántos clientes tiene cada país?*/
SELECT
    o.pais,
    COUNT(empleado.codigo_empleado)
FROM
    oficina o
    LEFT JOIN empleado e ON o.codigo_oficina = e.codigo_oficina
GROUP BY
    o.pais;

/*3. ⦁	¿Cuál fue el pago medio en 2009?*/
SELECT
    AVG(total)
FROM
    pago
WHERE
    YEAR(fecha_pago) = "2009";

/*4. ⦁	¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.
 */
SELECT
    estado,
    COUNT(estado)
FROM
    pedido
GROUP BY
    estado;

/*5. ⦁	Calcula el precio de venta del producto más caro y más barato en una misma consulta*/
SELECT
    MAX(precio_venta),
    MIN(precio_venta)
FROM
    producto;

/*6. ⦁	Calcula el número de clientes que tiene la empresa.*/
SELECT
    COUNT(codigo_cliente)
FROM
    cliente;

/*7 ⦁   ¿Cuántos clientes tiene la ciudad de Madrid?*/
SELECT
    COUNT(codigo_cliente)
FROM
    cliente
WHERE
    ciudad LIKE 'Madrid';

/*8. ⦁	¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?*/
SELECT
    COUNT(codigo_cliente)
FROM
    cliente
WHERE
    ciudad LIKE 'M%';

/*9. ⦁	Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende cada uno.*/
SELECT
    e.nombre,
    COUNT(c.codigo_cliente)
FROM
    empleado e
    INNER JOIN cliente c ON c.codigo_empleado_rep_ventas
WHERE
    c.codigo_empleado_rep_ventas = e.codigo_empleado
GROUP BY
    e.nombre;

/*10. ⦁	Calcula el número de clientes que no tiene asignado representante de ventas.*/
SELECT
    COUNT(codigo_empleado_rep_ventas)
FROM
    cliente
WHERE
    codigo_empleado_rep_ventas IS NULL;

/*11. ⦁	Calcula la fecha del primer y último pago realizado por cada uno de los clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.*/
SELECT
    c.nombre_contacto,
    c.apellido_contacto,
    MIN(p.fecha_pago),
    MAX(p.fecha_pago)
FROM
    cliente c
    INNER JOIN pago p ON c.codigo_cliente = p.codigo_cliente
GROUP BY
    c.nombre_contacto;

/*12. ⦁	Calcula el número de productos diferentes que hay en cada uno de los pedidos.*/
SELECT
    codigo_pedido,
    COUNT(codigo_producto)
FROM
    detalle_pedido
GROUP BY
    codigo_pedido;

/*13. ⦁	Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.*/
SELECT
    codigo_pedido,
    COUNT(codigo_producto),
    SUM(precio_unidad)
FROM
    detalle_pedido
GROUP BY
    codigo_pedido;

/*14. ⦁	Devuelve un listado de los 20 productos más vendidos y el número total de unidades que se han vendido de cada uno. El listado deberá estar ordenado por el número total de unidades vendidas.*/
SELECT
    codigo_producto,
    SUM(cantidad)
FROM
    detalle_pedido
GROUP BY
    codigo_producto
ORDER BY
    COUNT(codigo_producto) DESC
LIMIT
    20;

/*15. ⦁	La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el IVA y el 
 total facturado. La base imponible se calcula sumando el coste del producto por el número de unidades vendidas 
 de la tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la suma de los dos campos 
 anteriores.*/
SELECT
    SUM(cantidad * precio_unidad) AS 'BASE IMPOSIBLE',
    (
        SUM(cantidad * precio_unidad) - (SUM(cantidad * precio_unidad) * 0.79)
    ) AS 'IVA',
    (
        SUM(cantidad * precio_unidad) + (
            SUM(cantidad * precio_unidad) - (SUM(cantidad * precio_unidad) * 0.79)
        )
    ) AS 'Total'
FROM
    detalle_pedido;

/*16. La misma información que en la pregunta anterior, pero agrupada por código de producto.*/
SELECT
    SUM(cantidad * precio_unidad) AS 'BASE IMPOSIBLE',
    (
        SUM(cantidad * precio_unidad) - (SUM(cantidad * precio_unidad) * 0.79)
    ) AS 'IVA',
    (
        SUM(cantidad * precio_unidad) + (
            SUM(cantidad * precio_unidad) - (SUM(cantidad * precio_unidad) * 0.79)
        )
    ) AS 'Total'
FROM
    detalle_pedido
GROUP BY
    codigo_producto;

/*17. La misma información que en la pregunta anterior, pero agrupada por código de producto 
 filtrada por los códigos que empiecen por OR.*/
SELECT
    SUM(cantidad * precio_unidad) AS 'BASE IMPOSIBLE',
    (
        SUM(cantidad * precio_unidad) - (SUM(cantidad * precio_unidad) * 0.79)
    ) AS 'IVA',
    (
        SUM(cantidad * precio_unidad) + (
            SUM(cantidad * precio_unidad) - (SUM(cantidad * precio_unidad) * 0.79)
        )
    ) AS 'Total'
FROM
    detalle_pedido
GROUP BY
    codigo_producto
HAVING
    codigo_producto LIKE 'OR%';

/*18. Lista las ventas totales de los productos que hayan facturado más de 3000 euros. Se mostrará el nombre, 
 unidades vendidas, total facturado y total facturado con impuestos (21% IVA).*/
SELECT
    p.nombre,
    COUNT(dp.codigo_producto) AS 'UNIDADES VENDIDAS',
    SUM(dp.cantidad * dp.precio_unidad) AS 'TOTAL FACTURADO',
    (
        SUM(dp.cantidad * dp.precio_unidad) - (SUM(dp.cantidad * dp.precio_unidad) * 0.79)
    ) AS 'IVA'
FROM
    detalle_pedido dp
    INNER JOIN producto p ON p.codigo_producto = dp.codigo_producto
GROUP BY
    p.nombre
HAVING
    SUM(dp.cantidad * dp.precio_unidad) > 3000;