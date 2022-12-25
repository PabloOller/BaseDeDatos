/*1. Calcula la suma del presupuesto de todos los departamentos*/
SELECT
    SUM(presupuesto)
FROM
    departamento;

/*2. Calcula la media del presupuesto de todos los departamentos.*/
SELECT
    AVG(presupuesto)
FROM
    departamento;

/*3. Calcula el valor mínimo del presupuesto de todos los departamentos que sean distintos de cero.*/
SELECT
    min(presupuesto)
FROM
    departamento
WHERE
    presupuesto != 0;

/*4. Calcula el nombre del departamento y el presupuesto que tiene asignado, 
 del departamento con menor presupuesto distinto de cero.*/
SELECT
    nombre,
    MIN(presupuesto)
FROM
    departamento
GROUP BY
    nombre
HAVING
    COUNT(presupuesto > 0)
LIMIT
    1;

/*5. Calcula el valor máximo del presupuesto de todos los departamentos.*/
SELECT
    MAX(presupuesto)
FROM
    departamento;

/*6. Calcula el nombre del departamento y el presupuesto que tiene asignado, 
 del departamento con mayor presupuesto*/
SELECT
    nombre,
    MAX(presupuesto)
FROM
    departamento;

/*7. Calcula el número total de empleados que hay en la tabla empleado.*/
SELECT
    COUNT(codigo)
FROM
    empleado;

/*8. Calcula el número de empleados que no tienen NULL en su segundo apellido.*/
SELECT
    COUNT(apellido2)
FROM
    empleado
WHERE
    apellido2 IS NOT NULL;

/*9. Calcula el número de empleados que hay en cada departamento. Tienes que devolver dos columnas, 
 una con el nombre del departamento y otra con el número de empleados que tiene asignados.*/
SELECT
    d.nombre,
    COUNT(e.codigo)
FROM
    departamento d
    INNER JOIN empleado e
    JOIN d.codigo = e.codigo_departamento
GROUP BY
    d.nombre;

/*10. Calcula el nombre de los departamentos que tienen más de 2 empleados. El resultado debe tener dos columnas, 
 una con el nombre del departamento y otra con el número de empleados que tiene asignados.*/
SELECT
    d.nombre,
    COUNT(e.codigo)
FROM
    departamento d
    LEFT JOIN empleado e ON d.codigo = e.codigo_departamento
GROUP BY
    d.nombre
HAVING
    (COUNT(e.codigo) > 2);

/*11. Calcula el número de empleados que trabajan en cada uno de los departamentos. El resultado de esta 
 consulta también tiene que incluir aquellos departamentos que no tienen ningún empleado asociado.*/
SELECT
    d.nombre,
    COUNT(e.codigo)
FROM
    departamento d
    LEFT JOIN empleado e ON d.codigo = e.codigo_departamento
GROUP BY
    d.nombre;

/*12. Calcula el número de empleados que trabajan en cada uno de los departamentos que tienen un presupuesto 
 mayor a 200000 euros.*/
SELECT
    d.nombre,
    COUNT(e.codigo)
FROM
    departamento d
    INNER JOIN empleado e ON d.codigo = e.codigo_departamento
WHERE
    d.presupuesto > 200000
GROUP BY
    d.nombre;