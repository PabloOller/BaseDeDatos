/*Devuelve el nombre del cliente con mayor límite de crédito.*/
SELECT
    nombre_cliente
FROM
    cliente
WHERE
    limite_credito = (
        SELECT
            MAX(limite_credito)
        FROM
            cliente
    );

/*Devuelve el nombre del producto que tenga el precio de venta más caro.*/
SELECT
    nombre
FROM
    producto
WHERE
    precio_venta = (
        SELECT
            MAX(precio_venta)
        FROM
            producto
    );

/*Devuelve el nombre del producto del que se han vendido más unidades. 
 (Tenga en cuenta que tendrá que calcular cuál es el número total de unidades
 que se han vendido de cada producto a partir de los datos de la tabla detalle_pedido. 
 Una vez que sepa cuál es el código del producto, puede obtener su nombre fácilmente.)*/
SELECT
    nombre
FROM
    producto
WHERE
    codigo_producto = (
        SELECT
            codigo_producto
        FROM
            detalle_pedido
        WHERE
            cantidad = (
                SELECT
                    MAX(cantidad)
                FROM
                    detalle_pedido
            )
    );

/*Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin utilizar INNER JOIN).*/
SELECT
    *
FROM
    cliente
WHERE
    limite_credito > (
        SELECT
            SUM(total)
        FROM
            pago
    );

/*Devuelve el producto que más unidades tiene en stock.*/
SELECT
    *
FROM
    producto
WHERE
    cantidad_en_stock = (
        SELECT
            MAX(cantidad_en_stock)
        FROM
            producto
    )
LIMIT
    1;

/* LO LIMITO A 1 FILA PORQUE SALEN VARIOS*/
/*Devuelve el producto que menos unidades tiene en stock.*/
SELECT
    *
FROM
    producto
WHERE
    cantidad_en_stock = (
        SELECT
            MIN(cantidad_en_stock)
        FROM
            producto
    );

/*Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de Alberto Soria.*/
SELECT
    nombre,
    apellido1,
    apellido2,
    email,
    codigo_jefe
FROM
    empleado
WHERE
    codigo_jefe = (
        SELECT
            codigo_empleado
        FROM
            empleado
        WHERE
            nombre LIKE 'Alberto'
            AND apellido1 LIKE 'Soria'
    );

/*Devuelve el nombre del cliente con mayor límite de crédito.*/
SELECT
    nombre_cliente
FROM
    cliente
WHERE
    limite_credito = (
        SELECT
            MAX(limite_credito)
        FROM
            cliente
    );

/*Devuelve el nombre del producto que tenga el precio de venta más caro.*/
SELECT
    nombre
FROM
    producto
WHERE
    precio_venta = (
        SELECT
            MAX(precio_venta)
        FROM
            producto
    );

/*Devuelve el producto que menos unidades tiene en stock.*/
SELECT
    *
FROM
    producto
WHERE
    cantidad_en_stock = (
        SELECT
            MIN(cantidad_en_stock)
        FROM
            producto
    );

/*Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ningún cliente.*/
SELECT
    nombre,
    apellido1,
    puesto
FROM
    empleado
WHERE
    codigo_empleado <> ALL(
        SELECT
            codigo_empleado_rep_ventas
        FROM
            cliente
    );

/*Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.*/
SELECT
    *
FROM
    cliente
WHERE
    codigo_cliente <> ALL (
        SELECT
            DISTINCT(codigo_cliente)
        FROM
            pago
    );

/*Devuelve un listado que muestre solamente los clientes que sí han realizado ningún pago.*/
SELECT
    *
FROM
    cliente
WHERE
    codigo_cliente = ANY (
        SELECT
            DISTINCT(codigo_cliente)
        FROM
            pago
    );

/*Devuelve un listado de los productos que nunca han aparecido en un pedido.*/
SELECT
    *
FROM
    producto
WHERE
    codigo_producto <> ALL (
        SELECT
            DISTINCT(codigo_producto)
        FROM
            detalle_pedido
    );

/*Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.*/
SELECT
    e.nombre,
    e.apellido1,
    e.apellido2,
    e.puesto,
    o.telefono
FROM
    empleado e
    INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE
    e.codigo_empleado <> ALL (
        SELECT
            codigo_empleado_rep_ventas
        FROM
            cliente
    );

/*Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.*/
SELECT
    o.*
FROM
    oficina o
    JOIN empleado e ON o.codigo_oficina = e.codigo_oficina
WHERE
    e.codigo_empleado = ANY (
        SELECT
            codigo_empleado_rep_ventas
        FROM
            cliente
        WHERE
            codigo_cliente = ANY (
                SELECT
                    codigo_cliente
                FROM
                    pedido
                WHERE
                    codigo_pedido = ANY (
                        SELECT
                            codigo_pedido
                        FROM
                            detalle_pedido
                        WHERE
                            codigo_producto = ANY (
                                SELECT
                                    codigo_producto
                                FROM
                                    producto
                                WHERE
                                    gama = (
                                        SELECT
                                            gama
                                        FROM
                                            gama_producto
                                        WHERE
                                            gama LIKE 'Frutales'
                                    )
                            )
                    )
            )
    );

/*Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.*/
SELECT
    *
FROM
    cliente
WHERE
    codigo_cliente = ANY(
        SELECT
            DISTINCT(codigo_pedido)
        FROM
            detalle_pedido
    )
    AND codigo_cliente <> ALL (
        SELECT
            DISTINCT(codigo_cliente)
        FROM
            pago
    );

/*Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.*/
SELECT
    *
FROM
    cliente
WHERE
    codigo_cliente <> ALL (
        SELECT
            DISTINCT(codigo_cliente)
        FROM
            pago
    );

/*Devuelve un listado que muestre solamente los clientes que sí han realizado algun pago.*/
SELECT
    *
FROM
    cliente
WHERE
    codigo_cliente = ANY (
        SELECT
            DISTINCT(codigo_cliente)
        FROM
            pago
    );

/*Devuelve un listado de los productos que nunca han aparecido en un pedido.*/
SELECT
    *
FROM
    producto
WHERE
    codigo_producto <> ALL (
        SELECT
            DISTINCT(codigo_producto)
        FROM
            detalle_pedido
    );

/*Devuelve un listado de los productos que han aparecido en un pedido alguna vez.*/
SELECT
    *
FROM
    producto
WHERE
    codigo_producto = ANY (
        SELECT
            DISTINCT(codigo_producto)
        FROM
            detalle_pedido
    );