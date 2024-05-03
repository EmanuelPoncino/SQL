USE playground;

-- Obtener los 5 cursos con más unidades (lamentablemente sembre todo con 10 unidades)
SELECT c.titulo, COUNT(u.id) as unidades_total
FROM cursos c
JOIN unidades u
ON c.id = u.cursos_id
GROUP BY c.id, c.titulo
ORDER BY unidades_total DESC
LIMIT 5;

-- Obtener la media de unidades por curso (lamentablemente sembre todo con 10 unidades)
SELECT c.titulo, AVG(u.total_unidades) AS media_unidades
FROM cursos c
JOIN (
    SELECT cursos_id, COUNT(id) AS total_unidades
    FROM unidades
    GROUP BY cursos_id
) AS u
ON c.id = u.cursos_id
GROUP BY c.titulo;

-- Obtener los usuarios asociados a más de 3 cursos
SELECT u.nombre, COUNT(uc.cursos_id) as cursos
FROM usuarios u
JOIN usuarios_cursos uc
ON u.id = uc.usuarios_id
GROUP BY u.nombre 
HAVING cursos > 3
ORDER BY u.nombre;

-- Obtener las 10 primeras clases que comienzan después de una fecha determinada
SELECT titulo
FROM clases
WHERE fecha_inicio > '2024-02-01 00:00:00'
ORDER BY fecha_inicio ASC
LIMIT 10;

-- Obtener el número de bloques por tipo para una clase específica
SELECT b.tipo, COUNT(b.id) as Cantidad_bloques
FROM bloques b
JOIN clases c
ON b.clases_id = c.id
WHERE c.id = 12
GROUP BY b.tipo;

-- Obtener el nombre y el apellido de los usuarios, sustituyendo los valores nulos por una cadena vacía
SELECT IFNULL(nombre, '') AS nombre, IFNULL(apellido, '') AS apellido
FROM usuarios;

-- Obtener los 3 cursos con la mayor cantidad de usuarios
SELECT c.titulo, COUNT(uc.usuarios_id) AS usuarios
FROM cursos c
JOIN usuarios_cursos uc
ON c.id = uc.cursos_id
GROUP BY c.titulo
ORDER BY usuarios DESC
LIMIT 3;

-- Obtener el promedio de clases por unidad para cada curso (lamentablemente sembre todo con 10 unidades)
SELECT c.titulo AS curso, AVG(num_clases) AS promedio_clases_por_unidad
FROM cursos c
JOIN unidades u ON c.id = u.cursos_id
LEFT JOIN (
    SELECT unidades_id, COUNT(*) AS num_clases
    FROM clases
    GROUP BY unidades_id
) AS clase_counts ON u.id = clase_counts.unidades_id
GROUP BY c.titulo;

-- Obtener los usuarios con más de 2 cursos que comienzan después de una fecha determinada
SELECT u.nombre
FROM usuarios u
JOIN usuarios_cursos uc
ON u.id = uc.usuarios_id
JOIN cursos c
ON uc.cursos_id = c.id
WHERE c.fecha_inicio > '2023-12-25 00:00:00'
GROUP BY u.nombre
HAVING COUNT(uc.cursos_id) > 2
ORDER BY u.nombre ASC;

-- Obtener las 5 últimas unidades que comienzan después de una fecha determinada
SELECT titulo, fecha_inicio
FROM unidades
WHERE fecha_inicio > '2023-12-25 00:00:00'
ORDER BY fecha_inicio DESC
LIMIT 5;

-- Obtener el número de usuarios por categoría para un curso específico
SELECT c.tipo AS categoria, COUNT(u.id) AS cantidad_usuarios
FROM usuarios u
JOIN usuarios_cursos uc
ON u.id = uc.usuarios_id
JOIN categoria c
ON u.categoria_id = c.id
WHERE uc.cursos_id = 1
GROUP BY c.tipo










