/*1. Devuelve un listado con los datos de todas las alumnas que se han
 matriculado alguna vez en el Grado en Ingeniería Informática (Plan
 2015).*/
SELECT
    *
FROM
    persona p
    INNER JOIN alumno_se_matricula_asignatura am ON p.id = am.id_alumno
    INNER JOIN asignatura a ON am.id_asignatura = a.id
    INNER JOIN grado g ON g.id
WHERE
    g.nombre LIKE "Grado en Ingeniería Informática (Plan 2015)";

/*2. Devuelve un listado con todas las asignaturas ofertadas en el Grado en
 Ingeniería Informática (Plan 2015).*/
SELECT
    *
FROM
    asignatura a
    INNER JOIN grado g ON a.id_grado = g.id;

/*3. Devuelve un listado de los profesores junto con el nombre del departamento
 al que están vinculados. El listado debe devolver cuatro columnas, primer
 apellido, segundo apellido, nombre y nombre del departamento. El resultado
 estará ordenado alfabéticamente de menor a mayor por los apellidos y el
 nombre*/
SELECT
    pe.apellido1,
    pe.apellido2,
    pe.nombre,
    d.nombre AS 'Nombre Departamento'
FROM
    profesor p
    INNER JOIN persona pe ON pe.id = p.id_profesor
    INNER JOIN departamento d ON d.id = p.id_departamento;

/*4. Devuelve un listado con el nombre de las asignaturas, año de inicio y año de
 fin del curso escolar del alumno con nif 26902806M.*/
SELECT
    a.nombre,
    c.anyo_inicio,
    c.anyo_fin
FROM
    asignatura a
    INNER JOIN alumno_se_matricula_asignatura al ON a.id = al.id_asignatura
    INNER JOIN persona p ON p.id = al.id_alumno
    INNER JOIN curso_escolar c ON c.id = al.id_curso_escolar
WHERE
    p.nif LIKE '26902806M';

/*5. Devuelve un listado con el nombre de todos los departamentos que tienen
 profesores que imparten alguna asignatura en el Grado en Ingeniería
 Informática (Plan 2015).*/
SELECT
    d.nombre
FROM
    departamento d
    INNER JOIN profesor p ON p.id_departamento = d.id
    INNER JOIN asignatura a ON a.id_profesor = p.id_profesor
    INNER JOIN grado g ON g.id = a.id_grado
WHERE
    g.nombre LIKE "Grado en Ingeniería Informática (Plan 2015)";

/*6. Devuelve un listado con todos los alumnos que se han matriculado en alguna
 asignatura durante el curso escolar 2018/2019.*/
SELECT
    p.nombre
FROM
    persona p
    INNER JOIN alumno_se_matricula_asignatura al ON al.id_alumno = p.id
    INNER JOIN curso_escolar c ON c.id = al.id_curso_escolar
WHERE
    c.anyo_inicio LIKE '2018'
    AND c.anyo_fin LIKE '2019';


/*1. Devuelve un listado con los nombres de todos los profesores y los
 departamentos que tienen vinculados. El listado también debe mostrar
 aquellos profesores que no tienen ningún departamento asociado. El
 listado debe devolver cuatro columnas, nombre del departamento, primer
 apellido, segundo apellido y nombre del profesor. El resultado estará
 ordenado alfabéticamente de menor a mayor por el nombre del
 departamento, apellidos y el nombre.*/
SELECT
    d.nombre,
    pe.apellido1,
    pe.apellido2,
    pe.nombre
FROM
    profesor p
    LEFT JOIN persona pe ON p.id_profesor = pe.id
    LEFT JOIN departamento d ON d.id = p.id_departamento
ORDER BY
    d.nombre,
    pe.apellido1,
    pe.nombre ASC;

/*2. Devuelve un listado con los profesores que no están asociados a un
 departamento.*/
SELECT
    p.*
FROM
    profesor p
    LEFT JOIN departamento d ON p.id_departamento = d.id
WHERE
    p.id_profesor IS NULL;

/*3. Devuelve un listado con los departamentos que no tienen profesores
 asociados.*/
SELECT
    d.*
FROM
    profesor p
    RIGHT JOIN departamento d ON p.id_departamento = d.id
WHERE
    p.id_profesor IS NULL;

/*4. Devuelve un listado con los profesores que no imparten ninguna
 asignatura.
 */
SELECT
    p.*
FROM
    profesor p
    LEFT JOIN asignatura a ON p.id_departamento = a.id_profesor
WHERE
    a.id IS NULL;

/*5. Devuelve un listado con las asignaturas que no tienen un profesor
 asignado.*/
SELECT
    a.*
FROM
    profesor p
    RIGHT JOIN asignatura a ON p.id_departamento = a.id_profesor
WHERE
    a.id_profesor IS NULL;

