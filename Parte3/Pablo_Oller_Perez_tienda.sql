/*1. Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).*/
SELECT
    p.nombre
FROM
    producto p,
    fabricante f
WHERE
    f.nombre LIKE 'Lenovo';

/*2. Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del fabricante Lenovo. (Sin utilizar INNER JOIN).*/
SELECT
    p.*
FROM
    producto p,
    fabricante f
WHERE
    (f.nombre LIKE 'Lenovo')
    AND (
        p.precio = (
            SELECT
                MAX(precio)
            FROM
                producto p
        )
    );

/*3. Lista el nombre del producto más caro del fabricante Lenovo.*/
SELECT
    p.nombre,
    p.precio
FROM
    producto p
    INNER JOIN fabricante f ON f.codigo = p.codigo_fabricante
WHERE
    f.nombre LIKE 'Lenovo'
ORDER BY
    p.precio DESC
LIMIT
    1;

/*4. Lista el nombre del producto más barato del fabricante Hewlett-Packard.*/
SELECT
    nombre
FROM
    producto p
WHERE
    precio_venta = (
        SELECT
            MAX(precio_venta)
        FROM
            producto WHERE
    f.nombre LIKE 'Hewlett-Packard'
    );

ORDER BY
    precio ASC
LIMIT
    1;

/*5. Devuelve todos los productos de la base de datos que tienen un precio mayor o igual al producto más caro del fabricante Lenovo.*/
SELECT
    *
FROM
    producto p
WHERE
    precio > ALL (
        SELECT
            p.precio
        FROM
            producto p
            INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo
        WHERE
            f.nombre LIKE 'Lenovo'
    );

/*6. Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos.*/
SELECT
    p.*
FROM
    producto p
    INNER JOIN fabricante f ON f.codigo = p.codigo_fabricante
WHERE
    (f.nombre LIKE 'Asus')
    and p.precio > (
        SELECT
            AVG(pp.precio)
        FROM
            producto pp
            INNER JOIN fabricante f ON f.codigo = p.codigo_fabricante
        WHERE
            f.nombre LIKE 'Asus'
    );

/*7. Devuelve el producto más caro que existe en la tabla producto sin hacer uso de MAX, ORDER BY ni LIMIT.*/
SELECT
    p.*
FROM
    producto p
WHERE
    p.precio >= ALL (
        SELECT
            pp.precio
        FROM
            producto pp
    );

/*8. Devuelve el producto más barato que existe en la tabla producto sin hacer uso de MIN, ORDER BY ni LIMIT.*/
SELECT
    p.*
FROM
    producto p
WHERE
    p.precio <= ALL (
        SELECT
            pp.precio
        FROM
            producto pp
    );

/*9. Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando ALL o ANY*/
SELECT
    f.nombre
FROM
    fabricante f
WHERE
    f.codigo = any (
        SELECT
            p.codigo_fabricante
        FROM
            producto p
    );

/*10. Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando ALL o ANY).*/
SELECT
    nombre
FROM
    fabricante f
WHERE
    codigo <> ALL (
        SELECT
            codigo_fabricante
        FROM
            producto p
    );

/*11. Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT IN).*/
SELECT
    f.nombre
FROM
    fabricante f
WHERE
    f.codigo IN (
        SELECT
            p.codigo_fabricante
        FROM
            producto p
    );

/*12. Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando IN o NOT IN).*/
SELECT
    f.nombre
FROM
    fabricante f
WHERE
    f.codigo NOT IN (
        SELECT
            p.codigo_fabricante
        FROM
            producto p
    );

/*13. Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando EXISTS o NOT EXISTS).*/
SELECT
    f.nombre
FROM
    fabricante f
WHERE
    EXISTS (
        SELECT
            p.codigo_fabricante
        FROM
            producto p
        WHERE
            f.codigo = p.codigo_fabricante
    );

/*14. Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando EXISTS o NOT EXISTS).*/
SELECT
    f.nombre
FROM
    fabricante f
WHERE
    NOT EXISTS (
        SELECT
            p.codigo_fabricante
        FROM
            producto p
        WHERE
            f.codigo = p.codigo_fabricante
    );