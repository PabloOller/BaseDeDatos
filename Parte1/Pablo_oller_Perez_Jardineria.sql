/*1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su
 representante de ventas.*/
SELECT
    c.nombre_cliente,
    e.nombre,
    e.apellido1,
    e.apellido2
FROM
    cliente c
    INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado;

/*2. Muestra el nombre de los clientes que hayan realizado pagos junto con el
 nombre de sus representantes de ventas.*/
SELECT
    c.nombre_cliente,
    e.nombre,
    e.apellido1,
    e.apellido2
FROM
    cliente c
    INNER JOIN empleado e
    INNER JOIN pago p ON c.codigo_empleado_rep_ventas = e.codigo_empleado
where
    (c.codigo_cliente = p.codigo_cliente);

/*3. Muestra el nombre de los clientes que no hayan realizado pagos junto con el
 nombre de sus representantes de ventas*/
SELECT
    c.nombre_cliente,
    e.nombre,
    e.apellido1,
    e.apellido2
FROM
    cliente c,
    empleado e
WHERE
    c.codigo_empleado_rep_ventas = e.codigo_empleado
    AND e.puesto = 'Representante ventas'
    AND c.codigo_cliente NOT IN (
        SELECT
            codigo_cliente
        FROM
            pago
    );

/*4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus
 representantes junto con la ciudad de la oficina a la que pertenece el
 representante.*/
SELECT
    c.nombre_cliente,
    e.nombre,
    e.apellido1,
    e.apellido2,
    o.ciudad
FROM
    cliente c,
    empleado e,
    oficina o
WHERE
    c.codigo_empleado_rep_ventas = e.codigo_empleado
    AND e.puesto = 'Representante ventas'
    AND e.codigo_oficina = o.codigo_oficina
    AND c.codigo_cliente IN (
        SELECT
            codigo_cliente
        FROM
            pago
    );

/*5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre
 de sus representantes junto con la ciudad de la oficina a la que pertenece el
 representante.*/
SELECT
    c.nombre_cliente,
    e.nombre,
    e.apellido1,
    e.apellido2,
    o.ciudad
FROM
    cliente c,
    empleado e,
    oficina o
WHERE
    c.codigo_empleado_rep_ventas = e.codigo_empleado
    AND e.puesto = 'Representante ventas'
    AND e.codigo_oficina = o.codigo_oficina
    AND c.codigo_cliente NOT IN (
        SELECT
            codigo_cliente
        FROM
            pago
    );

/*6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.*/
SELECT
    o.linea_direccion1,
    o.linea_direccion2
FROM
    oficina o
    INNER JOIN empleado e ON o.codigo_oficina = e.codigo_oficina
    INNER JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE
    c.region = 'Fuenlabrada';

/*7. Devuelve el nombre de los clientes y el nombre de sus representantes junto
 con la ciudad de la oficina a la que pertenece el representante.*/
SELECT
    c.nombre_cliente,
    e.nombre,
    o.ciudad
FROM
    oficina o
    INNER JOIN empleado e ON o.codigo_oficina = e.codigo_oficina
    INNER JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE
    e.codigo_oficina = o.codigo_oficina;

/*8. Devuelve un listado con el nombre de los empleados junto con el nombre de
 sus jefes.*/
SELECT
    e.nombre AS 'nombre empleado',
    em.nombre AS 'nombre jefe'
FROM
    empleado e,
    empleado em
WHERE
    e.codigo_jefe = em.codigo_empleado;

/*9. Devuelve un listado que muestre el nombre de cada empleados, el nombre
 de su jefe y el nombre del jefe de su jefe.*/
SELECT
    e.nombre AS 'nombre empleado',
    em.nombre AS 'nombre jefe',
    emp.nombre AS 'nombre jefe del jefe'
FROM
    empleado e,
    empleado em,
    empleado emp
WHERE
    e.codigo_jefe = em.codigo_empleado
    AND em.codigo_jefe = emp.codigo_empleado;

/*10.Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo
 un pedido.*/
SELECT
    c.nombre_cliente
FROM
    cliente c
    INNER JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE
    p.fecha_entrega > p.fecha_esperada;

/*11.Devuelve un listado de las diferentes gamas de producto que ha comprado
 cada cliente.*/
SELECT
    DISTINCT c.nombre_cliente,
    (pr.gama)
FROM
    producto pr
    INNER JOIN detalle_pedido dp ON pr.codigo_producto = dp.codigo_producto
    INNER JOIN pedido p ON dp.codigo_pedido = p.codigo_pedido
    INNER JOIN cliente c ON c.codigo_cliente = p.codigo_cliente
WHERE
    c.codigo_cliente = p.codigo_cliente;

/*1. Devuelve un listado que muestre solamente los clientes que no han
 realizado ningún pago.*/
SELECT
    c.nombre_cliente
FROM
    cliente c
    LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
WHERE
    p.codigo_cliente IS NULL;

/*2. Devuelve un listado que muestre solamente los clientes que no han
 realizado ningún pedido*/
SELECT
    c.nombre_cliente
FROM
    cliente c
    LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE
    p.codigo_cliente IS NULL;

/*3. Devuelve un listado que muestre los clientes que no han realizado ningún
 pago y los que no han realizado ningún pedido.*/
SELECT
    c.nombre_cliente
FROM
    cliente c
    LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
    LEFT JOIN pedido pe ON c.codigo_cliente = pe.codigo_cliente
WHERE
    p.codigo_cliente IS NULL
    AND pe.codigo_cliente IS NULL;

/*4. Devuelve un listado que muestre solamente los empleados que no tienen
 una oficina asociada..*/
SELECT
    e.nombre
FROM
    empleado e
    RIGHT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE
    o.codigo_oficina NOT IN (
        SELECT
            codigo_oficina
        FROM
            oficina
    );

/*5. Devuelve un listado que muestre solamente los empleados que no tienen
 un cliente asociado.*/
SELECT
    e.nombre
FROM
    empleado e
    LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE
    e.codigo_empleado NOT IN (
        SELECT
            codigo_empleado_rep_ventas
        FROM
            cliente
    );

/*6. Devuelve un listado que muestre los empleados que no tienen un cliente
 asociado junto con los datos de la oficina donde trabajan.*/
SELECT
    e.nombre,
    o.codigo_oficina
FROM
    oficina o
    LEFT JOIN empleado e ON e.codigo_oficina = o.codigo_oficina
    LEFT JOIN cliente c ON c.codigo_empleado_rep_ventas = e.codigo_empleado
WHERE
    c.codigo_empleado_rep_ventas IS NULL;

/*7. Devuelve un listado que muestre los empleados que no tienen una oficina
 asociada y los que no tienen un cliente asociado.*/
SELECT
    e.*,
    em.*
FROM
    empleado em
    LEFT JOIN empleado e ON em.codigo_empleado = em.codigo_empleado
    LEFT JOIN cliente c ON c.codigo_empleado_rep_ventas = em.codigo_empleado
    LEFT JOIN oficina o ON o.codigo_oficina = e.codigo_oficina
WHERE
    c.codigo_empleado_rep_ventas IS NULL
    AND e.codigo_oficina IS NULL;
/*8. Devuelve un listado de los productos que nunca han aparecido en un
pedido*/
SELECT
    p.codigo_producto,
    dp.codigo_producto
FROM
    producto p
    LEFT JOIN detalle_pedido dp ON dp.codigo_producto = p.codigo_producto
WHERE
    dp.codigo_producto IS NULL;

/*9. Devuelve un listado de los productos que nunca han aparecido en un pedido. El
resultado debe mostrar el nombre, la descripción y la imagen del producto.*/
SELECT
    p.codigo_producto,
    p.descripcion
    dp.codigo_producto
FROM
    producto p
    LEFT JOIN detalle_pedido dp ON dp.codigo_producto = p.codigo_producto
WHERE
    dp.codigo_producto IS NULL;

/*10. Devuelve las oficinas donde no trabajan ninguno de los empleados que
 hayan sido los representantes de ventas de algún cliente que haya
 realizado la compra de algún producto de la gama Frutales..*/
SELECT
    o.*
FROM
    oficina o
    LEFT JOIN empleado e ON o.codigo_oficina = e.codigo_oficina
    RIGHT JOIN cliente c ON c.codigo_empleado_rep_ventas = e.codigo_empleado
WHERE
    e.codigo_empleado NOT IN (
        SELECT
            c.codigo_empleado_rep_ventas
        FROM
            cliente c
            LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
            RIGHT JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido
            RIGHT JOIN producto pr ON dp.codigo_producto = pr.codigo_producto
        WHERE
            pr.gama like 'Frutales'
    );

/*11. Devuelve un listado con los clientes que han realizado algún pedido pero
no han realizado ningún pago.*/
SELECT c.*
FROM
    cliente c
    LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
    LEFT JOIN pago pa ON pa.codigo_cliente = c.codigo_cliente
WHERE
    pa.codigo_cliente IS NULL
    AND p.codigo_cliente IS NOT NULL;

/*12. Devuelve un listado con los datos de los empleados que no tienen clientes
 asociados y el nombre de su jefe asociado.*/
SELECT
    e.*,
    em.nombre
FROM
    empleado e
    LEFT JOIN cliente c ON c.codigo_empleado_rep_ventas = e.codigo_empleado
    LEFT JOIN empleado em ON e.codigo_jefe = em.codigo_empleado
WHERE
    c.codigo_empleado_rep_ventas IS NULL;

