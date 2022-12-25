/*⦁ Devuelve el número total de alumnas que hay.*/
SELECT
    COUNT(a.id_alumno)
FROM
    `alumno_se_matricula_asignatura` a
    INNER JOIN persona p ON p.id = a.id_alumno
WHERE
    p.sexo LIKE 'M';

/*
 ⦁ Calcula cuántos alumnos nacieron en 1999.*/
SELECT
    COUNT(a.id_alumno)
FROM
    `alumno_se_matricula_asignatura` a
    INNER JOIN persona p ON p.id = a.id_alumno
WHERE
    YEAR(p.fecha_nacimiento) = '1999';

/*
 ⦁ Calcula cuántos profesores hay en cada departamento. El resultado
 sólo debe mostrar dos columnas, una con el nombre del departamento
 y otra con el número de profesores que hay en ese departamento. El
 resultado sólo debe incluir los departamentos que tienen profesores
 asociados y deberá estar ordenado de mayor a menor por el número
 de profesores.*/
SELECT
    d.nombre,
    COUNT(p.id_profesor)
FROM
    departamento d
    RIGHT JOIN profesor p ON p.id_departamento = d.id
GROUP BY
    d.id
ORDER BY
    COUNT(p.id_profesor) DESC;

/*
 ⦁ Devuelve un listado con todos los departamentos y el número de
 profesores que hay en cada uno de ellos. Tenga en cuenta que
 pueden existir departamentos que no tienen profesores asociados.
 Estos departamentos también tienen que aparecer en el listado.
 */
SELECT
    d.nombre,
    COUNT(p.id_profesor)
FROM
    departamento d
    LEFT JOIN profesor p ON p.id_departamento = d.id
GROUP BY
    d.id;

/*
 ⦁ Devuelve un listado con el nombre de todos los grados existentes en
 la base de datos y el número de asignaturas que tiene cada uno.
 Tenga en cuenta que pueden existir grados que no tienen asignaturas
 asociadas. Estos grados también tienen que aparecer en el listado. El
 resultado deberá estar ordenado de mayor a menor por el número de
 asignaturas.*/
SELECT
    g.nombre,
    COUNT(a.id)
FROM
    grado g
    LEFT JOIN asignatura a ON a.id_grado = g.id
GROUP BY
    g.id
ORDER BY
    COUNT(a.id) DESC;

/*
 ⦁ Devuelve un listado con el nombre de todos los grados existentes en
 la base de datos y el número de asignaturas que tiene cada uno, de
 los grados que tengan más de 40 asignaturas asociadas.*/
SELECT
    g.nombre,
    COUNT(a.id)
FROM
    grado g
    LEFT JOIN asignatura a ON a.id_grado = g.id
GROUP BY
    g.id
HAVING
    COUNT(a.id) > 40;

/*
 ⦁ Devuelve un listado que muestre el nombre de los grados y la suma
 del número total de créditos que hay para cada tipo de asignatura. El
 resultado debe tener tres columnas: nombre del grado, tipo de
 asignatura y la suma de los créditos de todas las asignaturas que hay
 de ese tipo.*/
SELECT
    g.nombre,
    a.tipo,
    SUM(a.creditos)
FROM
    grado g
    LEFT JOIN asignatura a ON a.id_grado = g.id
GROUP BY
    a.tipo;

/*
 ⦁ Devuelve un listado que muestre cuántos alumnos se han matriculado
 de alguna asignatura en cada uno de los cursos escolares. El
 resultado deberá mostrar dos columnas, una columna con el año de
 inicio del curso escolar y otra con el número de alumnos matriculados.
 */
SELECT
    c.anyo_inicio,
    COUNT(a.id_alumno)
FROM
    curso_escolar c
    LEFT JOIN alumno_se_matricula_asignatura a ON a.id_curso_escolar = c.id
GROUP BY
    c.anyo_inicio;

/*
 ⦁ Devuelve un listado con el número de asignaturas que imparte cada
 profesor. El listado debe tener en cuenta aquellos profesores que no
 imparten ninguna asignatura. El resultado mostrará cinco columnas:
 id, nombre, primer apellido, segundo apellido y número de
 asignaturas. El resultado estará ordenado de mayor a menor por el
 número de asignaturas.
 */
SELECT
    p.id_profesor,
    COUNT(a.id)
FROM
    profesor p
    LEFT JOIN asignatura a ON p.id_profesor = a.id_profesor
GROUP BY
    p.id_profesor
ORDER BY
    (a.id) DESC;