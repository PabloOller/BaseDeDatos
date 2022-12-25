/*Devuelve un listado con todos los empleados que tiene el departamento de Sistemas. (Sin utilizar INNER JOIN).
 */
SELECT
    *
FROM
    empleado
WHERE
    codigo_departamento = (
        SELECT
            codigo_departamento
        FROM
            departamento
        WHERE
            nombre LIKE 'Sistemas'
    );

/*Devuelve el nombre del departamento con mayor presupuesto y la cantidad que tiene asignada*/
SELECT
    nombre,
    presupuesto
FROM
    departamento
WHERE
    presupuesto = (
        SELECT
            MAX(presupuesto)
        FROM
            departamento
    );

/*Devuelve el nombre del departamento con menor presupuesto y la cantidad que tiene asignada.*/
SELECT
    nombre,
    presupuesto
FROM
    departamento
WHERE
    presupuesto = (
        SELECT
            MIN(presupuesto)
        FROM
            departamento
    );

/*Devuelve el nombre del departamento con mayor presupuesto y la cantidad que tiene asignada. Sin hacer uso de MAX, ORDER BY ni LIMIT.*/
SELECT
    nombre,
    presupuesto
FROM
    departamento
WHERE
    presupuesto >= ALL (
        SELECT
            presupuesto
        FROM
            departamento
    );

/*Devuelve el nombre del departamento con menor presupuesto y la cantidad que tiene asignada. Sin hacer uso de MAX, ORDER BY ni LIMIT.*/
SELECT
    nombre,
    presupuesto
FROM
    departamento
WHERE
    presupuesto <= ALL (
        SELECT
            presupuesto
        FROM
            departamento
    );

/*Devuelve los nombres de los departamentos que tienen empleados asociados. (Utilizando ALL o ANY).*/
SELECT
    nombre
FROM
    departamento
WHERE
    codigo = ANY(
        SELECT
            codigo_departamento
        FROM
            empleado
    );

/*Devuelve los nombres de los departamentos que no tienen empleados asociados. (Utilizando ALL o ANY).*/
SELECT
    d.nombre
FROM
    departamento d
WHERE
    d.codigo <> ALL (
        SELECT
            e.codigo_departamento
        FROM
            empleado e
        WHERE
            e.codigo_departamento = d.codigo
    );

/*Devuelve los nombres de los departamentos que tienen empleados asociados. (Utilizando IN o NOT IN).*/
SELECT
    nombre
FROM
    departamento
WHERE
    codigo IN (
        SELECT
            codigo_departamento
        FROM
            empleado
    );

/*Devuelve los nombres de los departamentos que no tienen empleados asociados. (Utilizando IN o NOT IN).*/
SELECT
    d.nombre
FROM
    departamento d
WHERE
    d.codigo NOT IN (
        SELECT
            e.codigo_departamento
        FROM
            empleado e
        WHERE
            e.codigo_departamento = d.codigo
    );

/*Devuelve los nombres de los departamentos que tienen empleados asociados. (Utilizando EXISTS o NOT EXISTS).*/
SELECT
    d.nombre
FROM
    departamento d
WHERE
    EXISTS (
        SELECT
            e.codigo_departamento
        FROM
            empleado e
        WHERE
            e.codigo_departamento = d.codigo
    );

/*Devuelve los nombres de los departamentos que no tienen empleados asociados. (Utilizando EXISTS o NOT EXISTS).*/
SELECT
    d.nombre
FROM
    departamento d
WHERE
    NOT EXISTS (
        SELECT
            e.codigo_departamento
        FROM
            empleado e
        WHERE
            e.codigo_departamento = d.codigo
    );