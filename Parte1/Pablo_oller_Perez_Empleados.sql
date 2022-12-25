/*1. Devuelve un listado con los empleados y los datos de los departamentos donde trabaja
 cada uno.*/
SELECT
    *
FROM
    empleado e
    LEFT JOIN departamento d ON e.codigo_departamento = d.codigo;

/* 2 Devuelve un listado con los empleados y los datos de los departamentos donde trabaja
 cada uno. Ordena el resultado, en primer lugar por el nombre del departamento (en orden
 alfabético) y en segundo lugar por los apellidos y el nombre de los empleados.
 */
SELECT
    *
FROM
    empleado e
    LEFT JOIN departamento d ON e.codigo_departamento = d.codigo
ORDER BY
    d.nombre,
    concat_ws(
        ' ',
        e.apellido1,
        e.apellido2,
        e.nombre
    ) ASC;

/*3. Devuelve un listado con el código y el nombre del departamento, solamente de aquellos
 departamentos que tienen empleados*/
SELECT
    d.nombre,
    d.codigo
FROM
    departamento d,
    empleado e
WHERE
    e.codigo_departamento = d.codigo;

/*4. Devuelve un listado con el código, el nombre del departamento y el valor del presupuesto
 actual del que dispone, solamente de aquellos departamentos que tienen empleados.*/
SELECT
    d.codigo,
    d.nombre,
    (d.presupuesto - d.gastos) AS 'presupuesto act'
FROM
    departamento d,
    empleado e
WHERE
    e.codigo_departamento = d.codigo;

/*
 5. Devuelve el nombre del departamento donde trabaja el empleado que tiene el nif 38382980M.
 */
SELECT
    d.nombre
FROM
    departamento d,
    empleado e
WHERE
    e.nif LIKE '38382980M';

/*6. Devuelve el nombre del departamento donde trabaja el empleado Pepe Ruiz Santana*/
SELECT
    d.nombre
FROM
    departamento d,
    empleado e
WHERE
    e.nombre LIKE 'Pepe'
    AND e.apellido1 LIKE 'Ruiz'
    AND e.apellido2 LIKE 'Santana';

/*7. Devuelve un listado con los datos de los empleados que trabajan en el departamento de 
 I+D. Ordena el resultado alfabéticamente.*/
SELECT
    e.*
FROM
    empleado e,
    departamento d
WHERE
    d.nombre LIKE 'i+d'
ORDER BY
    e.nombre ASC;

/*8. Devuelve un listado con los datos de los empleados que trabajan en el departamento de 
 Sistemas, Contabilidad o I+D. Ordena el resultado alfabéticamente.*/
SELECT
    e.*
FROM
    empleado e,
    departamento d
WHERE
    d.nombre LIKE 'Sistemas'
    OR d.nombre LIKE 'Contabilidad'
    OR d.nombre LIKE 'i+d';

/*9. Devuelve una lista con el nombre de los empleados que tienen los departamentos que no 
 tienen un presupuesto entre 100000 y 200000 euros.*/
SELECT
    e.nombre,
FROM
    empleado e,
    departamento d
WHERE
    d.presupuesto BETWEEN 100000
    AND 200000;

/*10. Devuelve un listado con el nombre de los departamentos donde existe algún empleado 
 cuyo segundo apellido sea NULL. Tenga en cuenta que no debe mostrar nombres de 
 departamentos que estén repetidos.*/
SELECT
    DISTINCT(d.nombre) AS 'nombre departamento'
FROM
    departamento d,
    empleado e
WHERE
    e.apellido2 IS NULL;

/*1. Devuelve un listado con todos los empleados junto con los datos de los 
 departamentos donde trabajan. Este listado también debe incluir los 
 empleados que no tienen ningún departamento asociado*/
SELECT
    e.*,
    d.*
FROM
    empleado e
    LEFT JOIN departamento d ON e.codigo_departamento = d.codigo;

/*2. Devuelve un listado donde sólo aparezcan aquellos empleados que no tienen 
 ningún departamento asociado.*/
SELECT
    e.*
FROM
    empleado e
    LEFT JOIN departamento d ON e.codigo_departamento = d.codigo
WHERE
    e.codigo_departamento IS NULL;

/*3. Devuelve un listado donde sólo aparezcan aquellos departamentos que no 
 tienen ningún empleado asociado.*/
SELECT
    d.*
FROM
    departamento d
    LEFT JOIN empleado e ON d.codigo = e.codigo_departamento
WHERE
    e.codigo_departamento IS NULL;

/*4. Devuelve un listado con todos los empleados junto con los datos de los 
 departamentos donde trabajan. El listado debe incluir los empleados que no
 tienen ningún departamento asociado y los departamentos que no tienen 
 ningún empleado asociado. Ordene el listado alfabéticamente por el nombre 
 del departamento*/
(
    SELECT
        e.*,
        d.*
    FROM
        empleado e
        LEFT JOIN departamento d ON d.codigo = e.codigo_departamento
    ORDER BY
        d.nombre
)
union
(
    SELECT
        e.*,
        d.*
    FROM
        empleado e
        RIGHT JOIN departamento d ON d.codigo = e.codigo_departamento
    ORDER BY
        d.nombre
);

/*5. Devuelve un listado con los empleados que no tienen ningún departamento 
 asociado y los departamentos que no tienen ningún empleado asociado. 
 Ordene el listado alfabéticamente por el nombre del departamento*/
(
    SELECT
        e.*,
        d.*
    FROM
        empleado e
        LEFT JOIN departamento d on d.codigo = e.codigo_departamento
    WHERE
        e.codigo_departamento IS NULL
    ORDER BY
        d.nombre
)
UNION
(
    SELECT
        e.*,
        d.*
    FROM
        empleado e
        RIGHT JOIN departamento d on d.codigo = e.codigo_departamento
    WHERE
        e.codigo_departamento IS NULL
    ORDER BY
        d.nombre
);