/*Devuelve todos los datos del alumno más joven.*/
SELECT
    *
FROM
    persona
WHERE
    fecha_nacimiento = (
        SELECT
            MAX(p.fecha_nacimiento)
        FROM
            persona p
    )
    AND id IN (
        SELECT
            DISTINCT(id_alumno)
        FROM
            alumno_se_matricula_asignatura
    );

/*Devuelve un listado con los profesores que no están asociados a un departamento.*/
SELECT
    *
FROM
    profesor
WHERE
    id_departamento NOT IN (
        SELECT
            id
        FROM
            departamento
    );

/*Devuelve un listado con los departamentos que no tienen profesores asociados.*/
SELECT
    *
FROM
    departamento
WHERE
    id NOT IN (
        SELECT
            id_departamento
        FROM
            profesor
    );

/*Devuelve un listado con los profesores que tienen un departamento asociado y que no imparten ninguna asignatura.*/
SELECT
    *
FROM
    profesor
WHERE
    id_departamento IN (
        SELECT
            id
        FROM
            departamento
    )
    AND id_profesor NOT IN (
        SELECT
            id_profesor
        FROM
            asignatura
        WHERE
            id_profesor IS NOT NULL
    );

/*Devuelve un listado con las asignaturas que no tienen un profesor asignado.*/
SELECT
    *
FROM
    asignatura
WHERE
    id_profesor IS NULL;

/*Devuelve un listado con todos los departamentos que no han impartido asignaturas en ningún curso escolar.*/
SELECT
    *
FROM
    departamento
WHERE
    id NOT IN (
        SELECT
            p.id_departamento
        FROM
            profesor p
            JOIN asignatura a ON p.id_profesor = a.id_profesor
            JOIN alumno_se_matricula_asignatura am ON a.id = am.id_asignatura
            JOIN curso_escolar c ON am.id_curso_escolar = c.id
    );