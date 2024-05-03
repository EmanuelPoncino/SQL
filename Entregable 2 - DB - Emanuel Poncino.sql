-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema playground
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema playground
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `playground` DEFAULT CHARACTER SET utf8 ;
USE `playground` ;

-- -----------------------------------------------------
-- Table `playground`.`cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground`.`cursos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(100) NOT NULL,
  `descripcion` VARCHAR(500) NOT NULL,
  `imagen` VARCHAR(45) NOT NULL,
  `fecha_inicio` DATETIME NOT NULL,
  `fecha_fin` DATETIME NOT NULL,
  `cupo` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `titulo_UNIQUE` (`titulo` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground`.`unidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground`.`unidades` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cursos_id` INT NOT NULL,
  `titulo` VARCHAR(100) NOT NULL,
  `descripcion` VARCHAR(500) NOT NULL,
  `fecha_inicio` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_unidades_cursos_idx` (`cursos_id` ASC) VISIBLE,
  CONSTRAINT `fk_unidades_cursos`
    FOREIGN KEY (`cursos_id`)
    REFERENCES `playground`.`cursos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground`.`clases`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground`.`clases` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `unidades_id` INT NOT NULL,
  `titulo` VARCHAR(100) NOT NULL,
  `descripcion` VARCHAR(500) NOT NULL,
  `fecha_inicio` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_clases_unidades1_idx` (`unidades_id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_clases_unidades1`
    FOREIGN KEY (`unidades_id`)
    REFERENCES `playground`.`unidades` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground`.`bloques`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground`.`bloques` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `clases_id` INT NOT NULL,
  `titulo` VARCHAR(100) NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  `contenido` VARCHAR(500) NOT NULL,
  `visible` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_bloques_clases1_idx` (`clases_id` ASC) VISIBLE,
  CONSTRAINT `fk_bloques_clases1`
    FOREIGN KEY (`clases_id`)
    REFERENCES `playground`.`clases` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground`.`categoria` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground`.`usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `contraseña` VARCHAR(45) NOT NULL,
  `categoria_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_usuarios_categoria1_idx` (`categoria_id` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_categoria1`
    FOREIGN KEY (`categoria_id`)
    REFERENCES `playground`.`categoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground`.`usuarios_cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground`.`usuarios_cursos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cursos_id` INT NOT NULL,
  `usuarios_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_usuarios_cursos1_idx` (`cursos_id` ASC) VISIBLE,
  INDEX `fk_usuarios_cursos_usuarios1_idx` (`usuarios_id` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_cursos1`
    FOREIGN KEY (`cursos_id`)
    REFERENCES `playground`.`cursos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_cursos_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `playground`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO `playground`.`cursos` (`titulo`, `descripcion`, `imagen`, `fecha_inicio`, `fecha_fin`, `cupo`) VALUES
('Curso de Programación en Python', 'Aprende a programar en Python desde cero', 'python.jpg', '2024-05-01', '2024-07-01', 30),
('Curso de Desarrollo Web', 'Aprende a crear aplicaciones web modernas', 'web.jpg', '2024-06-01', '2024-08-01', 25),
('Curso de Bases de Datos', 'Conceptos básicos y avanzados de bases de datos', 'bd.jpg', '2024-07-01', '2024-09-01', 20),
('Curso de Machine Learning', 'Introducción al aprendizaje automático y la inteligencia artificial', 'ml.jpg', '2024-08-01', '2024-10-01', 20),
('Curso de Desarrollo de Videojuegos', 'Aprende a crear tus propios videojuegos desde cero', 'game.jpg', '2024-09-01', '2024-11-01', 15),
('Curso de Marketing Digital', 'Estrategias de marketing en línea para empresas', 'marketing.jpg', '2024-10-01', '2024-12-01', 25),
('Curso de Fotografía Digital', 'Técnicas básicas y avanzadas de fotografía digital', 'photography.jpg', '2024-11-01', '2025-01-01', 20),
('Curso de Inglés Avanzado', 'Mejora tu habilidad de comunicación en inglés', 'english.jpg', '2024-12-01', '2025-02-01', 30),
('Curso de Finanzas Personales', 'Gestión financiera personal y planificación de presupuestos', 'finance.jpg', '2025-01-01', '2025-03-01', 20),
('Curso de Cocina Internacional', 'Aprende a cocinar platos populares de diferentes países', 'cooking.jpg', '2025-02-01', '2025-04-01', 25);

INSERT INTO `playground`.`unidades` (`cursos_id`, `titulo`, `descripcion`, `fecha_inicio`) VALUES
-- Curso 1: Curso de Programación en Python
(1, 'Introducción a Python', 'Conceptos básicos y sintaxis de Python', '2024-05-01'),
(1, 'Estructuras de Datos en Python', 'Listas, tuplas, diccionarios, y conjuntos', '2024-05-15'),
(1, 'Funciones en Python', 'Definición y uso de funciones en Python', '2024-06-01'),
(1, 'Programación Orientada a Objetos', 'Principios de la programación orientada a objetos', '2024-06-15'),
(1, 'Manejo de Archivos', 'Lectura y escritura de archivos en Python', '2024-07-01'),
(1, 'Módulos y Paquetes', 'Organización y uso de módulos y paquetes en Python', '2024-07-15'),
(1, 'Excepciones y Manejo de Errores', 'Gestión de errores y excepciones en Python', '2024-08-01'),
(1, 'Interfaz Gráfica de Usuario (GUI)', 'Creación de interfaces gráficas con Tkinter', '2024-08-15'),
(1, 'Trabajo con Bases de Datos', 'Conexión y consulta a bases de datos con Python', '2024-09-01'),
(1, 'Proyecto Final: Desarrollo de Aplicación', 'Desarrollo de una aplicación completa en Python', '2024-09-15'),

-- Curso 2: Curso de Desarrollo Web
(2, 'HTML y CSS', 'Fundamentos de desarrollo web front-end', '2024-06-01'),
(2, 'JavaScript', 'Programación del lado del cliente', '2024-06-15'),
(2, 'Node.js y Express', 'Desarrollo de aplicaciones web con Node.js y Express', '2024-07-01'),
(2, 'Base de Datos y API REST', 'Integración de base de datos y creación de API REST', '2024-07-15'),
(2, 'React.js', 'Desarrollo de interfaces de usuario con React.js', '2024-08-01'),
(2, 'Redux', 'Gestión del estado de la aplicación con Redux', '2024-08-15'),
(2, 'Despliegue y Hosting', 'Despliegue de aplicaciones web y opciones de hosting', '2024-09-01'),
(2, 'Seguridad en Aplicaciones Web', 'Principios de seguridad y mejores prácticas en aplicaciones web', '2024-09-15'),
(2, 'Pruebas y Optimización', 'Pruebas unitarias, de integración y optimización de aplicaciones web', '2024-10-01'),
(2, 'Proyecto Final: Desarrollo de Sitio Web', 'Desarrollo de un sitio web interactivo utilizando las tecnologías aprendidas', '2024-10-15'),

-- Curso 3: Curso de Bases de Datos
(3, 'Introducción a SQL', 'Conceptos básicos de SQL y manipulación de datos', '2024-07-01'),
(3, 'Modelado de Datos Relacionales', 'Diseño de bases de datos relacionales', '2024-07-15'),
(3, 'Normalización de Bases de Datos', 'Principios de normalización y formas normales', '2024-08-01'),
(3, 'SQL Avanzado', 'Consultas complejas y procedimientos almacenados', '2024-08-15'),
(3, 'Bases de Datos No Relacionales', 'Introducción a bases de datos no relacionales', '2024-09-01'),
(3, 'MongoDB', 'Uso y administración de MongoDB como base de datos NoSQL', '2024-09-15'),
(3, 'Modelado de Datos No Relacionales', 'Diseño de modelos de datos para bases de datos NoSQL', '2024-10-01'),
(3, 'Integración con Aplicaciones', 'Integración de bases de datos con aplicaciones web', '2024-10-15'),
(3, 'Seguridad en Bases de Datos', 'Principios de seguridad y mejores prácticas en bases de datos', '2024-11-01'),
(3, 'Proyecto Final: Diseño de Base de Datos', 'Diseño y creación de una base de datos completa', '2024-11-15'),

-- Curso 4: Curso de Machine Learning
(4, 'Introducción al Aprendizaje Automático', 'Conceptos básicos y tipos de aprendizaje automático', '2024-08-01'),
(4, 'Clasificación y Regresión', 'Modelos de clasificación y regresión en aprendizaje automático', '2024-08-15'),
(4, 'Agrupamiento', 'Algoritmos de agrupamiento y segmentación de datos', '2024-09-01'),
(4, 'Aprendizaje No Supervisado', 'Métodos de aprendizaje no supervisado y análisis de datos', '2024-09-15'),
(4, 'Aprendizaje Profundo', 'Redes neuronales profundas y aplicaciones en aprendizaje automático', '2024-10-01'),
(4, 'Procesamiento de Lenguaje Natural', 'Aplicaciones de aprendizaje automático en procesamiento de lenguaje natural', '2024-10-15'),
(4, 'Visión por Computadora', 'Aplicaciones de aprendizaje automático en visión por computadora', '2024-11-01'),
(4, 'Reinforcement Learning', 'Aprendizaje por refuerzo y aplicaciones en juegos y robótica', '2024-11-15'),
(4, 'Ética y Responsabilidad', 'Consideraciones éticas y sociales en el desarrollo de modelos de aprendizaje automático', '2024-12-01'),
(4, 'Proyecto Final: Aplicación de Machine Learning', 'Desarrollo de una aplicación práctica utilizando técnicas de aprendizaje automático', '2024-12-15'),

-- Curso 5: Curso de Desarrollo de Videojuegos
(5, 'Introducción a los Videojuegos', 'Historia y conceptos básicos de los videojuegos', '2024-09-01'),
(5, 'Diseño de Juegos', 'Principios de diseño de juegos y narrativa', '2024-09-15'),
(5, 'Desarrollo de Juegos 2D', 'Creación de juegos en dos dimensiones con motores de juego populares', '2024-10-01'),
(5, 'Desarrollo de Juegos 3D', 'Creación de juegos en tres dimensiones con motores de juego populares', '2024-10-15'),
(5, 'Física en los Videojuegos', 'Aplicación de principios de física en el desarrollo de videojuegos', '2024-11-01'),
(5, 'IA en los Videojuegos', 'Implementación de inteligencia artificial en videojuegos', '2024-11-15'),
(5, 'Diseño de Niveles', 'Creación y diseño de niveles en juegos', '2024-12-01'),
(5, 'Sonido y Música', 'Creación y aplicación de efectos de sonido y música en videojuegos', '2024-12-15'),
(5, 'Pruebas y Debugging', 'Métodos de prueba y depuración en el desarrollo de videojuegos', '2025-01-01'),
(5, 'Proyecto Final: Videojuego Completo', 'Desarrollo de un videojuego completo, desde la idea hasta la implementación', '2025-01-15'),

-- Curso 6: Curso de Marketing Digital
(6, 'Fundamentos de Marketing', 'Conceptos básicos de marketing y estrategias de mercado', '2024-10-01'),
(6, 'Marketing en Redes Sociales', 'Estrategias de marketing en plataformas de redes sociales', '2024-10-15'),
(6, 'Publicidad en Línea', 'Campañas de publicidad en línea y gestión de anuncios', '2024-11-01'),
(6, 'SEO (Optimización en Motores de Búsqueda)', 'Técnicas de optimización para mejorar la visibilidad en motores de búsqueda', '2024-11-15'),
(6, 'SEM (Marketing en Motores de Búsqueda)', 'Gestión de campañas de publicidad en motores de búsqueda', '2024-12-01'),
(6, 'Email Marketing', 'Estrategias de marketing por correo electrónico y automatización', '2024-12-15'),
(6, 'Marketing de Contenidos', 'Creación y distribución de contenido para atraer y retener clientes', '2025-01-01'),
(6, 'Análisis de Datos', 'Análisis de datos para mejorar estrategias de marketing', '2025-01-15'),
(6, 'Marketing de Influencia', 'Colaboraciones con influencers para promocionar productos y servicios', '2025-02-01'),
(6, 'Proyecto Final: Campaña de Marketing Digital', 'Desarrollo y ejecución de una campaña de marketing digital completa', '2025-02-15'),

-- Curso 7: Curso de Fotografía Digital
(7, 'Fundamentos de Fotografía', 'Conceptos básicos de la fotografía: composición, exposición, enfoque, etc.', '2024-11-01'),
(7, 'Técnica y Composición', 'Técnicas avanzadas de composición y uso de la luz en la fotografía', '2024-11-15'),
(7, 'Fotografía de Retrato', 'Técnicas y consejos para fotografía de retrato', '2024-12-01'),
(7, 'Fotografía de Paisaje', 'Técnicas y consejos para fotografía de paisajes y naturaleza', '2024-12-15'),
(7, 'Fotografía de Producto', 'Técnicas y consejos para fotografía de productos y publicidad', '2025-01-01'),
(7, 'Fotografía de Eventos', 'Técnicas y consejos para fotografía de eventos y celebraciones', '2025-01-15'),
(7, 'Edición de Fotografía', 'Uso de software de edición para mejorar y retocar fotografías', '2025-02-01'),
(7, 'Fotografía en Blanco y Negro', 'Técnicas y estilos de fotografía en blanco y negro', '2025-02-15'),
(7, 'Fotografía Macro', 'Técnicas y equipo para fotografía macro y primeros planos', '2025-03-01'),
(7, 'Proyecto Final: Portafolio Fotográfico', 'Creación y presentación de un portafolio fotográfico profesional', '2025-03-15'),

-- Curso 8: Curso de Inglés Avanzado
(8, 'Gramática Avanzada', 'Estructuras gramaticales complejas y uso avanzado del idioma inglés', '2024-12-01'),
(8, 'Vocabulario Avanzado', 'Expansión del vocabulario y uso de términos especializados en inglés', '2024-12-15'),
(8, 'Comprensión Auditiva', 'Mejora de la comprensión auditiva a través de prácticas y ejercicios', '2025-01-01'),
(8, 'Expresión Oral', 'Desarrollo de habilidades de expresión oral y fluidez en inglés', '2025-01-15'),
(8, 'Expresión Escrita', 'Desarrollo de habilidades de expresión escrita y redacción en inglés', '2025-02-01'),
(8, 'Lectura Avanzada', 'Comprensión de textos avanzados y análisis de contenido en inglés', '2025-02-15'),
(8, 'Conversación Avanzada', 'Prácticas de conversación avanzada y discusión de temas variados', '2025-03-01'),
(8, 'Inglés para Negocios', 'Uso del inglés en contextos empresariales y comerciales', '2025-03-15'),
(8, 'Preparación para Exámenes', 'Preparación para exámenes de certificación y evaluación del nivel de inglés', '2025-04-01'),
(8, 'Proyecto Final: Presentación en Inglés', 'Elaboración y presentación de un proyecto en inglés sobre un tema de interés', '2025-04-15'),

-- Curso 9: Curso de Finanzas Personales
(9, 'Planificación Financiera', 'Conceptos básicos de planificación financiera y establecimiento de metas', '2025-01-01'),
(9, 'Presupuesto y Ahorro', 'Elaboración de presupuestos y técnicas de ahorro efectivas', '2025-01-15'),
(9, 'Inversiones y Mercados Financieros', 'Introducción a las inversiones y funcionamiento de los mercados financieros', '2025-02-01'),
(9, 'Fondos de Inversión', 'Tipos de fondos de inversión y estrategias de gestión de carteras', '2025-02-15'),
(9, 'Educación Financiera', 'Desarrollo de conocimientos y habilidades financieras para la toma de decisiones', '2025-03-01'),
(9, 'Gestión del Crédito', 'Manejo responsable del crédito y estrategias para evitar el endeudamiento', '2025-03-15'),
(9, 'Planificación de Jubilación', 'Estrategias de planificación para asegurar una jubilación cómoda y segura', '2025-04-01'),
(9, 'Seguros Personales', 'Tipos de seguros personales y su importancia en la protección financiera', '2025-04-15'),
(9, 'Impuestos Personales', 'Conceptos básicos de impuestos personales y cumplimiento tributario', '2025-05-01'),
(9, 'Proyecto Final: Plan Financiero Personal', 'Elaboración y presentación de un plan financiero personal completo', '2025-05-15'),

-- Curso 10: Curso de Cocina Internacional
(10, 'Introducción a la Cocina Internacional', 'Historia y conceptos básicos de la cocina de diferentes países', '2025-02-01'),
(10, 'Cocina Italiana', 'Platos clásicos de la gastronomía italiana y técnicas culinarias', '2025-02-15'),
(10, 'Cocina Mexicana', 'Platos tradicionales de la cocina mexicana y uso de ingredientes auténticos', '2025-03-01'),
(10, 'Cocina Asiática', 'Sabores y técnicas de la cocina asiática: China, Japón, Tailandia, etc.', '2025-03-15'),
(10, 'Cocina Francesa', 'Técnicas y recetas de la alta cocina francesa y su influencia global', '2025-04-01'),
(10, 'Cocina Mediterránea', 'Platos saludables y sabrosos de la región mediterránea: España, Grecia, etc.', '2025-04-15'),
(10, 'Cocina Árabe', 'Sabores exóticos y especias de la cocina árabe y del Medio Oriente', '2025-05-01'),
(10, 'Cocina Fusion', 'Experimentación con combinaciones de sabores de diferentes tradiciones culinarias', '2025-05-15'),
(10, 'Repostería Internacional', 'Postres y dulces típicos de diferentes culturas y países', '2025-06-01'),
(10, 'Proyecto Final: Cena Internacional', 'Preparación y presentación de una cena internacional completa', '2025-06-15');

-- CLASES PARA PYTHON
-- Clases para la Unidad 1: Introducción a Python
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(1, 'Instalación de Python', 'Cómo instalar y configurar Python en diferentes sistemas operativos', '2024-05-01'),
(1, 'Sintaxis Básica', 'Conceptos básicos de sintaxis, variables y tipos de datos en Python', '2024-05-02'),
(1, 'Operadores y Expresiones', 'Uso de operadores aritméticos, de comparación y lógicos', '2024-05-03'),
(1, 'Control de Flujo: Condicionales', 'Uso de condicionales (if, else, elif) para controlar el flujo del programa', '2024-05-04'),
(1, 'Control de Flujo: Bucles', 'Uso de bucles (for, while) para repetir tareas en Python', '2024-05-05'),
(1, 'Funciones', 'Definición y llamada a funciones en Python', '2024-05-06'),
(1, 'Módulos y Paquetes Estándar', 'Uso de módulos y paquetes estándar de Python', '2024-05-07'),
(1, 'Entorno de Desarrollo', 'Configuración de un entorno de desarrollo para programar en Python', '2024-05-08'),
(1, 'Práctica: Ejercicios de Introducción', 'Resolución de ejercicios prácticos para afianzar los conceptos aprendidos', '2024-05-09'),
(1, 'Repaso y Preguntas', 'Revisión de los conceptos vistos en la unidad y resolución de dudas', '2024-05-10');

-- Clases para la Unidad 2: Estructuras de Datos en Python
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(2, 'Listas en Python', 'Creación, manipulación y acceso a elementos de listas en Python', '2024-05-15'),
(2, 'Tuplas en Python', 'Definición y características de las tuplas en Python', '2024-05-16'),
(2, 'Diccionarios en Python', 'Uso de diccionarios para almacenar datos clave-valor', '2024-05-17'),
(2, 'Conjuntos en Python', 'Operaciones y métodos disponibles para conjuntos en Python', '2024-05-18'),
(2, 'Funciones Integradas', 'Uso de funciones integradas para trabajar con estructuras de datos', '2024-05-19'),
(2, 'Comprehensions', 'Uso de listas, diccionarios y conjuntos comprehensivos', '2024-05-20'),
(2, 'Práctica: Ejercicios de Estructuras de Datos', 'Resolución de ejercicios prácticos relacionados con estructuras de datos', '2024-05-21'),
(2, 'Proyectos de Ejemplo', 'Análisis de proyectos de ejemplo que utilizan diversas estructuras de datos', '2024-05-22'),
(2, 'Aplicaciones y Casos de Uso', 'Aplicaciones prácticas de las estructuras de datos en diferentes contextos', '2024-05-23'),
(2, 'Repaso y Preguntas', 'Revisión de los conceptos vistos en la unidad y resolución de dudas', '2024-05-24');

-- Clases para la Unidad 3: Funciones en Python
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(3, 'Definición y Llamada de Funciones', 'Cómo definir y llamar funciones en Python', '2024-06-01'),
(3, 'Parámetros y Argumentos', 'Uso de parámetros y argumentos en funciones', '2024-06-02'),
(3, 'Valores de Retorno', 'Retorno de valores desde funciones en Python', '2024-06-03'),
(3, 'Alcance de Variables', 'Entender el alcance de las variables locales y globales', '2024-06-04'),
(3, 'Funciones Anónimas (Lambda)', 'Uso de funciones lambda en Python', '2024-06-05'),
(3, 'Funciones Recursivas', 'Implementación de funciones recursivas en Python', '2024-06-06'),
(3, 'Decoradores de Funciones', 'Uso de decoradores para modificar o extender el comportamiento de funciones', '2024-06-07'),
(3, 'Manejo de Excepciones en Funciones', 'Cómo manejar excepciones dentro de funciones', '2024-06-08'),
(3, 'Práctica: Ejercicios de Funciones', 'Resolución de ejercicios prácticos relacionados con funciones', '2024-06-09'),
(3, 'Repaso y Preguntas', 'Revisión de los conceptos vistos en la unidad y resolución de dudas', '2024-06-10');

-- Clases para la Unidad 4: Programación Orientada a Objetos
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(4, 'Conceptos Básicos de POO', 'Introducción a los conceptos fundamentales de la programación orientada a objetos', '2024-06-15'),
(4, 'Clases y Objetos', 'Definición y uso de clases y objetos en Python', '2024-06-16'),
(4, 'Atributos y Métodos', 'Definición de atributos y métodos en una clase', '2024-06-17'),
(4, 'Encapsulamiento', 'Cómo implementar el encapsulamiento en Python', '2024-06-18'),
(4, 'Herencia', 'Uso de la herencia para reutilizar y extender funcionalidades', '2024-06-19'),
(4, 'Polimorfismo', 'Concepto de polimorfismo y su implementación en Python', '2024-06-20'),
(4, 'Métodos Especiales', 'Uso de métodos especiales para operaciones específicas en clases', '2024-06-21'),
(4, 'Composición vs. Herencia', 'Comparación entre composición y herencia en el diseño de clases', '2024-06-22'),
(4, 'Práctica: Ejercicios de POO', 'Resolución de ejercicios prácticos relacionados con la programación orientada a objetos', '2024-06-23'),
(4, 'Repaso y Preguntas', 'Revisión de los conceptos vistos en la unidad y resolución de dudas', '2024-06-24');

-- Clases para la Unidad 5: Manejo de Archivos
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(5, 'Apertura y Cierre de Archivos', 'Cómo abrir y cerrar archivos en Python', '2024-07-01'),
(5, 'Lectura de Archivos', 'Métodos para leer contenido de archivos en Python', '2024-07-02'),
(5, 'Escritura en Archivos', 'Escritura de datos en archivos desde Python', '2024-07-03'),
(5, 'Manejo de Archivos de Texto', 'Operaciones específicas con archivos de texto', '2024-07-04'),
(5, 'Manejo de Archivos Binarios', 'Lectura y escritura de archivos binarios en Python', '2024-07-05'),
(5, 'Manejo de Archivos CSV', 'Lectura y escritura de archivos CSV en Python', '2024-07-06'),
(5, 'Trabajo con Directorios', 'Operaciones para listar, crear y eliminar directorios en Python', '2024-07-07'),
(5, 'Serialización de Objetos', 'Cómo serializar objetos en Python para almacenarlos en archivos', '2024-07-08'),
(5, 'Práctica: Ejercicios de Manejo de Archivos', 'Resolución de ejercicios prácticos relacionados con el manejo de archivos', '2024-07-09'),
(5, 'Repaso y Preguntas', 'Revisión de los conceptos vistos en la unidad y resolución de dudas', '2024-07-10');

-- Clases para la Unidad 6: Módulos y Paquetes
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(6, 'Creación de Módulos', 'Cómo crear y utilizar módulos en Python', '2024-07-15'),
(6, 'Importación de Módulos', 'Formas de importar módulos en Python', '2024-07-16'),
(6, 'Creación de Paquetes', 'Organización de módulos en paquetes en Python', '2024-07-17'),
(6, 'Uso de Módulos Estándar', 'Cómo utilizar módulos estándar de Python', '2024-07-18'),
(6, 'Instalación y Uso de Paquetes Externos', 'Cómo instalar y utilizar paquetes externos mediante pip', '2024-07-19'),
(6, 'Manejo de Versiones de Módulos y Paquetes', 'Gestión de versiones y actualizaciones de módulos y paquetes', '2024-07-20'),
(6, 'Documentación de Módulos y Paquetes', 'Cómo documentar módulos y paquetes en Python', '2024-07-21'),
(6, 'Pruebas y Depuración', 'Realización de pruebas y depuración en módulos y paquetes', '2024-07-22'),
(6, 'Práctica: Creación de Módulos y Paquetes', 'Desarrollo de módulos y paquetes propios para proyectos', '2024-07-23'),
(6, 'Repaso y Preguntas', 'Revisión de los conceptos vistos en la unidad y resolución de dudas', '2024-07-24');

-- Clases para la Unidad 7: Excepciones y Manejo de Errores
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(7, 'Qué son las Excepciones', 'Concepto de excepciones y su importancia en el manejo de errores', '2024-08-01'),
(7, 'Manejo de Excepciones con try-except', 'Uso de la estructura try-except para manejar excepciones', '2024-08-02'),
(7, 'Manejo de Excepciones con try-except-else', 'Uso de la cláusula else con try-except para código limpio', '2024-08-03'),
(7, 'Manejo de Excepciones con try-except-finally', 'Uso de la cláusula finally para ejecutar código después de un try-except', '2024-08-04'),
(7, 'Excepciones Específicas', 'Manejo de excepciones específicas para casos particulares', '2024-08-05'),
(7, 'Lanzamiento de Excepciones', 'Cómo lanzar excepciones manualmente en Python', '2024-08-06'),
(7, 'Depuración de Errores', 'Técnicas para depurar errores y encontrar excepciones', '2024-08-07'),
(7, 'Manejo de Errores en Archivos', 'Cómo manejar errores al trabajar con archivos en Python', '2024-08-08'),
(7, 'Práctica: Ejercicios de Manejo de Excepciones', 'Resolución de ejercicios prácticos relacionados con el manejo de excepciones', '2024-08-09'),
(7, 'Repaso y Preguntas', 'Revisión de los conceptos vistos en la unidad y resolución de dudas', '2024-08-10');

-- Clases para la Unidad 8: Interfaz Gráfica de Usuario (GUI)
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(8, 'Introducción a Tkinter', 'Conceptos básicos y estructura de Tkinter', '2024-08-15'),
(8, 'Widgets Básicos', 'Uso de widgets básicos como labels, buttons, y entry', '2024-08-16'),
(8, 'Layout Management', 'Gestión del diseño y disposición de widgets en la interfaz', '2024-08-17'),
(8, 'Eventos y Enlaces', 'Manejo de eventos y enlaces de widgets', '2024-08-18'),
(8, 'Diálogos y Ventanas Emergentes', 'Creación y uso de diálogos y ventanas emergentes', '2024-08-19'),
(8, 'Menús y Barras de Herramientas', 'Creación y manejo de menús y barras de herramientas', '2024-08-20'),
(8, 'Widgets Avanzados', 'Uso de widgets avanzados como listboxes, spinboxes, y comboboxes', '2024-08-21'),
(8, 'Estilos y Temas', 'Personalización de la apariencia de la interfaz con estilos y temas', '2024-08-22'),
(8, 'Práctica: Desarrollo de Aplicaciones GUI', 'Desarrollo de aplicaciones con interfaz gráfica de usuario', '2024-08-23'),
(8, 'Repaso y Preguntas', 'Revisión de los conceptos vistos en la unidad y resolución de dudas', '2024-08-24');

-- Clases para la Unidad 9: Trabajo con Bases de Datos
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(9, 'Introducción a Bases de Datos', 'Conceptos básicos sobre bases de datos relacionales y no relacionales', '2024-09-01'),
(9, 'Conexión a Bases de Datos', 'Establecimiento de conexión con bases de datos desde Python', '2024-09-02'),
(9, 'Operaciones CRUD', 'Realización de operaciones CRUD (Create, Read, Update, Delete) en Python', '2024-09-03'),
(9, 'Consultas SQL desde Python', 'Ejecución de consultas SQL desde Python utilizando librerías específicas', '2024-09-04'),
(9, 'ORM (Mapeo Objeto-Relacional)', 'Uso de ORM para interactuar con bases de datos de manera orientada a objetos', '2024-09-05'),
(9, 'Transacciones', 'Manejo de transacciones en bases de datos desde Python', '2024-09-06'),
(9, 'Bases de Datos No Relacionales', 'Trabajo con bases de datos no relacionales desde Python', '2024-09-07'),
(9, 'Integración con Frameworks Web', 'Uso de bases de datos en aplicaciones web desarrolladas en Python', '2024-09-08'),
(9, 'Práctica: Desarrollo de Aplicación con BD', 'Desarrollo de una aplicación completa que utiliza una base de datos', '2024-09-09'),
(9, 'Repaso y Preguntas', 'Revisión de los conceptos vistos en la unidad y resolución de dudas', '2024-09-10');

-- Clases para la Unidad 10: Proyecto Final: Desarrollo de Aplicación
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(10, 'Presentación del Proyecto Final', 'Explicación de los requisitos y objetivos del proyecto final', '2024-09-15'),
(10, 'Planificación del Proyecto', 'Elaboración de un plan de trabajo y diseño para el proyecto', '2024-09-16'),
(10, 'Implementación del Proyecto', 'Desarrollo y codificación del proyecto siguiendo el plan establecido', '2024-09-17'),
(10, 'Pruebas y Depuración', 'Realización de pruebas y corrección de errores en el proyecto', '2024-09-18'),
(10, 'Documentación del Proyecto', 'Elaboración de documentación técnica y de usuario para el proyecto', '2024-09-19'),
(10, 'Entrega y Presentación', 'Entrega final del proyecto y presentación de los resultados', '2024-09-20'),
(10, 'Evaluación y Retroalimentación', 'Evaluación del proyecto por parte de los instructores y retroalimentación', '2024-09-21'),
(10, 'Repaso y Preguntas Finales', 'Revisión de los conceptos aprendidos y resolución de dudas finales', '2024-09-22'),
(10, 'Cierre del Curso', 'Despedida y cierre oficial del curso', '2024-09-23'),
(10, 'Graduación', 'Entrega de certificados de graduación a los participantes', '2024-09-24');

-- CLASES PARA DESARROLLO WEB
-- Clases para la Unidad 1: HTML y CSS
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(11, 'Introducción a HTML', 'Conceptos básicos de HTML y su estructura', '2024-06-01'),
(11, 'Etiquetas y Elementos HTML', 'Uso de etiquetas y elementos HTML para la creación de contenido', '2024-06-02'),
(11, 'Estilos con CSS', 'Aplicación de estilos a elementos HTML utilizando CSS', '2024-06-03'),
(11, 'Modelo de Caja', 'Concepto del modelo de caja en CSS y su aplicación', '2024-06-04'),
(11, 'Diseño Responsivo', 'Adaptación de la interfaz a diferentes dispositivos y tamaños de pantalla', '2024-06-05'),
(11, 'Frameworks CSS', 'Uso de frameworks CSS para el desarrollo web', '2024-06-06'),
(11, 'Práctica: Creación de Sitio Estático', 'Desarrollo de un sitio estático utilizando HTML y CSS', '2024-06-07'),
(11, 'Repaso y Preguntas', 'Revisión de los conceptos vistos en la unidad y resolución de dudas', '2024-06-08'),
(11, 'Ejercicio Adicional: Diseño de Sitio Web', 'Desarrollo de un diseño de sitio web completo utilizando HTML y CSS', '2024-06-09'),
(11, 'Ejercicio Adicional: Creación de Portafolio', 'Creación de un portafolio personal utilizando HTML y CSS', '2024-06-10');

-- Clases para la Unidad 2: JavaScript
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(12, 'Introducción a JavaScript', 'Conceptos básicos de JavaScript y su sintaxis', '2024-06-15'),
(12, 'Variables y Tipos de Datos', 'Declaración de variables y tipos de datos en JavaScript', '2024-06-16'),
(12, 'Operadores y Expresiones', 'Uso de operadores y expresiones en JavaScript', '2024-06-17'),
(12, 'Estructuras de Control', 'Uso de estructuras de control como if, else, for, while, etc.', '2024-06-18'),
(12, 'Funciones en JavaScript', 'Definición y uso de funciones en JavaScript', '2024-06-19'),
(12, 'Eventos y Manejo del DOM', 'Trabajo con eventos y manipulación del DOM en JavaScript', '2024-06-20'),
(12, 'Objetos y Métodos', 'Creación de objetos y métodos en JavaScript', '2024-06-21'),
(12, 'AJAX y Asincronismo', 'Uso de AJAX y manejo de operaciones asíncronas en JavaScript', '2024-06-22'),
(12, 'Frameworks y Librerías', 'Uso de frameworks y librerías JavaScript populares', '2024-06-23'),
(12, 'Práctica: Desarrollo de Mini Proyecto', 'Desarrollo de un mini proyecto utilizando JavaScript', '2024-06-24');

-- Clases para la Unidad 3: Node.js y Express
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(13, 'Introducción a Node.js', 'Conceptos básicos de Node.js y su instalación', '2024-07-01'),
(13, 'Módulos y NPM', 'Uso de módulos y el gestor de paquetes NPM en Node.js', '2024-07-02'),
(13, 'Creación de Servidores', 'Desarrollo de servidores web con Node.js', '2024-07-03'),
(13, 'Express.js', 'Introducción al framework Express.js para el desarrollo web', '2024-07-04'),
(13, 'Rutas y Middleware', 'Definición de rutas y uso de middleware en Express.js', '2024-07-05'),
(13, 'Manejo de Solicitudes y Respuestas', 'Procesamiento de solicitudes y generación de respuestas en Express.js', '2024-07-06'),
(13, 'Plantillas y Vistas', 'Uso de plantillas y vistas en aplicaciones web con Express.js', '2024-07-07'),
(13, 'Bases de Datos con Node.js', 'Integración de bases de datos con Node.js y Express.js', '2024-07-08'),
(13, 'Autenticación y Autorización', 'Implementación de autenticación y autorización en aplicaciones web', '2024-07-09'),
(13, 'Práctica: Desarrollo de API REST', 'Desarrollo de una API REST utilizando Node.js y Express.js', '2024-07-10');

-- Clases para la Unidad 4: Base de Datos y API REST
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(14, 'Introducción a Bases de Datos', 'Conceptos básicos de bases de datos relacionales y no relacionales', '2024-07-15'),
(14, 'SQL Básico', 'Consulta, inserción, actualización y eliminación de datos con SQL', '2024-07-16'),
(14, 'MongoDB', 'Introducción a MongoDB como base de datos NoSQL', '2024-07-17'),
(14, 'Mongoose', 'Uso de Mongoose para interactuar con MongoDB desde Node.js', '2024-07-18'),
(14, 'Creación de API REST', 'Desarrollo de una API REST utilizando Node.js y Express.js', '2024-07-19'),
(14, 'Endpoints y Métodos HTTP', 'Definición de endpoints y métodos HTTP en una API REST', '2024-07-20'),
(14, 'Autenticación y Autorización', 'Implementación de autenticación y autorización en una API REST', '2024-07-21'),
(14, 'Documentación de API', 'Generación de documentación para una API REST', '2024-07-22'),
(14, 'Pruebas de API', 'Realización de pruebas unitarias e integradas para una API REST', '2024-07-23'),
(14, 'Despliegue de API', 'Opciones y consideraciones para desplegar una API REST en producción', '2024-07-24');

-- Clases para la Unidad 5: React.js
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(15, 'Introducción a React.js', 'Conceptos básicos de React.js y su filosofía', '2024-08-01'),
(15, 'Componentes y Props', 'Creación y uso de componentes y props en React.js', '2024-08-02'),
(15, 'Estado y Ciclo de Vida', 'Manejo de estado y ciclo de vida de componentes en React.js', '2024-08-03'),
(15, 'Eventos y Manejo de Formularios', 'Manejo de eventos y formularios en React.js', '2024-08-04'),
(15, 'React Router', 'Navegación y enrutamiento en aplicaciones web con React Router', '2024-08-05'),
(15, 'Hooks', 'Uso de hooks para añadir funcionalidad a componentes funcionales en React.js', '2024-08-06'),
(15, 'Context API', 'Uso de Context API para compartir datos entre componentes en React.js', '2024-08-07'),
(15, 'Gestión de Estado Global', 'Implementación de gestión de estado global en aplicaciones React.js', '2024-08-08'),
(15, 'Pruebas en React.js', 'Realización de pruebas unitarias e integradas en aplicaciones React.js', '2024-08-09'),
(15, 'Despliegue de Aplicaciones React.js', 'Opciones y consideraciones para desplegar aplicaciones React.js en producción', '2024-08-10');

-- Clases para la Unidad 6: Redux
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(16, 'Introducción a Redux', 'Conceptos básicos de Redux y su aplicación en aplicaciones web', '2024-08-15'),
(16, 'Acciones y Reducers', 'Definición de acciones y reducers en Redux', '2024-08-16'),
(16, 'Store', 'Creación y configuración de la store en Redux', '2024-08-17'),
(16, 'Conexión con React.js', 'Conexión de Redux con aplicaciones React.js', '2024-08-18'),
(16, 'Middleware', 'Uso de middleware en Redux para tareas asíncronas', '2024-08-19'),
(16, 'Selectors', 'Definición y uso de selectors en Redux', '2024-08-20'),
(16, 'Persistencia de Estado', 'Persistencia de estado en aplicaciones Redux', '2024-08-21'),
(16, 'Testing de Redux', 'Realización de pruebas unitarias e integradas en aplicaciones Redux', '2024-08-22'),
(16, 'Integración con DevTools', 'Uso de herramientas de desarrollo para depurar y monitorizar aplicaciones Redux', '2024-08-23'),
(16, 'Optimización de Rendimiento', 'Técnicas para optimizar el rendimiento de aplicaciones Redux', '2024-08-24');

-- Clases para la Unidad 7: Despliegue y Hosting
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(17, 'Despliegue en Servidores', 'Opciones y consideraciones para desplegar aplicaciones web en servidores', '2024-09-01'),
(17, 'Plataformas de Hosting', 'Comparativa y selección de plataformas de hosting para aplicaciones web', '2024-09-02'),
(17, 'Configuración de Servidores', 'Configuración básica de servidores para desplegar aplicaciones web', '2024-09-03'),
(17, 'Continuous Deployment', 'Implementación de despliegue continuo para automatizar el proceso de despliegue', '2024-09-04'),
(17, 'Seguridad en Despliegue', 'Consideraciones de seguridad al desplegar aplicaciones web en servidores', '2024-09-05'),
(17, 'Monitoreo y Mantenimiento', 'Herramientas y prácticas para el monitoreo y mantenimiento de aplicaciones desplegadas', '2024-09-06'),
(17, 'Escalabilidad', 'Estrategias para escalar aplicaciones web desplegadas según la demanda', '2024-09-07'),
(17, 'Despliegue de Prueba', 'Proceso de despliegue en entornos de prueba para validar cambios', '2024-09-08'),
(17, 'Despliegue de Producción', 'Proceso de despliegue en entornos de producción para usuarios finales', '2024-09-09'),
(17, 'Optimización de Despliegue', 'Técnicas para optimizar el proceso de despliegue y reducir tiempos de inactividad', '2024-09-10');

-- Clases para la Unidad 8: Seguridad en Aplicaciones Web
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(18, 'Riesgos de Seguridad', 'Principales riesgos de seguridad en aplicaciones web y cómo mitigarlos', '2024-09-15'),
(18, 'CORS', 'Uso de CORS para controlar el acceso a recursos en aplicaciones web', '2024-09-16'),
(18, 'CSRF', 'Prevención de ataques CSRF (Cross-Site Request Forgery)', '2024-09-17'),
(18, 'XSS', 'Prevención de ataques XSS (Cross-Site Scripting)', '2024-09-18'),
(18, 'SQL Injection', 'Prevención de ataques de inyección SQL', '2024-09-19'),
(18, 'Autenticación y Autorización Avanzadas', 'Implementación de autenticación y autorización avanzadas en aplicaciones web', '2024-09-20'),
(18, 'HTTPS y Certificados SSL', 'Configuración de HTTPS y uso de certificados SSL para cifrado de datos', '2024-09-21'),
(18, 'Auditoría y Registro', 'Registro y auditoría de eventos de seguridad en aplicaciones web', '2024-09-22'),
(18, 'Pruebas de Seguridad', 'Realización de pruebas de seguridad para identificar vulnerabilidades', '2024-09-23'),
(18, 'Mejores Prácticas de Seguridad', 'Adopción de mejores prácticas de seguridad en el desarrollo y despliegue de aplicaciones web', '2024-09-24');

-- Clases para la Unidad 9: Pruebas y Optimización
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(19, 'Tipos de Pruebas', 'Introducción a los diferentes tipos de pruebas en el desarrollo web', '2024-10-01'),
(19, 'Pruebas Unitarias', 'Desarrollo y ejecución de pruebas unitarias en aplicaciones web', '2024-10-02'),
(19, 'Pruebas de Integración', 'Desarrollo y ejecución de pruebas de integración en aplicaciones web', '2024-10-03'),
(19, 'Pruebas Funcionales', 'Desarrollo y ejecución de pruebas funcionales en aplicaciones web', '2024-10-04'),
(19, 'Pruebas de Rendimiento', 'Desarrollo y ejecución de pruebas de rendimiento en aplicaciones web', '2024-10-05'),
(19, 'Pruebas de Seguridad', 'Desarrollo y ejecución de pruebas de seguridad en aplicaciones web', '2024-10-06'),
(19, 'Herramientas de Pruebas', 'Introducción a herramientas y frameworks de pruebas en el desarrollo web', '2024-10-07'),
(19, 'Optimización de Código', 'Técnicas y herramientas para la optimización de código en aplicaciones web', '2024-10-08'),
(19, 'Optimización de Recursos', 'Optimización de recursos como imágenes, scripts y hojas de estilo', '2024-10-09'),
(19, 'Despliegue de Pruebas', 'Despliegue de aplicaciones web en entornos de prueba para realizar pruebas', '2024-10-10');

-- Clases para la Unidad 10: Proyecto Final: Desarrollo de Sitio Web
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(20, 'Presentación del Proyecto Final', 'Explicación de los requisitos y objetivos del proyecto final', '2024-10-15'),
(20, 'Planificación del Proyecto', 'Elaboración de un plan de trabajo y diseño para el proyecto', '2024-10-16'),
(20, 'Implementación del Proyecto', 'Desarrollo y codificación del proyecto siguiendo el plan establecido', '2024-10-17'),
(20, 'Pruebas y Depuración', 'Realización de pruebas y corrección de errores en el proyecto', '2024-10-18'),
(20, 'Documentación del Proyecto', 'Elaboración de documentación técnica y de usuario para el proyecto', '2024-10-19'),
(20, 'Entrega y Presentación', 'Entrega final del proyecto y presentación de los resultados', '2024-10-20'),
(20, 'Evaluación y Retroalimentación', 'Evaluación del proyecto por parte de los instructores y retroalimentación', '2024-10-21'),
(20, 'Repaso y Preguntas Finales', 'Revisión de los conceptos aprendidos y resolución de dudas finales', '2024-10-22'),
(20, 'Cierre del Curso', 'Despedida y cierre oficial del curso', '2024-10-23'),
(20, 'Graduación', 'Entrega de certificados de graduación a los participantes', '2024-10-24');

-- CLASES PARA BASE DE DATOS
-- Clases para la Unidad 1: Introducción a SQL
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(21, 'Introducción a SQL', 'Conceptos básicos de SQL y manipulación de datos', '2024-07-01'),
(21, 'Consultas SELECT', 'Uso del comando SELECT para recuperar datos de una base de datos', '2024-07-02'),
(21, 'Filtrado de Datos', 'Uso de cláusulas WHERE y operadores de comparación para filtrar datos', '2024-07-03'),
(21, 'Ordenamiento y Limitación', 'Ordenamiento de resultados y limitación de filas en consultas', '2024-07-04'),
(21, 'Funciones de Agregación', 'Uso de funciones de agregación como COUNT, SUM, AVG, etc.', '2024-07-05'),
(21, 'Consultas JOIN', 'Realización de consultas que involucran múltiples tablas utilizando JOIN', '2024-07-06'),
(21, 'Subconsultas', 'Uso de subconsultas para realizar consultas más complejas', '2024-07-07'),
(21, 'Expresiones Condicionales', 'Uso de expresiones condicionales en consultas SQL', '2024-07-08'),
(21, 'Transacciones', 'Concepto de transacciones y control de la concurrencia en bases de datos', '2024-07-09'),
(21, 'Seguridad y Privilegios', 'Gestión de la seguridad y los privilegios en bases de datos SQL', '2024-07-10');

-- Clases para la Unidad 2: Modelado de Datos Relacionales
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(22, 'Modelado de Datos', 'Conceptos básicos de modelado de datos y diseño de bases de datos relacionales', '2024-07-15'),
(22, 'Diagramas ER', 'Elaboración de diagramas de entidad-relación para representar el diseño de una base de datos', '2024-07-16'),
(22, 'Modelo Relacional', 'Transformación de diagramas ER a modelo relacional', '2024-07-17'),
(22, 'Claves y Restricciones', 'Definición de claves primarias, foráneas y otras restricciones en el modelo relacional', '2024-07-18'),
(22, 'Normalización', 'Principios de normalización y aplicación de formas normales en el diseño de bases de datos', '2024-07-19'),
(22, 'Denormalización', 'Ventajas y desventajas de la denormalización en el diseño de bases de datos', '2024-07-20'),
(22, 'Optimización de Esquemas', 'Técnicas para optimizar el diseño de esquemas en bases de datos relacionales', '2024-07-21'),
(22, 'Modelado Avanzado', 'Consideraciones avanzadas en el modelado de datos para bases de datos complejas', '2024-07-22'),
(22, 'Herramientas de Modelado', 'Introducción a herramientas de modelado de datos para bases de datos relacionales', '2024-07-23'),
(22, 'Prácticas de Modelado', 'Ejercicios prácticos de modelado de datos para bases de datos reales', '2024-07-24');

-- Clases para la Unidad 3: Normalización de Bases de Datos
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(23, 'Introducción a la Normalización', 'Conceptos básicos de normalización y sus objetivos en el diseño de bases de datos', '2024-08-01'),
(23, 'Primera Forma Normal (1FN)', 'Transformación de tablas a 1FN y eliminación de grupos repetitivos', '2024-08-02'),
(23, 'Segunda Forma Normal (2FN)', 'Transformación de tablas a 2FN y eliminación de dependencias parciales', '2024-08-03'),
(23, 'Tercera Forma Normal (3FN)', 'Transformación de tablas a 3FN y eliminación de dependencias transitivas', '2024-08-04'),
(23, 'Formas Normales Superiores', 'Normalización a BCNF, 4NF y 5NF para casos especiales', '2024-08-05'),
(23, 'Desnormalización Controlada', 'Aplicación de desnormalización selectiva para mejorar el rendimiento', '2024-08-06'),
(23, 'Normalización y Rendimiento', 'Balance entre normalización y rendimiento en el diseño de bases de datos', '2024-08-07'),
(23, 'Normalización Avanzada', 'Consideraciones avanzadas en la normalización de bases de datos', '2024-08-08'),
(23, 'Ejercicios de Normalización', 'Práctica de normalización en bases de datos reales', '2024-08-09'),
(23, 'Aplicaciones Prácticas', 'Aplicación de técnicas de normalización en proyectos de bases de datos', '2024-08-10');

-- Clases para la Unidad 4: SQL Avanzado
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(24, 'Joins Avanzados', 'Uso de joins avanzados como OUTER JOIN, CROSS JOIN y self join', '2024-08-15'),
(24, 'Subconsultas Avanzadas', 'Utilización de subconsultas correlacionadas y subconsultas escalares', '2024-08-16'),
(24, 'Funciones de Ventana', 'Aplicación de funciones de ventana como RANK, ROW_NUMBER y LAG', '2024-08-17'),
(24, 'Expresiones Comunes de Tabla (CTE)', 'Creación y uso de expresiones comunes de tabla para consultas recursivas', '2024-08-18'),
(24, 'Transacciones Avanzadas', 'Gestión avanzada de transacciones con SAVEPOINT y control de bloqueo', '2024-08-19'),
(24, 'Procedimientos Almacenados', 'Creación y uso de procedimientos almacenados en bases de datos SQL', '2024-08-20'),
(24, 'Disparadores (Triggers)', 'Creación y uso de disparadores para automatizar acciones en la base de datos', '2024-08-21'),
(24, 'Vistas Materializadas', 'Creación y uso de vistas materializadas para mejorar el rendimiento', '2024-08-22'),
(24, 'Funciones Definidas por el Usuario (UDF)', 'Desarrollo y uso de funciones definidas por el usuario en SQL', '2024-08-23'),
(24, 'Optimización de Consultas', 'Técnicas para optimizar consultas complejas en bases de datos SQL', '2024-08-24');

-- Clases para la Unidad 5: Bases de Datos No Relacionales
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(25, 'Introducción a Bases de Datos No Relacionales', 'Conceptos básicos y tipos de bases de datos NoSQL', '2024-09-01'),
(25, 'Modelo de Datos No Relacionales', 'Diseño de modelos de datos para bases de datos NoSQL', '2024-09-02'),
(25, 'Tipos de Bases de Datos NoSQL', 'Comparación entre diferentes tipos de bases de datos NoSQL como clave-valor, documentales, columnares y de grafos', '2024-09-03'),
(25, 'Ventajas y Desventajas', 'Análisis de las ventajas y desventajas de las bases de datos NoSQL en comparación con las relacionales', '2024-09-04'),
(25, 'Escalabilidad y Alta Disponibilidad', 'Consideraciones de escalabilidad y alta disponibilidad en bases de datos NoSQL', '2024-09-05'),
(25, 'Consistencia y Tolerancia a Fallos', 'Principios de consistencia y tolerancia a fallos en bases de datos distribuidas', '2024-09-06'),
(25, 'Casos de Uso', 'Aplicaciones y casos de uso comunes de bases de datos NoSQL en la industria', '2024-09-07'),
(25, 'Ejemplos Prácticos', 'Ejemplos prácticos de implementación de bases de datos NoSQL en proyectos reales', '2024-09-08'),
(25, 'Consideraciones de Seguridad', 'Principios de seguridad y mejores prácticas en bases de datos NoSQL', '2024-09-09'),
(25, 'Integración con Aplicaciones', 'Integración de bases de datos NoSQL con aplicaciones web y móviles', '2024-09-10');

-- Clases para la Unidad 6: MongoDB
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(26, 'Introducción a MongoDB', 'Conceptos básicos y características de MongoDB como base de datos NoSQL', '2024-09-15'),
(26, 'Instalación y Configuración', 'Instalación y configuración de MongoDB en diferentes sistemas operativos', '2024-09-16'),
(26, 'Interacción con la Consola de MongoDB', 'Uso de la consola de MongoDB para administrar bases de datos y colecciones', '2024-09-17'),
(26, 'Operaciones CRUD', 'Realización de operaciones CRUD (Create, Read, Update, Delete) en MongoDB', '2024-09-18'),
(26, 'Consultas Avanzadas', 'Realización de consultas avanzadas utilizando el lenguaje de consultas de MongoDB', '2024-09-19'),
(26, 'Índices', 'Creación y uso de índices para mejorar el rendimiento de las consultas en MongoDB', '2024-09-20'),
(26, 'Aggregation Framework', 'Uso del Aggregation Framework de MongoDB para realizar operaciones de agregación', '2024-09-21'),
(26, 'Replicación', 'Configuración y uso de la replicación en MongoDB para alta disponibilidad', '2024-09-22'),
(26, 'Sharding', 'Configuración y uso de sharding en MongoDB para distribución horizontal de datos', '2024-09-23'),
(26, 'Administración y Seguridad', 'Tareas de administración y seguridad en MongoDB', '2024-09-24');

-- Clases para la Unidad 7: Modelado de Datos No Relacionales
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(27, 'Modelado de Datos para Documentos', 'Diseño de modelos de datos para bases de datos documentales como MongoDB', '2024-10-01'),
(27, 'Modelado de Datos para Grafos', 'Diseño de modelos de datos para bases de datos de grafos como Neo4j', '2024-10-02'),
(27, 'Modelado de Datos para Clave-Valor', 'Diseño de modelos de datos para bases de datos clave-valor como Redis', '2024-10-03'),
(27, 'Modelado de Datos para Columnares', 'Diseño de modelos de datos para bases de datos columnares como Cassandra', '2024-10-04'),
(27, 'Casos de Uso', 'Aplicaciones y casos de uso comunes de diferentes tipos de bases de datos NoSQL', '2024-10-05'),
(27, 'Ejemplos Prácticos', 'Ejemplos prácticos de modelado de datos para diferentes tipos de bases de datos NoSQL', '2024-10-06'),
(27, 'Optimización de Esquemas', 'Técnicas para optimizar el diseño de esquemas en bases de datos NoSQL', '2024-10-07'),
(27, 'Migración de Datos', 'Migración de datos entre diferentes tipos de bases de datos NoSQL', '2024-10-08'),
(27, 'Estrategias de Backup y Restauración', 'Definición de estrategias de backup y restauración para bases de datos NoSQL', '2024-10-09'),
(27, 'Consideraciones de Escalabilidad', 'Consideraciones de escalabilidad en el modelado de datos para bases de datos NoSQL', '2024-10-10');

-- Clases para la Unidad 8: Integración con Aplicaciones
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(28, 'Integración con Aplicaciones Web', 'Integración de bases de datos NoSQL con aplicaciones web utilizando frameworks como Express.js', '2024-10-15'),
(28, 'Integración con Aplicaciones Móviles', 'Integración de bases de datos NoSQL con aplicaciones móviles utilizando servicios web', '2024-10-16'),
(28, 'Integración con Sistemas de Mensajería', 'Integración de bases de datos NoSQL con sistemas de mensajería como Kafka', '2024-10-17'),
(28, 'Integración con Big Data', 'Integración de bases de datos NoSQL con sistemas de Big Data como Hadoop', '2024-10-18'),
(28, 'APIs y Servicios Web', 'Desarrollo de APIs y servicios web para interactuar con bases de datos NoSQL', '2024-10-19'),
(28, 'Autenticación y Autorización', 'Implementación de mecanismos de autenticación y autorización en aplicaciones con bases de datos NoSQL', '2024-10-20'),
(28, 'Pruebas de Integración', 'Desarrollo de pruebas de integración para verificar la integración entre aplicaciones y bases de datos NoSQL', '2024-10-21'),
(28, 'Despliegue y Escalabilidad', 'Despliegue de aplicaciones con bases de datos NoSQL y consideraciones de escalabilidad', '2024-10-22'),
(28, 'Monitoreo y Mantenimiento', 'Monitoreo y mantenimiento de la integración entre aplicaciones y bases de datos NoSQL', '2024-10-23'),
(28, 'Optimización de Rendimiento', 'Técnicas para optimizar el rendimiento de la integración entre aplicaciones y bases de datos NoSQL', '2024-10-24');

-- Clases para la Unidad 9: Seguridad en Bases de Datos
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(29, 'Principios de Seguridad', 'Principios fundamentales de seguridad en bases de datos NoSQL y SQL', '2024-11-01'),
(29, 'Autenticación y Autorización', 'Implementación de mecanismos de autenticación y autorización en bases de datos', '2024-11-02'),
(29, 'Control de Acceso', 'Gestión de permisos y roles para controlar el acceso a datos en bases de datos', '2024-11-03'),
(29, 'Auditoría y Registro', 'Registro de actividades y auditoría de acceso a datos en bases de datos', '2024-11-04'),
(29, 'Seguridad en la Transmisión de Datos', 'Protección de datos durante la transmisión utilizando protocolos seguros', '2024-11-05'),
(29, 'Cifrado de Datos', 'Cifrado de datos en reposo y en tránsito para proteger la confidencialidad', '2024-11-06'),
(29, 'Pruebas de Seguridad', 'Realización de pruebas de seguridad para identificar vulnerabilidades en bases de datos', '2024-11-07'),
(29, 'Mejores Prácticas', 'Adopción de mejores prácticas de seguridad en el diseño y administración de bases de datos', '2024-11-08'),
(29, 'Gestión de Incidentes', 'Procedimientos para la gestión de incidentes de seguridad en bases de datos', '2024-11-09'),
(29, 'Cumplimiento Normativo', 'Cumplimiento de normativas y regulaciones de seguridad en bases de datos', '2024-11-10');

-- Clases para la Unidad 10: Proyecto Final: Diseño de Base de Datos
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(30, 'Definición de Requerimientos', 'Recolección y definición de requerimientos para el proyecto final de diseño de base de datos', '2024-11-15'),
(30, 'Diseño Conceptual', 'Elaboración del diseño conceptual de la base de datos basado en los requerimientos', '2024-11-16'),
(30, 'Diseño Lógico', 'Transformación del diseño conceptual a un modelo de datos lógico', '2024-11-17'),
(30, 'Normalización', 'Normalización del modelo lógico para garantizar su integridad y eficiencia', '2024-11-18'),
(30, 'Implementación', 'Creación de la base de datos física a partir del modelo lógico diseñado', '2024-11-19'),
(30, 'Carga de Datos', 'Carga inicial de datos en la base de datos para pruebas y validación', '2024-11-20'),
(30, 'Pruebas y Validación', 'Realización de pruebas y validación del diseño y funcionamiento de la base de datos', '2024-11-21'),
(30, 'Documentación', 'Elaboración de documentación técnica y manual de usuario para la base de datos', '2024-11-22'),
(30, 'Presentación y Defensa', 'Preparación y presentación del proyecto final ante el comité evaluador', '2024-11-23'),
(30, 'Entrega Final', 'Entrega del proyecto final con todos los documentos y artefactos generados', '2024-11-24');

-- CLASES PARA MACHINE LEARNING
-- Clases para la Unidad 1: Introducción al Aprendizaje Automático
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(31, 'Conceptos Básicos de Aprendizaje Automático', 'Definición y alcance del aprendizaje automático', '2024-08-01'),
(31, 'Historia y Evolución del Aprendizaje Automático', 'Evolución histórica y principales hitos del aprendizaje automático', '2024-08-02'),
(31, 'Aplicaciones del Aprendizaje Automático', 'Áreas de aplicación y casos de uso del aprendizaje automático en la actualidad', '2024-08-03'),
(31, 'Tipos de Aprendizaje', 'Introducción a los tipos de aprendizaje: supervisado, no supervisado y por refuerzo', '2024-08-04'),
(31, 'Proceso de Aprendizaje', 'Fases del proceso de aprendizaje automático: entrenamiento, validación y prueba', '2024-08-05'),
(31, 'Evaluación de Modelos', 'Métodos y métricas para evaluar el rendimiento de modelos de aprendizaje automático', '2024-08-06'),
(31, 'Herramientas y Frameworks', 'Visión general de herramientas y frameworks populares en el campo del aprendizaje automático', '2024-08-07'),
(31, 'Desafíos y Limitaciones', 'Desafíos técnicos y éticos en la aplicación práctica del aprendizaje automático', '2024-08-08'),
(31, 'Tendencias Futuras', 'Tendencias emergentes y avances futuros en el campo del aprendizaje automático', '2024-08-09'),
(31, 'Ética en el Aprendizaje Automático', 'Consideraciones éticas y sociales en el desarrollo y aplicación de modelos de aprendizaje automático', '2024-08-10');

-- Clases para la Unidad 2: Clasificación y Regresión
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(32, 'Introducción a la Clasificación', 'Conceptos básicos y fundamentos de la clasificación en aprendizaje automático', '2024-08-15'),
(32, 'Algoritmos de Clasificación', 'Revisión de algoritmos de clasificación como Árboles de Decisión y K-Vecinos Más Cercanos', '2024-08-16'),
(32, 'Regresión en Aprendizaje Automático', 'Definición y aplicación de modelos de regresión en problemas de aprendizaje automático', '2024-08-17'),
(32, 'Evaluación de Modelos de Clasificación', 'Técnicas de evaluación y métricas para modelos de clasificación', '2024-08-18'),
(32, 'Evaluación de Modelos de Regresión', 'Métodos para evaluar la precisión y rendimiento de modelos de regresión', '2024-08-19'),
(32, 'Selección de Características', 'Métodos y estrategias para seleccionar características relevantes en modelos de aprendizaje automático', '2024-08-20'),
(32, 'Validación Cruzada', 'Técnica de validación cruzada para evaluar el rendimiento de modelos de aprendizaje automático', '2024-08-21'),
(32, 'Sobreajuste y Subajuste', 'Problemas comunes como el sobreajuste y subajuste en modelos de aprendizaje automático', '2024-08-22'),
(32, 'Regresión Polinómica', 'Aplicación de regresión polinómica para modelar relaciones no lineales', '2024-08-23'),
(32, 'Clasificación Multiclase', 'Estrategias y algoritmos para problemas de clasificación multiclase', '2024-08-24');

-- Clases para la Unidad 3: Agrupamiento
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(33, 'Introducción al Agrupamiento', 'Conceptos fundamentales y objetivos del agrupamiento de datos', '2024-09-01'),
(33, 'Algoritmos de Agrupamiento', 'Revisión de algoritmos de agrupamiento como K-Means y DBSCAN', '2024-09-02'),
(33, 'Validación de Agrupamientos', 'Métodos y métricas para evaluar la calidad de los agrupamientos', '2024-09-03'),
(33, 'Agrupamiento Jerárquico', 'Concepto y aplicación de técnicas de agrupamiento jerárquico', '2024-09-04'),
(33, 'Agrupamiento Espectral', 'Aplicación de técnicas de agrupamiento espectral en conjuntos de datos complejos', '2024-09-05'),
(33, 'Agrupamiento Basado en Densidad', 'Principios y aplicaciones de algoritmos de agrupamiento basados en densidad', '2024-09-06'),
(33, 'Agrupamiento Probabilístico', 'Modelos probabilísticos y algoritmos de agrupamiento basados en distribuciones de probabilidad', '2024-09-07'),
(33, 'Agrupamiento por Subespacios', 'Técnicas de agrupamiento para datos de alta dimensionalidad', '2024-09-08'),
(33, 'Agrupamiento Fuzzy', 'Concepto y aplicaciones de técnicas de agrupamiento difuso', '2024-09-09'),
(33, 'Aplicaciones de Agrupamiento', 'Casos de uso y aplicaciones prácticas del agrupamiento de datos en diferentes campos', '2024-09-10');

-- Clases para la Unidad 4: Aprendizaje No Supervisado
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(34, 'Introducción al Aprendizaje No Supervisado', 'Conceptos básicos y diferencias con el aprendizaje supervisado', '2024-09-15'),
(34, 'Agrupamiento K-Means', 'Descripción y aplicación del algoritmo de agrupamiento K-Means', '2024-09-16'),
(34, 'Análisis de Componentes Principales (PCA)', 'Teoría y aplicaciones del análisis de componentes principales en la reducción de dimensionalidad', '2024-09-17'),
(34, 'Agrupamiento Jerárquico', 'Conceptos y métodos de agrupamiento jerárquico en aprendizaje no supervisado', '2024-09-18'),
(34, 'Agrupamiento Espectral', 'Uso de técnicas de agrupamiento espectral en la detección de comunidades y segmentación de datos', '2024-09-19'),
(34, 'Detección de Anomalías', 'Métodos para la detección de anomalías y valores atípicos en conjuntos de datos', '2024-09-20'),
(34, 'Reducción de Dimensionalidad', 'Técnicas de reducción de dimensionalidad como t-SNE y UMAP', '2024-09-21'),
(34, 'Aprendizaje No Supervisado Profundo', 'Aplicaciones de redes neuronales no supervisadas en la extracción de características', '2024-09-22'),
(34, 'Clustering Basado en Densidad', 'Algoritmos de clustering basados en la densidad de los datos', '2024-09-23'),
(34, 'Aplicaciones Prácticas', 'Ejemplos de aplicaciones prácticas del aprendizaje no supervisado en diferentes campos', '2024-09-24');

-- Clases para la Unidad 5: Aprendizaje Profundo
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(35, 'Introducción al Aprendizaje Profundo', 'Conceptos básicos y motivación detrás del aprendizaje profundo', '2024-10-01'),
(35, 'Redes Neuronales Artificiales', 'Arquitectura y funcionamiento de redes neuronales artificiales', '2024-10-02'),
(35, 'Redes Convolucionales', 'Aplicaciones de redes convolucionales en visión por computadora', '2024-10-03'),
(35, 'Redes Neuronales Recurrentes', 'Modelado de secuencias y aplicaciones de redes neuronales recurrentes', '2024-10-04'),
(35, 'Autoencoders', 'Concepto y aplicaciones de autoencoders en la reducción de dimensionalidad y generación de datos', '2024-10-05'),
(35, 'Redes Generativas Adversariales (GANs)', 'Arquitectura y aplicaciones de GANs en la generación de imágenes y datos sintéticos', '2024-10-06'),
(35, 'Transfer Learning', 'Uso de transfer learning para transferir conocimiento entre dominios y tareas', '2024-10-07'),
(35, 'Optimización de Modelos Profundos', 'Métodos de optimización y entrenamiento de modelos profundos', '2024-10-08'),
(35, 'Interpretación de Modelos', 'Técnicas para interpretar y comprender el comportamiento de modelos profundos', '2024-10-09'),
(35, 'Aplicaciones Prácticas', 'Ejemplos y casos de uso del aprendizaje profundo en diferentes aplicaciones y campos', '2024-10-10');

-- Clases para la Unidad 6: Procesamiento de Lenguaje Natural
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(36, 'Introducción al Procesamiento de Lenguaje Natural', 'Conceptos básicos y aplicaciones del procesamiento de lenguaje natural', '2024-10-15'),
(36, 'Preprocesamiento de Texto', 'Técnicas de limpieza y preprocesamiento de texto en NLP', '2024-10-16'),
(36, 'Modelos de Lenguaje y Tokenización', 'Modelos de lenguaje estadísticos y tokenización de texto', '2024-10-17'),
(36, 'Extracción de Características', 'Métodos de extracción de características en NLP como TF-IDF y Word Embeddings', '2024-10-18'),
(36, 'Modelos de Secuencia', 'Modelado de secuencias y aplicaciones en tareas de NLP', '2024-10-19'),
(36, 'Análisis de Sentimientos', 'Análisis de sentimientos en texto y clasificación de opiniones', '2024-10-20'),
(36, 'Clasificación de Texto', 'Técnicas de clasificación de texto y análisis de categorías', '2024-10-21'),
(36, 'Generación de Texto', 'Modelos generativos de texto y generación de texto predictivo', '2024-10-22'),
(36, 'Traducción Automática', 'Métodos y enfoques en la traducción automática de texto', '2024-10-23'),
(36, 'Aplicaciones Prácticas', 'Ejemplos de aplicaciones prácticas del procesamiento de lenguaje natural en diversas áreas', '2024-10-24');

-- Clases para la Unidad 7: Visión por Computadora
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(37, 'Introducción a la Visión por Computadora', 'Conceptos fundamentales y aplicaciones de la visión por computadora', '2024-11-01'),
(37, 'Procesamiento de Imágenes', 'Técnicas de preprocesamiento y mejora de imágenes digitales', '2024-11-02'),
(37, 'Detección de Objetos', 'Algoritmos y métodos para la detección y localización de objetos en imágenes', '2024-11-03'),
(37, 'Segmentación de Imágenes', 'Técnicas de segmentación y partición de imágenes en regiones significativas', '2024-11-04'),
(37, 'Reconocimiento Facial', 'Aplicaciones y algoritmos para el reconocimiento facial en imágenes', '2024-11-05'),
(37, 'Clasificación de Imágenes', 'Métodos de clasificación y etiquetado automático de imágenes', '2024-11-06'),
(37, 'Reconstrucción 3D', 'Técnicas y algoritmos para la reconstrucción tridimensional a partir de imágenes', '2024-11-07'),
(37, 'Realidad Aumentada', 'Aplicaciones y tecnologías de realidad aumentada basadas en visión por computadora', '2024-11-08'),
(37, 'Análisis de Movimiento', 'Seguimiento y análisis de movimiento en secuencias de vídeo', '2024-11-09'),
(37, 'Aplicaciones Prácticas', 'Ejemplos de aplicaciones de visión por computadora en campos como la medicina, la industria y el entretenimiento', '2024-11-10');

-- Clases para la Unidad 8: Reinforcement Learning
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(38, 'Introducción al Aprendizaje por Refuerzo', 'Conceptos básicos y formulación del problema en aprendizaje por refuerzo', '2024-11-15'),
(38, 'Procesos de Decisión de Markov (MDP)', 'Modelado y resolución de problemas de decisión secuencial', '2024-11-16'),
(38, 'Algoritmos de Aprendizaje', 'Algoritmos clásicos y modernos en aprendizaje por refuerzo', '2024-11-17'),
(38, 'Exploración y Explotación', 'Equilibrio entre la exploración de nuevas acciones y la explotación de conocimiento', '2024-11-18'),
(38, 'Aproximación de Funciones', 'Técnicas de aproximación de funciones y representación del valor', '2024-11-19'),
(38, 'Aprendizaje Profundo y Reinforcement Learning', 'Aplicaciones de redes neuronales en aprendizaje por refuerzo', '2024-11-20'),
(38, 'Políticas y Métodos Basados en Modelos', 'Definición de políticas y métodos basados en modelos en RL', '2024-11-21'),
(38, 'Aprendizaje por Refuerzo Distribuido', 'Aplicaciones de aprendizaje por refuerzo en entornos distribuidos', '2024-11-22'),
(38, 'Aplicaciones en Juegos', 'Aplicaciones de aprendizaje por refuerzo en juegos y simulaciones', '2024-11-23'),
(38, 'Aplicaciones en Robótica', 'Aplicaciones prácticas de RL en robótica y control de sistemas', '2024-11-24');

-- Clases para la Unidad 9: Ética y Responsabilidad
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(39, 'Ética en la Ciencia de Datos', 'Principios éticos y responsabilidades en el uso de datos y algoritmos', '2024-12-01'),
(39, 'Bias y Fairness', 'Identificación y mitigación de sesgos en modelos y datos', '2024-12-02'),
(39, 'Transparencia y Explicabilidad', 'Requisitos y técnicas para hacer modelos más transparentes y explicables', '2024-12-03'),
(39, 'Privacidad y Seguridad de Datos', 'Protección de la privacidad y la seguridad de los datos personales', '2024-12-04'),
(39, 'Regulaciones y Cumplimiento', 'Marco regulatorio y cumplimiento normativo en ciencia de datos y AI', '2024-12-05'),
(39, 'Impacto Social', 'Evaluación del impacto social y económico de la ciencia de datos y la IA', '2024-12-06'),
(39, 'Gobernanza de Datos', 'Principios y prácticas para la gestión y gobernanza de datos', '2024-12-07'),
(39, 'Responsabilidad Profesional', 'Roles y responsabilidades de los profesionales de datos y AI', '2024-12-08'),
(39, 'Códigos de Conducta', 'Desarrollo y adopción de códigos de conducta y ética profesional', '2024-12-09'),
(39, 'Ética en la Investigación', 'Consideraciones éticas en la investigación científica y la experimentación', '2024-12-10');

-- Clases para la Unidad 10: Proyecto Final: Aplicación de Machine Learning
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(40, 'Definición del Proyecto', 'Establecimiento de objetivos, alcance y requisitos del proyecto final', '2024-12-15'),
(40, 'Análisis y Preparación de Datos', 'Exploración y limpieza de datos para el desarrollo del proyecto', '2024-12-16'),
(40, 'Diseño de Modelo', 'Selección y diseño de modelos de aprendizaje automático para el proyecto', '2024-12-17'),
(40, 'Entrenamiento y Validación', 'Entrenamiento y evaluación de modelos utilizando técnicas de validación cruzada', '2024-12-18'),
(40, 'Optimización de Modelos', 'Ajuste de hiperparámetros y optimización del rendimiento del modelo', '2024-12-19'),
(40, 'Despliegue de la Aplicación', 'Implementación y despliegue de la aplicación de aprendizaje automático', '2024-12-20'),
(40, 'Pruebas y Evaluación', 'Pruebas funcionales y evaluación de la aplicación en un entorno de producción', '2024-12-21'),
(40, 'Documentación y Presentación', 'Elaboración de documentación técnica y presentación del proyecto final', '2024-12-22'),
(40, 'Revisión y Retroalimentación', 'Revisión del proyecto final y retroalimentación por parte de los instructores', '2024-12-23'),
(40, 'Entrega y Cierre', 'Entrega final del proyecto y cierre del curso', '2024-12-24');

-- CLASES PARA DESARROLLO DE VIDEOJUEGOS
-- Clases para la Unidad 1: Introducción a los Videojuegos
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(41, 'Historia y Conceptos Básicos', 'Introducción a la historia y los conceptos fundamentales de los videojuegos', '2024-09-01'),
(41, 'Evolución de los Videojuegos', 'Análisis de la evolución de los videojuegos a lo largo del tiempo', '2024-09-02'),
(41, 'Plataformas y Géneros', 'Exploración de las diferentes plataformas y géneros de videojuegos', '2024-09-03'),
(41, 'Cultura Gamer', 'Estudio de la cultura y la comunidad en torno a los videojuegos', '2024-09-04'),
(41, 'Tecnología y Hardware', 'Impacto de la tecnología y el hardware en el desarrollo de videojuegos', '2024-09-05'),
(41, 'Tendencias Actuales', 'Análisis de las tendencias actuales y futuras en la industria de los videojuegos', '2024-09-06'),
(41, 'Ética en los Videojuegos', 'Consideraciones éticas y sociales en el diseño y desarrollo de videojuegos', '2024-09-07'),
(41, 'Impacto Cultural', 'Exploración del impacto cultural y social de los videojuegos en la sociedad', '2024-09-08'),
(41, 'Desafíos y Oportunidades', 'Desafíos y oportunidades en la industria del desarrollo de videojuegos', '2024-09-09'),
(41, 'Perspectivas de Carrera', 'Opciones de carrera y roles en la industria del desarrollo de videojuegos', '2024-09-10');

-- Clases para la Unidad 2: Diseño de Juegos
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(42, 'Principios de Diseño de Juegos', 'Fundamentos y principios clave en el diseño de juegos', '2024-09-15'),
(42, 'Narrativa y Temática', 'Creación de historias y temáticas atractivas para videojuegos', '2024-09-16'),
(42, 'Personajes y Mundo del Juego', 'Desarrollo de personajes y entornos de juego memorables', '2024-09-17'),
(42, 'Mecánicas y Jugabilidad', 'Diseño e implementación de mecánicas de juego innovadoras', '2024-09-18'),
(42, 'Progresión y Retención', 'Diseño de sistemas de progresión y retención de jugadores', '2024-09-19'),
(42, 'Economía de Juegos', 'Implementación de sistemas económicos y monetización en videojuegos', '2024-09-20'),
(42, 'Equilibrio y Ajuste', 'Ajuste y equilibrio de dificultad y mecánicas de juego', '2024-09-21'),
(42, 'Iteración y Prototipado', 'Proceso de iteración y prototipado en el diseño de juegos', '2024-09-22'),
(42, 'Feedback de Jugadores', 'Recopilación y análisis de feedback de jugadores para mejorar el diseño', '2024-09-23'),
(42, 'Desafíos y Consideraciones', 'Desafíos técnicos y consideraciones en el diseño de juegos', '2024-09-24');

-- Clases para la Unidad 3: Desarrollo de Juegos 2D
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(43, 'Fundamentos de Juegos 2D', 'Conceptos básicos y características de los juegos en dos dimensiones', '2024-10-01'),
(43, 'Herramientas de Desarrollo', 'Uso de herramientas específicas para el desarrollo de juegos 2D', '2024-10-02'),
(43, 'Sprites y Animaciones', 'Creación y animación de sprites para juegos 2D', '2024-10-03'),
(43, 'Física en Juegos 2D', 'Implementación de física y colisiones en juegos en 2D', '2024-10-04'),
(43, 'Interfaz de Usuario', 'Diseño e implementación de interfaces de usuario para juegos 2D', '2024-10-05'),
(43, 'Sonido y Música', 'Uso de efectos de sonido y música en juegos 2D', '2024-10-06'),
(43, 'Optimización de Rendimiento', 'Técnicas de optimización de rendimiento en juegos 2D', '2024-10-07'),
(43, 'Publicación y Distribución', 'Proceso de publicación y distribución de juegos 2D', '2024-10-08'),
(43, 'Monetización', 'Estrategias y métodos de monetización para juegos 2D', '2024-10-09'),
(43, 'Proyecto Final: Juego 2D', 'Desarrollo de un juego completo en dos dimensiones', '2024-10-10');

-- Clases para la Unidad 4: Desarrollo de Juegos 3D
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(44, 'Introducción a Juegos 3D', 'Conceptos básicos y características de los juegos en tres dimensiones', '2024-10-15'),
(44, 'Herramientas de Modelado', 'Uso de software de modelado para la creación de entornos y personajes en 3D', '2024-10-16'),
(44, 'Animación 3D', 'Creación y animación de modelos y personajes en 3D', '2024-10-17'),
(44, 'Física en Juegos 3D', 'Implementación de física y colisiones en juegos en 3D', '2024-10-18'),
(44, 'Iluminación y Renderizado', 'Técnicas de iluminación y renderizado en juegos 3D', '2024-10-19'),
(44, 'Sonido Espacial', 'Uso de sonido espacial para mejorar la inmersión en juegos 3D', '2024-10-20'),
(44, 'Realidad Virtual (VR)', 'Principios básicos y desarrollo de juegos para realidad virtual', '2024-10-21'),
(44, 'Realidad Aumentada (AR)', 'Conceptos y aplicaciones de la realidad aumentada en juegos', '2024-10-22'),
(44, 'Desarrollo Multiplataforma', 'Adaptación y distribución de juegos 3D en diferentes plataformas', '2024-10-23'),
(44, 'Proyecto Final: Juego 3D', 'Desarrollo de un juego completo en tres dimensiones', '2024-10-24');

-- Clases para la Unidad 5: Física en los Videojuegos
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(45, 'Principios de Física en Videojuegos', 'Aplicación de principios físicos en la simulación de movimientos y comportamientos', '2024-11-01'),
(45, 'Movimiento y Colisiones', 'Implementación de movimientos y detección de colisiones en videojuegos', '2024-11-02'),
(45, 'Dinámica de Objetos', 'Simulación de la dinámica de objetos y sistemas en videojuegos', '2024-11-03'),
(45, 'Gravedad y Simulación de Fluidos', 'Modelado de la gravedad y simulación de fluidos en videojuegos', '2024-11-04'),
(45, 'Mecánicas de Física Avanzada', 'Implementación de mecánicas de física avanzada en videojuegos', '2024-11-05'),
(45, 'Impacto en el Gameplay', 'Cómo la física afecta la jugabilidad y la experiencia del jugador', '2024-11-06'),
(45, 'Física en Juegos 2D y 3D', 'Diferencias y similitudes en la implementación de física en juegos 2D y 3D', '2024-11-07'),
(45, 'Herramientas y Frameworks', 'Uso de herramientas y frameworks para la simulación de física en videojuegos', '2024-11-08'),
(45, 'Aplicaciones en la Industria', 'Casos de uso y aplicaciones de la física en la industria de los videojuegos', '2024-11-09'),
(45, 'Proyecto Final: Juego Físico', 'Desarrollo de un juego que hace un uso significativo de la física', '2024-11-10');

-- Clases para la Unidad 6: IA en los Videojuegos
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(46, 'Introducción a la Inteligencia Artificial en Videojuegos', 'Conceptos básicos y aplicaciones de la IA en videojuegos', '2024-11-15'),
(46, 'Agentes y Comportamiento', 'Diseño y programación de agentes para comportamientos en videojuegos', '2024-11-16'),
(46, 'Algoritmos de Búsqueda', 'Implementación de algoritmos de búsqueda para toma de decisiones en videojuegos', '2024-11-17'),
(46, 'Redes Neuronales Artificiales', 'Uso de redes neuronales para implementar IA en videojuegos', '2024-11-18'),
(46, 'Aprendizaje Automático en Juegos', 'Aplicación de técnicas de aprendizaje automático para mejorar la IA en videojuegos', '2024-11-19'),
(46, 'Planificación y Estrategia', 'Planificación de estrategias y toma de decisiones a largo plazo en videojuegos', '2024-11-20'),
(46, 'Tecnologías Emergentes', 'Exploración de tecnologías emergentes en IA para videojuegos', '2024-11-21'),
(46, 'Aplicaciones Prácticas', 'Casos de estudio y aplicaciones prácticas de la IA en la industria de los videojuegos', '2024-11-22'),
(46, 'Ética y Limitaciones', 'Consideraciones éticas y limitaciones de la IA en el diseño de videojuegos', '2024-11-23'),
(46, 'Proyecto Final: Juego con IA', 'Desarrollo de un juego que hace un uso significativo de la IA', '2024-11-24');

-- Clases para la Unidad 7: Diseño de Niveles
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(47, 'Principios de Diseño de Niveles', 'Conceptos básicos y principios fundamentales en el diseño de niveles', '2024-12-01'),
(47, 'Flujo del Jugador', 'Diseño de niveles centrado en la experiencia del jugador', '2024-12-02'),
(47, 'Diseño de Escenarios', 'Creación y planificación de escenarios para videojuegos', '2024-12-03'),
(47, 'Progresión y Dificultad', 'Equilibrio entre progresión del juego y dificultad de los niveles', '2024-12-04'),
(47, 'Narrativa en los Niveles', 'Uso de narrativa para guiar al jugador a través de los niveles', '2024-12-05'),
(47, 'Pruebas y Ajustes', 'Métodos de prueba y ajuste para mejorar el diseño de niveles', '2024-12-06'),
(47, 'Rejugabilidad', 'Diseño de niveles que fomenten la rejugabilidad y exploración', '2024-12-07'),
(47, 'Feedback del Jugador', 'Recopilación y análisis del feedback del jugador para iterar en el diseño de niveles', '2024-12-08'),
(47, 'Herramientas de Diseño', 'Uso de herramientas específicas para el diseño de niveles', '2024-12-09'),
(47, 'Proyecto Final: Nivel Diseñado', 'Creación y documentación de un nivel diseñado para un juego', '2024-12-10');

-- Clases para la Unidad 8: Sonido y Música
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(48, 'Fundamentos de Audio en Videojuegos', 'Conceptos básicos y características del audio en videojuegos', '2024-12-15'),
(48, 'Creación de Efectos de Sonido', 'Técnicas de creación y edición de efectos de sonido para videojuegos', '2024-12-16'),
(48, 'Composición Musical', 'Principios básicos de composición musical para videojuegos', '2024-12-17'),
(48, 'Implementación de Audio', 'Integración y programación de audio en el desarrollo de videojuegos', '2024-12-18'),
(48, 'Diseño Sonoro', 'Creación de ambientes y atmosferas sonoras para videojuegos', '2024-12-19'),
(48, 'Música Adaptativa', 'Uso de música adaptativa para mejorar la experiencia del jugador', '2024-12-20'),
(48, 'Grabación y Edición', 'Técnicas de grabación y edición de audio para videojuegos', '2024-12-21'),
(48, 'Implementación de Diálogos', 'Integración de diálogos y narrativa sonora en videojuegos', '2024-12-22'),
(48, 'Mezcla y Masterización', 'Procesos de mezcla y masterización para optimizar el audio en videojuegos', '2024-12-23'),
(48, 'Proyecto Final: Diseño de Sonido', 'Creación y aplicación de una banda sonora y efectos de sonido para un juego', '2024-12-24');

-- Clases para la Unidad 9: Pruebas y Debugging
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(49, 'Importancia de las Pruebas en Videojuegos', 'Razones y beneficios de realizar pruebas de calidad en videojuegos', '2025-01-01'),
(49, 'Tipos de Pruebas', 'Diferentes tipos de pruebas y enfoques para evaluar la calidad de un juego', '2025-01-02'),
(49, 'Herramientas de Pruebas', 'Uso de herramientas específicas para la automatización y gestión de pruebas', '2025-01-03'),
(49, 'Pruebas Funcionales', 'Evaluación de la funcionalidad y comportamiento del juego', '2025-01-04'),
(49, 'Pruebas de Rendimiento', 'Medición y optimización del rendimiento del juego', '2025-01-05'),
(49, 'Pruebas de Usabilidad', 'Evaluación de la experiencia del usuario y usabilidad del juego', '2025-01-06'),
(49, 'Pruebas de Compatibilidad', 'Verificación de la compatibilidad del juego con diferentes dispositivos y plataformas', '2025-01-07'),
(49, 'Debugging', 'Identificación y resolución de errores y fallos en el juego', '2025-01-08'),
(49, 'Proceso de Iteración', 'Iteración en el proceso de pruebas y debugging para mejorar la calidad del juego', '2025-01-09'),
(49, 'Proyecto Final: Juego Depurado', 'Presentación de un juego depurado y listo para su lanzamiento', '2025-01-10');

-- Clases para la Unidad 10: Proyecto Final: Videojuego Completo
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(50, 'Fase de Planificación', 'Definición de objetivos, alcance y requerimientos del proyecto final', '2025-01-15'),
(50, 'Desarrollo', 'Implementación de las diferentes etapas del desarrollo del juego', '2025-01-16'),
(50, 'Testing y Ajustes', 'Pruebas exhaustivas y ajustes finales para asegurar la calidad del juego', '2025-01-17'),
(50, 'Entrega y Presentación', 'Preparación y entrega del proyecto final junto con una presentación', '2025-01-18'),
(50, 'Feedback y Evaluación', 'Recopilación de feedback y evaluación del proyecto final por parte de los instructores', '2025-01-19'),
(50, 'Refinamiento y Mejora', 'Iteración y mejoras adicionales basadas en el feedback recibido', '2025-01-20'),
(50, 'Preparación para el Lanzamiento', 'Preparativos finales para el lanzamiento del juego al mercado', '2025-01-21'),
(50, 'Marketing y Promoción', 'Estrategias de marketing y promoción para el juego', '2025-01-22'),
(50, 'Lanzamiento', 'Lanzamiento oficial del juego en plataformas seleccionadas', '2025-01-23'),
(50, 'Post-Lanzamiento y Mantenimiento', 'Soporte, actualizaciones y mantenimiento del juego después del lanzamiento', '2025-01-24');

-- CLASES PARA MARKETING DIGITAL
-- Clases para la Unidad 1: Fundamentos de Marketing
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(51, 'Introducción al Marketing', 'Principios básicos y conceptos fundamentales del marketing', '2024-10-01'),
(51, 'Investigación de Mercado', 'Métodos y técnicas para investigar y analizar el mercado objetivo', '2024-10-02'),
(51, 'Segmentación de Mercado', 'División del mercado en grupos homogéneos para una mejor estrategia de marketing', '2024-10-03'),
(51, 'Posicionamiento de Marca', 'Cómo posicionar una marca en la mente del consumidor', '2024-10-04'),
(51, 'Marketing Mix (Las 4P)', 'Producto, precio, plaza y promoción: los elementos clave del marketing mix', '2024-10-05'),
(51, 'Estrategias de Marketing', 'Diferentes enfoques y estrategias para alcanzar los objetivos de marketing', '2024-10-06'),
(51, 'Marketing Digital vs. Tradicional', 'Comparación entre estrategias de marketing digital y tradicional', '2024-10-07'),
(51, 'Tendencias en Marketing', 'Tecnologías emergentes y tendencias actuales en el mundo del marketing', '2024-10-08'),
(51, 'Marketing de Contenidos', 'Creación y distribución de contenido para atraer y retener clientes', '2024-10-09'),
(51, 'Marketing de Contenidos', 'Creación y distribución de contenido para atraer y retener clientes', '2024-10-10');

-- Clases para la Unidad 2: Marketing en Redes Sociales
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(52, 'Uso Estratégico de Redes Sociales', 'Cómo utilizar las redes sociales como herramientas de marketing', '2024-10-15'),
(52, 'Estrategias de Contenido en Redes Sociales', 'Creación y distribución de contenido efectivo en redes sociales', '2024-10-16'),
(52, 'Publicidad en Redes Sociales', 'Diseño y gestión de campañas publicitarias en plataformas de redes sociales', '2024-10-17'),
(52, 'Community Management', 'Gestión de comunidades en redes sociales y atención al cliente', '2024-10-18'),
(52, 'Influencer Marketing', 'Colaboraciones con influencers para promocionar productos y servicios', '2024-10-19'),
(52, 'Análisis de Métricas', 'Medición y análisis de métricas para evaluar el desempeño en redes sociales', '2024-10-20'),
(52, 'Campañas de Engagement', 'Estrategias para fomentar la participación y el compromiso en redes sociales', '2024-10-21'),
(52, 'Monitorización de Redes Sociales', 'Herramientas y técnicas para monitorear la presencia en redes sociales', '2024-10-22'),
(52, 'Casos de Éxito', 'Estudio de casos exitosos de marketing en redes sociales', '2024-10-23'),
(52, 'Tendencias Futuras', 'Exploración de las tendencias futuras en el marketing en redes sociales', '2024-10-24');

-- Clases para la Unidad 3: Publicidad en Línea
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(53, 'Tipos de Publicidad en Línea', 'Análisis de los diferentes tipos de publicidad en línea', '2024-11-01'),
(53, 'Google Ads', 'Creación y gestión de campañas publicitarias en Google Ads', '2024-11-02'),
(53, 'Facebook Ads', 'Diseño y optimización de anuncios en Facebook Ads', '2024-11-03'),
(53, 'Instagram Ads', 'Estrategias de publicidad en Instagram y creación de anuncios efectivos', '2024-11-04'),
(53, 'LinkedIn Ads', 'Uso de LinkedIn Ads para la generación de leads y el desarrollo de la marca', '2024-11-05'),
(53, 'Twitter Ads', 'Creación de campañas publicitarias efectivas en Twitter', '2024-11-06'),
(53, 'Publicidad en YouTube', 'Estrategias y mejores prácticas para la publicidad en YouTube', '2024-11-07'),
(53, 'Remarketing', 'Implementación de estrategias de remarketing para aumentar las conversiones', '2024-11-08'),
(53, 'Optimización de Conversiones', 'Técnicas para mejorar las tasas de conversión en campañas publicitarias', '2024-11-09'),
(53, 'Análisis de Resultados', 'Interpretación de métricas y análisis de resultados de campañas publicitarias', '2024-11-10');

-- Clases para la Unidad 4: SEO (Optimización en Motores de Búsqueda)
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(54, 'Introducción al SEO', 'Conceptos básicos de SEO y su importancia en el marketing digital', '2024-11-15'),
(54, 'Keyword Research', 'Investigación y selección de palabras clave relevantes para la optimización de sitios web', '2024-11-16'),
(54, 'Optimización On-Page', 'Estrategias para optimizar el contenido y la estructura de un sitio web', '2024-11-17'),
(54, 'Optimización Off-Page', 'Técnicas para mejorar la autoridad y la relevancia de un sitio web desde fuera de él', '2024-11-18'),
(54, 'Link Building', 'Creación de enlaces de calidad para mejorar el posicionamiento en buscadores', '2024-11-19'),
(54, 'SEO Técnico', 'Aspectos técnicos y de rendimiento que afectan al SEO de un sitio web', '2024-11-20'),
(54, 'SEO Local', 'Optimización para resultados de búsqueda locales y Google My Business', '2024-11-21'),
(54, 'SEO Móvil', 'Optimización de sitios web para dispositivos móviles y su impacto en el SEO', '2024-11-22'),
(54, 'Herramientas de SEO', 'Uso de herramientas y software para análisis y seguimiento del SEO', '2024-11-23'),
(54, 'Estrategias Avanzadas', 'Tácticas y estrategias avanzadas para mejorar el SEO de un sitio web', '2024-11-24');

-- Clases para la Unidad 5: SEM (Marketing en Motores de Búsqueda)
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(55, 'Introducción al SEM', 'Conceptos básicos de SEM y su relación con el marketing digital', '2024-12-01'),
(55, 'Google Ads', 'Creación y gestión de campañas publicitarias en Google Ads', '2024-12-02'),
(55, 'Bing Ads', 'Uso de Bing Ads para la publicidad en motores de búsqueda', '2024-12-03'),
(55, 'Estrategias de Puja', 'Definición de estrategias de puja para maximizar el retorno de la inversión', '2024-12-04'),
(55, 'Anuncios de Texto', 'Diseño y redacción de anuncios de texto efectivos para campañas de SEM', '2024-12-05'),
(55, 'Anuncios Gráficos', 'Creación y optimización de anuncios gráficos para campañas de SEM', '2024-12-06'),
(55, 'Remarketing', 'Implementación de estrategias de remarketing para aumentar las conversiones', '2024-12-07'),
(55, 'Segmentación de Audiencia', 'Utilización de la segmentación de audiencia para llegar al público objetivo', '2024-12-08'),
(55, 'Optimización de Campañas', 'Técnicas para mejorar el rendimiento y la eficacia de las campañas SEM', '2024-12-09'),
(55, 'Análisis de Resultados', 'Interpretación de métricas y análisis de resultados de campañas SEM', '2024-12-10');

-- Clases para la Unidad 6: Email Marketing
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(56, 'Introducción al Email Marketing', 'Conceptos básicos y beneficios del Email Marketing en el marketing digital', '2024-12-15'),
(56, 'Creación de Listas de Suscriptores', 'Métodos para construir y gestionar listas de suscriptores efectivas', '2024-12-16'),
(56, 'Diseño de Campañas de Email', 'Diseño y estructura de campañas de Email Marketing atractivas y efectivas', '2024-12-17'),
(56, 'Automatización de Email', 'Uso de la automatización para crear flujos de trabajo y campañas personalizadas', '2024-12-18'),
(56, 'Segmentación de Audiencia', 'Utilización de la segmentación para enviar mensajes personalizados y relevantes', '2024-12-19'),
(56, 'Contenido de Email', 'Creación de contenido persuasivo y relevante para campañas de Email Marketing', '2024-12-20'),
(56, 'Técnicas de Copywriting', 'Escritura persuasiva y creación de asuntos efectivos para correos electrónicos', '2024-12-21'),
(56, 'Optimización de Tasa de Apertura', 'Estrategias para mejorar la tasa de apertura y la entregabilidad de los correos electrónicos', '2024-12-22'),
(56, 'Métricas y Análisis', 'Interpretación de métricas y análisis de resultados de campañas de Email Marketing', '2024-12-23'),
(56, 'Regulaciones y Buenas Prácticas', 'Cumplimiento de regulaciones y mejores prácticas en Email Marketing', '2024-12-24');

-- Clases para la Unidad 7: Marketing de Contenidos
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(57, 'Qué es el Marketing de Contenidos', 'Definición y objetivos del Marketing de Contenidos en el marketing digital', '2025-01-01'),
(57, 'Identificación de Audiencia', 'Análisis y definición del público objetivo para estrategias de contenido', '2025-01-02'),
(57, 'Creación de Estrategias', 'Desarrollo de estrategias de contenido efectivas y alineadas con los objetivos', '2025-01-03'),
(57, 'Planificación de Contenido', 'Elaboración de calendarios y planificación de contenido para diferentes canales', '2025-01-04'),
(57, 'Producción de Contenido', 'Creación de contenido de alta calidad y relevante para la audiencia', '2025-01-05'),
(57, 'Distribución de Contenido', 'Promoción y distribución de contenido a través de diferentes canales y plataformas', '2025-01-06'),
(57, 'Optimización de Contenido', 'Técnicas para optimizar el contenido para motores de búsqueda y audiencia', '2025-01-07'),
(57, 'Métricas y Análisis', 'Medición de resultados y análisis de rendimiento de estrategias de Marketing de Contenidos', '2025-01-08'),
(57, 'Evolución de Estrategias', 'Adaptación y mejora continua de estrategias de Marketing de Contenidos', '2025-01-09'),
(57, 'Buenas Prácticas y Tendencias', 'Identificación de mejores prácticas y tendencias actuales en Marketing de Contenidos', '2025-01-10');

-- Clases para la Unidad 8: Análisis de Datos
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(58, 'Introducción al Análisis de Datos', 'Conceptos básicos y aplicaciones del análisis de datos en el marketing digital', '2025-01-15'),
(58, 'Herramientas de Análisis', 'Uso de herramientas y software para la recopilación y análisis de datos', '2025-01-16'),
(58, 'Recopilación de Datos', 'Fuentes de datos y métodos para la recopilación de información relevante', '2025-01-17'),
(58, 'Limpieza y Preparación de Datos', 'Procesamiento y preparación de datos para su análisis y visualización', '2025-01-18'),
(58, 'Análisis Descriptivo', 'Descripción y resumen de datos para obtener insights y patrones', '2025-01-19'),
(58, 'Análisis Predictivo', 'Aplicación de técnicas para predecir tendencias y comportamientos futuros', '2025-01-20'),
(58, 'Análisis Prescriptivo', 'Utilización de datos para recomendar acciones y estrategias futuras', '2025-01-21'),
(58, 'Visualización de Datos', 'Representación visual de datos para facilitar su interpretación y comprensión', '2025-01-22'),
(58, 'Interpretación y Comunicación de Resultados', 'Análisis e interpretación de resultados para la toma de decisiones', '2025-01-23'),
(58, 'Aplicaciones Prácticas', 'Casos de estudio y aplicaciones prácticas del análisis de datos en marketing digital', '2025-01-24');

-- Clases para la Unidad 9: Marketing de Influencia
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(59, 'Qué es el Marketing de Influencia', 'Definición y concepto del marketing de influencia en el marketing digital', '2025-02-01'),
(59, 'Identificación de Influenciadores', 'Métodos para identificar y seleccionar influenciadores relevantes para la marca', '2025-02-02'),
(59, 'Estrategias de Colaboración', 'Desarrollo de estrategias de colaboración efectivas con influenciadores', '2025-02-03'),
(59, 'Negociación y Contratos', 'Proceso de negociación y elaboración de contratos con influenciadores', '2025-02-04'),
(59, 'Desarrollo de Contenido', 'Creación de contenido colaborativo para campañas de marketing de influencia', '2025-02-05'),
(59, 'Distribución y Promoción', 'Distribución y promoción de contenido generado por influenciadores', '2025-02-06'),
(59, 'Seguimiento y Medición', 'Seguimiento y medición de resultados de campañas de marketing de influencia', '2025-02-07'),
(59, 'Relaciones a Largo Plazo', 'Construcción de relaciones duraderas con influenciadores para colaboraciones continuas', '2025-02-08'),
(59, 'Ética y Transparencia', 'Consideraciones éticas y transparencia en el marketing de influencia', '2025-02-09'),
(59, 'Tendencias y Futuro del Marketing de Influencia', 'Identificación de tendencias y perspectivas futuras en el marketing de influencia', '2025-02-10');

-- Clases para la Unidad 10: Proyecto Final: Campaña de Marketing Digital
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(60, 'Fase de Planificación', 'Definición de objetivos, estrategias y planificación de la campaña final', '2025-02-15'),
(60, 'Desarrollo de Contenido', 'Creación de contenido y materiales para la campaña de marketing digital', '2025-02-16'),
(60, 'Implementación y Ejecución', 'Ejecución de la campaña en los diferentes canales y plataformas', '2025-02-17'),
(60, 'Seguimiento y Optimización', 'Seguimiento de resultados y optimización de la campaña en tiempo real', '2025-02-18'),
(60, 'Análisis y Reporte', 'Análisis de resultados y elaboración de informes sobre el desempeño de la campaña', '2025-02-19'),
(60, 'Presentación Final', 'Presentación de la campaña final ante el grupo y evaluación del proyecto', '2025-02-20'),
(60, 'Feedback y Evaluación', 'Recopilación de feedback y evaluación del proyecto final por parte de los instructores', '2025-02-21'),
(60, 'Entrega y Cierre', 'Entrega final de todos los materiales y cierre del proyecto de campaña', '2025-02-22'),
(60, 'Celebración y Reconocimiento', 'Celebración del trabajo realizado y reconocimiento a los participantes', '2025-02-23'),
(60, 'Perspectivas Futuras', 'Reflexión sobre aprendizajes y perspectivas futuras en el campo del marketing digital', '2025-02-24');

-- CLASES PARA FOTOGRAFIA DIGITAL
-- Clases para la Unidad 1: Fundamentos de Fotografía
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(61, 'Introducción a la Fotografía', 'Conceptos básicos de la fotografía y funcionamiento de la cámara', '2024-11-01'),
(61, 'Composición Fotográfica', 'Principios de composición y encuadre en la fotografía', '2024-11-02'),
(61, 'Exposición y Control de la Luz', 'Entendiendo la exposición y el control de la luz en la fotografía', '2024-11-03'),
(61, 'Enfoque y Profundidad de Campo', 'Técnicas para el enfoque y control de la profundidad de campo', '2024-11-04'),
(61, 'Balance de Blancos', 'Uso del balance de blancos para controlar la temperatura de color', '2024-11-05'),
(61, 'Formatos de Archivo', 'Tipos de formatos de archivo y su importancia en la fotografía digital', '2024-11-06'),
(61, 'Historia de la Fotografía', 'Breve recorrido por la historia y evolución de la fotografía', '2024-11-07'),
(61, 'Ética y Derechos de Autor', 'Consideraciones éticas y legales en la fotografía', '2024-11-08'),
(61, 'Práctica Fotográfica', 'Sesión práctica para aplicar los fundamentos aprendidos', '2024-11-09'),
(61, 'Revisión y Retroalimentación', 'Revisión de las imágenes capturadas y retroalimentación', '2024-11-10');

-- Clases para la Unidad 2: Técnica y Composición
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(62, 'Iluminación Natural', 'Uso de la luz natural y técnicas para aprovecharla en la fotografía', '2024-11-15'),
(62, 'Iluminación Artificial', 'Técnicas para el uso de iluminación artificial en la fotografía', '2024-11-16'),
(62, 'Composición Avanzada', 'Principios avanzados de composición para crear imágenes impactantes', '2024-11-17'),
(62, 'Perspectiva y Profundidad', 'Uso de la perspectiva y la profundidad para crear efectos visuales', '2024-11-18'),
(62, 'Fotografía de Viajes', 'Consejos y técnicas para capturar momentos mientras se viaja', '2024-11-19'),
(62, 'Fotografía Urbana', 'Exploración de la fotografía urbana y sus técnicas específicas', '2024-11-20'),
(62, 'Fotografía de Naturaleza Muerta', 'Técnicas para capturar imágenes de objetos inanimados', '2024-11-21'),
(62, 'Fotografía Creativa', 'Exploración de técnicas creativas y experimentales en la fotografía', '2024-11-22'),
(62, 'Práctica Dirigida', 'Sesión práctica enfocada en aplicar técnicas avanzadas de composición', '2024-11-23'),
(62, 'Revisión y Retroalimentación', 'Revisión de las imágenes capturadas y retroalimentación', '2024-11-24');

-- Clases para la Unidad 3: Fotografía de Retrato
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(63, 'Preparación del Sujeto', 'Consejos para preparar y dirigir a los sujetos en sesiones de retrato', '2024-12-01'),
(63, 'Iluminación para Retratos', 'Técnicas de iluminación específicas para fotografía de retrato', '2024-12-02'),
(63, 'Poses y Expresiones', 'Guía para dirigir poses y expresiones naturales en sesiones de retrato', '2024-12-03'),
(63, 'Retrato en Exterior', 'Técnicas y consideraciones para retratos al aire libre', '2024-12-04'),
(63, 'Retrato en Estudio', 'Técnicas y configuraciones para sesiones de retrato en estudio', '2024-12-05'),
(63, 'Retrato en Grupo', 'Consejos para fotografiar grupos y capturar interacciones', '2024-12-06'),
(63, 'Retrato Creativo', 'Exploración de técnicas creativas y estilos de retrato', '2024-12-07'),
(63, 'Práctica Dirigida de Retrato', 'Sesión práctica enfocada en la fotografía de retrato', '2024-12-08'),
(63, 'Revisión y Retroalimentación', 'Revisión de las imágenes de retrato capturadas y retroalimentación', '2024-12-09'),
(63, 'Sesión Fotográfica de Retrato', 'Sesión práctica de retrato con modelos en exteriores', '2024-12-10');

-- Clases para la Unidad 4: Fotografía de Paisaje
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(64, 'Equipo y Accesorios', 'Selección y uso adecuado de equipo y accesorios para fotografía de paisaje', '2024-12-15'),
(64, 'Composición en Paisajes', 'Principios de composición aplicados a la fotografía de paisajes', '2024-12-16'),
(64, 'Técnicas de Enfoque', 'Uso de diferentes técnicas de enfoque para paisajes nítidos', '2024-12-17'),
(64, 'Fotografía de Amaneceres y Atardeceres', 'Consejos y técnicas para capturar la magia de los amaneceres y atardeceres', '2024-12-18'),
(64, 'Fotografía de Montaña', 'Técnicas específicas para la fotografía en entornos de montaña', '2024-12-19'),
(64, 'Fotografía de Agua', 'Consejos para capturar el movimiento y la textura del agua en fotografías', '2024-12-20'),
(64, 'Fotografía Nocturna', 'Técnicas y equipo para la fotografía en condiciones de poca luz y durante la noche', '2024-12-21'),
(64, 'Fotografía de Larga Exposición', 'Técnicas avanzadas para capturar efectos de larga exposición en paisajes', '2024-12-22'),
(64, 'Práctica Dirigida de Paisajes', 'Sesión práctica enfocada en la fotografía de paisaje', '2024-12-23'),
(64, 'Revisión y Retroalimentación', 'Revisión de las imágenes de paisajes capturadas y retroalimentación', '2024-12-24');

-- Clases para la Unidad 5: Fotografía de Producto
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(65, 'Conceptos Básicos', 'Introducción a la fotografía de productos y su importancia en el comercio electrónico', '2025-01-01'),
(65, 'Iluminación para Productos', 'Técnicas de iluminación específicas para resaltar productos en fotografía', '2025-01-02'),
(65, 'Fondos y Escenarios', 'Selección de fondos y escenarios adecuados para fotografía de productos', '2025-01-03'),
(65, 'Composición y Enfoque', 'Principios de composición y enfoque aplicados a la fotografía de productos', '2025-01-04'),
(65, 'Fotografía de Productos Pequeños', 'Técnicas para fotografiar productos de tamaño pequeño y detalles', '2025-01-05'),
(65, 'Fotografía de Alimentos', 'Consejos y técnicas para capturar alimentos de manera atractiva en fotografía', '2025-01-06'),
(65, 'Fotografía de Moda', 'Técnicas de fotografía de moda aplicadas a la fotografía de productos', '2025-01-07'),
(65, 'Edición y Retoque', 'Uso de software de edición para mejorar y retocar fotografías de productos', '2025-01-08'),
(65, 'Práctica Dirigida de Productos', 'Sesión práctica enfocada en la fotografía de productos', '2025-01-09'),
(65, 'Revisión y Retroalimentación', 'Revisión de las imágenes de productos capturadas y retroalimentación', '2025-01-10');

-- Clases para la Unidad 6: Fotografía de Eventos
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(66, 'Planificación de Eventos', 'Preparación y planificación para la fotografía de eventos', '2025-01-15'),
(66, 'Técnicas de Captura', 'Técnicas y consejos para capturar momentos clave durante eventos', '2025-01-16'),
(66, 'Fotografía de Bodas', 'Técnicas específicas para la fotografía de bodas y ceremonias', '2025-01-17'),
(66, 'Fotografía de Conciertos', 'Consejos y técnicas para la fotografía de conciertos y espectáculos en vivo', '2025-01-18'),
(66, 'Fotografía de Deportes', 'Técnicas para capturar la acción y la emoción en eventos deportivos', '2025-01-19'),
(66, 'Fotografía de Festivales', 'Consejos para capturar la atmósfera y la diversión en festivales y eventos culturales', '2025-01-20'),
(66, 'Fotografía Corporativa', 'Técnicas y enfoques para la fotografía corporativa en eventos empresariales', '2025-01-21'),
(66, 'Práctica Dirigida de Eventos', 'Sesión práctica enfocada en la fotografía de eventos', '2025-01-22'),
(66, 'Revisión y Retroalimentación', 'Revisión de las imágenes de eventos capturadas y retroalimentación', '2025-01-23'),
(66, 'Sesión Fotográfica de Evento', 'Sesión práctica de fotografía de un evento en vivo', '2025-01-24');

-- Clases para la Unidad 7: Edición de Fotografía
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(67, 'Introducción a la Edición', 'Principios básicos de la edición de fotografía y su importancia', '2025-02-01'),
(67, 'Software de Edición', 'Conocimiento y manejo de software de edición de fotografía', '2025-02-02'),
(67, 'Herramientas de Edición', 'Uso de herramientas de edición para ajustes básicos y avanzados', '2025-02-03'),
(67, 'Ajustes de Color y Tono', 'Técnicas para ajustar el color, el tono y el contraste de una imagen', '2025-02-04'),
(67, 'Retoque y Mejora', 'Técnicas de retoque para mejorar la apariencia de las fotografías', '2025-02-05'),
(67, 'Corrección de Errores', 'Identificación y corrección de errores comunes en fotografía', '2025-02-06'),
(67, 'Filtros y Efectos', 'Uso creativo de filtros y efectos para agregar estilo a las fotografías', '2025-02-07'),
(67, 'Edición No Destructiva', 'Principios y ventajas de la edición no destructiva en fotografía', '2025-02-08'),
(67, 'Práctica de Edición', 'Sesiones prácticas para aplicar técnicas de edición en fotografías', '2025-02-09'),
(67, 'Revisión y Retroalimentación', 'Revisión de imágenes editadas y retroalimentación sobre el proceso', '2025-02-10');

-- Clases para la Unidad 8: Fotografía en Blanco y Negro
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(68, 'Estética en Blanco y Negro', 'Exploración de la estética y el impacto emocional de la fotografía en blanco y negro', '2025-02-15'),
(68, 'Conversión de Color a Blanco y Negro', 'Técnicas para convertir imágenes a blanco y negro de manera efectiva', '2025-02-16'),
(68, 'Ajustes de Tono y Contraste', 'Técnicas para ajustar el tono y el contraste en fotografías en blanco y negro', '2025-02-17'),
(68, 'Fotografía de Retrato en Blanco y Negro', 'Técnicas específicas para la fotografía de retrato en blanco y negro', '2025-02-18'),
(68, 'Fotografía de Paisaje en Blanco y Negro', 'Técnicas para capturar la atmósfera y la textura en paisajes en blanco y negro', '2025-02-19'),
(68, 'Fotografía Urbana en Blanco y Negro', 'Exploración de la fotografía urbana y arquitectónica en blanco y negro', '2025-02-20'),
(68, 'Fotografía Documental en Blanco y Negro', 'Técnicas y enfoques para la fotografía documental en blanco y negro', '2025-02-21'),
(68, 'Fotografía Artística en Blanco y Negro', 'Creatividad y expresión artística a través de la fotografía en blanco y negro', '2025-02-22'),
(68, 'Práctica Dirigida de Blanco y Negro', 'Sesiones prácticas enfocadas en la fotografía en blanco y negro', '2025-02-23'),
(68, 'Revisión y Retroalimentación', 'Revisión de imágenes en blanco y negro capturadas y retroalimentación', '2025-02-24');

-- Clases para la Unidad 9: Fotografía Macro
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(69, 'Introducción a la Fotografía Macro', 'Conceptos básicos y principios de la fotografía macro', '2025-03-01'),
(69, 'Equipo para Fotografía Macro', 'Selección y uso adecuado de equipo específico para fotografía macro', '2025-03-02'),
(69, 'Técnicas de Iluminación', 'Técnicas para iluminar sujetos en fotografía macro de manera efectiva', '2025-03-03'),
(69, 'Enfoque y Profundidad de Campo', 'Control del enfoque y la profundidad de campo en fotografía macro', '2025-03-04'),
(69, 'Composición en Fotografía Macro', 'Principios de composición aplicados a la fotografía macro', '2025-03-05'),
(69, 'Fotografía de Insectos y Naturaleza', 'Técnicas y consejos para fotografiar insectos y elementos de la naturaleza en macro', '2025-03-06'),
(69, 'Fotografía de Productos en Macro', 'Técnicas para fotografiar detalles y texturas de productos en macro', '2025-03-07'),
(69, 'Edición y Retoque en Macro', 'Uso de software de edición para mejorar y retocar fotografías macro', '2025-03-08'),
(69, 'Práctica Dirigida de Fotografía Macro', 'Sesiones prácticas enfocadas en la fotografía macro', '2025-03-09'),
(69, 'Revisión y Retroalimentación', 'Revisión de imágenes macro capturadas y retroalimentación', '2025-03-10');

-- Clases para la Unidad 10: Proyecto Final: Portafolio Fotográfico
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(70, 'Planificación del Proyecto', 'Definición de objetivos y planificación del portafolio fotográfico', '2025-03-15'),
(70, 'Selección de Contenido', 'Selección de fotografías para incluir en el portafolio final', '2025-03-16'),
(70, 'Diseño y Presentación', 'Diseño y presentación del portafolio fotográfico', '2025-03-17'),
(70, 'Revisión y Ajustes', 'Revisión del portafolio y ajustes finales', '2025-03-18'),
(70, 'Preparación para la Publicación', 'Preparación del portafolio para su publicación en línea o impresa', '2025-03-19'),
(70, 'Presentación Final', 'Presentación del portafolio final ante el grupo y evaluación del proyecto', '2025-03-20'),
(70, 'Entrega y Cierre', 'Entrega final del portafolio y cierre del proyecto', '2025-03-21'),
(70, 'Feedback y Evaluación', 'Recopilación de feedback y evaluación del proyecto final por parte de los instructores', '2025-03-22'),
(70, 'Celebración y Reconocimiento', 'Celebración del trabajo realizado y reconocimiento a los participantes', '2025-03-23'),
(70, 'Perspectivas Futuras', 'Reflexión sobre aprendizajes y perspectivas futuras en el campo de la fotografía', '2025-03-24');

-- CLASES PARA INGLES AVANZADO
-- Clases para la Unidad 1: Gramática Avanzada
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(71, 'Estructuras Gramaticales Complejas', 'Estudio de estructuras gramaticales avanzadas en inglés', '2024-12-01'),
(71, 'Uso Avanzado de Tiempos Verbales', 'Aplicación de tiempos verbales avanzados en diferentes contextos', '2024-12-02'),
(71, 'Verbos Modales y Su Uso', 'Estudio y práctica del uso de verbos modales en inglés', '2024-12-03'),
(71, 'Condicional y Subjuntivo', 'Uso avanzado del condicional y el modo subjuntivo en inglés', '2024-12-04'),
(71, 'Oraciones Compuestas', 'Construcción y análisis de oraciones compuestas en inglés', '2024-12-05'),
(71, 'Voz Pasiva y Activa', 'Diferencias entre la voz pasiva y activa y su aplicación en inglés', '2024-12-06'),
(71, 'Discurso Indirecto', 'Estudio de la transformación de discurso directo a indirecto en inglés', '2024-12-07'),
(71, 'Ortografía Avanzada', 'Reglas de ortografía y práctica para evitar errores comunes', '2024-12-08'),
(71, 'Gramática y Estilo', 'Aplicación de principios gramaticales en la redacción para mejorar el estilo', '2024-12-09'),
(71, 'Práctica y Aplicación', 'Aplicación práctica de las estructuras gramaticales estudiadas', '2024-12-10');

-- Clases para la Unidad 2: Vocabulario Avanzado
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(72, 'Términos Especializados', 'Estudio y aplicación de vocabulario especializado en diversas áreas', '2024-12-15'),
(72, 'Sinónimos y Antónimos', 'Ampliación del vocabulario mediante el uso de sinónimos y antónimos', '2024-12-16'),
(72, 'Jerga y Expresiones Coloniales', 'Conocimiento y uso de jerga y expresiones propias de la lengua inglesa', '2024-12-17'),
(72, 'Modismos y Frases Hechas', 'Estudio de modismos y frases hechas en inglés y su significado', '2024-12-18'),
(72, 'Tecnología y Términos Científicos', 'Vocabulario relacionado con tecnología y ciencia aplicado en contextos específicos', '2024-12-19'),
(72, 'Expresiones Idiomáticas', 'Uso y comprensión de expresiones idiomáticas comunes en inglés', '2024-12-20'),
(72, 'Vocabulario Literario', 'Estudio de vocabulario literario y términos relacionados con la literatura en inglés', '2024-12-21'),
(72, 'Vocabulario de Negocios', 'Términos y vocabulario utilizado en contextos empresariales y comerciales', '2024-12-22'),
(72, 'Juegos de Vocabulario', 'Actividades lúdicas para practicar y reforzar el vocabulario aprendido', '2024-12-23'),
(72, 'Práctica de Conversación', 'Práctica de vocabulario en situaciones de conversación simuladas', '2024-12-24');

-- Clases para la Unidad 3: Comprensión Auditiva
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(73, 'Comprensión de Conversaciones', 'Prácticas de comprensión auditiva a través de diálogos y conversaciones', '2025-01-01'),
(73, 'Audición de Noticias y Reportajes', 'Escucha y comprensión de noticias y reportajes en inglés', '2025-01-02'),
(73, 'Audición de Entrevistas', 'Comprensión de entrevistas en inglés y análisis de contenido', '2025-01-03'),
(73, 'Comprensión de Conferencias', 'Escucha y comprensión de conferencias y charlas en inglés', '2025-01-04'),
(73, 'Comprensión de Podcasts', 'Escucha y comprensión de podcasts en inglés sobre diversos temas', '2025-01-05'),
(73, 'Audición de Presentaciones', 'Comprensión de presentaciones orales en inglés', '2025-01-06'),
(73, 'Ejercicios de Escucha Activa', 'Prácticas de escucha activa para mejorar la comprensión', '2025-01-07'),
(73, 'Comprensión de Acentos Regionales', 'Escucha y comprensión de diferentes acentos regionales en inglés', '2025-01-08'),
(73, 'Pruebas de Comprensión', 'Realización de pruebas y ejercicios para evaluar la comprensión auditiva', '2025-01-09'),
(73, 'Retroalimentación y Corrección', 'Análisis de resultados y corrección de errores en la comprensión auditiva', '2025-01-10');

-- Clases para la Unidad 4: Expresión Oral
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(74, 'Pronunciación y Entonación', 'Prácticas de pronunciación y entonación para mejorar la expresión oral', '2025-01-15'),
(74, 'Fluidez y Naturalidad', 'Desarrollo de fluidez y naturalidad en la expresión oral en inglés', '2025-01-16'),
(74, 'Expresión de Opiniones y Ideas', 'Desarrollo de habilidades para expresar opiniones e ideas de manera clara y coherente', '2025-01-17'),
(74, 'Narración y Descripción', 'Prácticas de narración y descripción de eventos, experiencias y situaciones', '2025-01-18'),
(74, 'Presentaciones Orales', 'Preparación y realización de presentaciones orales sobre temas específicos', '2025-01-19'),
(74, 'Participación en Debates', 'Participación en debates y discusiones sobre temas actuales', '2025-01-20'),
(74, 'Entrevistas Simuladas', 'Realización de entrevistas simuladas para practicar la expresión oral', '2025-01-21'),
(74, 'Improvisación y Creatividad', 'Ejercicios de improvisación para desarrollar la creatividad en la expresión oral', '2025-01-22'),
(74, 'Práctica de Conversación', 'Prácticas de conversación dirigida para mejorar la expresión oral', '2025-01-23'),
(74, 'Feedback y Evaluación', 'Feedback y evaluación de la expresión oral para identificar áreas de mejora', '2025-01-24');

-- Clases para la Unidad 5: Expresión Escrita
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(75, 'Estructura de Escritos Académicos', 'Construcción de ensayos, informes y otros escritos académicos', '2025-02-01'),
(75, 'Desarrollo de Argumentos', 'Elaboración y desarrollo de argumentos sólidos y coherentes en la escritura', '2025-02-02'),
(75, 'Redacción Creativa', 'Exploración de técnicas de redacción creativa para diversos géneros de escritura', '2025-02-03'),
(75, 'Escritura Descriptiva', 'Prácticas de escritura descriptiva para crear imágenes vívidas en el lector', '2025-02-04'),
(75, 'Escritura Persuasiva', 'Desarrollo de habilidades para escribir textos persuasivos y convincentes', '2025-02-05'),
(75, 'Corrección y Revisión', 'Técnicas de corrección y revisión para mejorar la calidad de la escritura', '2025-02-06'),
(75, 'Escritura de Cartas y Emails', 'Normas y convenciones para escribir cartas formales, informales y correos electrónicos', '2025-02-07'),
(75, 'Escritura de Resúmenes', 'Técnicas de síntesis y redacción de resúmenes efectivos', '2025-02-08'),
(75, 'Escritura Creativa en Inglés', 'Prácticas de escritura creativa en inglés explorando diferentes géneros literarios', '2025-02-09'),
(75, 'Práctica de Escritura', 'Ejercicios y actividades para practicar la escritura en diferentes contextos', '2025-02-10');

-- Clases para la Unidad 6: Lectura Avanzada
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(76, 'Comprensión de Textos Literarios', 'Lectura y análisis de textos literarios clásicos y contemporáneos', '2025-02-15'),
(76, 'Lectura de Artículos Académicos', 'Comprensión y análisis de artículos académicos en diversas áreas de estudio', '2025-02-16'),
(76, 'Lectura de Textos Periodísticos', 'Comprensión y análisis de textos periodísticos y de actualidad', '2025-02-17'),
(76, 'Lectura de Ficción y No Ficción', 'Exploración de textos de ficción y no ficción para desarrollar la comprensión lectora', '2025-02-18'),
(76, 'Lectura de Obras Teatrales', 'Lectura y análisis de obras teatrales en inglés para comprender el género dramático', '2025-02-19'),
(76, 'Lectura de Poesía', 'Comprensión y análisis de poemas en inglés para apreciar la belleza del lenguaje', '2025-02-20'),
(76, 'Lectura de Textos Históricos', 'Comprensión y análisis de textos históricos para explorar diferentes períodos y eventos', '2025-02-21'),
(76, 'Lectura de Textos Científicos', 'Comprensión y análisis de textos científicos para familiarizarse con el lenguaje técnico', '2025-02-22'),
(76, 'Lectura de Textos Multiculturales', 'Exploración de textos que reflejan diversas culturas y perspectivas', '2025-02-23'),
(76, 'Pruebas de Comprensión Lectora', 'Realización de pruebas y ejercicios para evaluar la comprensión lectora', '2025-02-24');

-- Clases para la Unidad 7: Conversación Avanzada
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(77, 'Temas de Debate', 'Discusión y debate de temas actuales y controversiales en inglés', '2025-03-01'),
(77, 'Prácticas de Conversación', 'Prácticas guiadas para mejorar la fluidez y la espontaneidad en la conversación', '2025-03-02'),
(77, 'Entrevistas en Inglés', 'Preparación y realización de entrevistas en inglés sobre diversos temas', '2025-03-03'),
(77, 'Discusiones Grupales', 'Participación en discusiones grupales para intercambiar opiniones y puntos de vista', '2025-03-04'),
(77, 'Simulaciones de Situaciones', 'Simulación de situaciones reales para practicar la conversación en contextos específicos', '2025-03-05'),
(77, 'Conversaciones Informales', 'Prácticas de conversación informal para mejorar la comunicación cotidiana', '2025-03-06'),
(77, 'Debates Dirigidos', 'Participación en debates dirigidos para desarrollar habilidades argumentativas', '2025-03-07'),
(77, 'Feedback y Corrección', 'Feedback y corrección de errores en la conversación para mejorar la comunicación', '2025-03-08'),
(77, 'Práctica de Expresión Oral', 'Prácticas enfocadas en mejorar la pronunciación y la entonación en la conversación', '2025-03-09'),
(77, 'Evaluación de Habilidades', 'Evaluación de habilidades comunicativas y establecimiento de metas de mejora', '2025-03-10');

-- Clases para la Unidad 8: Inglés para Negocios
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(78, 'Vocabulario de Negocios', 'Estudio y aplicación de vocabulario específico para entornos empresariales', '2025-03-15'),
(78, 'Presentaciones y Reuniones', 'Preparación y realización de presentaciones y reuniones en inglés', '2025-03-16'),
(78, 'Negociación y Diplomacia', 'Desarrollo de habilidades para negociar y manejar situaciones diplomáticas en inglés', '2025-03-17'),
(78, 'Redacción de Documentos', 'Técnicas y convenciones para la redacción de documentos empresariales en inglés', '2025-03-18'),
(78, 'Correspondencia Comercial', 'Normas y convenciones para la escritura de correos y cartas comerciales en inglés', '2025-03-19'),
(78, 'Cultura Empresarial', 'Exploración de la cultura empresarial anglosajona y su influencia en los negocios', '2025-03-20'),
(78, 'Ética Empresarial', 'Consideraciones éticas y responsabilidad social en el contexto empresarial', '2025-03-21'),
(78, 'Negocios Internacionales', 'Estudio de términos y prácticas relacionadas con los negocios internacionales en inglés', '2025-03-22'),
(78, 'Casos de Estudio', 'Análisis de casos de estudio reales para aplicar los conocimientos en situaciones concretas', '2025-03-23'),
(78, 'Simulaciones Empresariales', 'Participación en simulaciones empresariales para poner en práctica habilidades de negocios', '2025-03-24');

-- Clases para la Unidad 9: Preparación para Exámenes
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(79, 'Formato del Examen', 'Conocimiento del formato, estructura y secciones del examen de certificación', '2025-04-01'),
(79, 'Estrategias de Examen', 'Desarrollo de estrategias para enfrentar cada sección del examen con éxito', '2025-04-02'),
(79, 'Pruebas de Práctica', 'Realización de pruebas de práctica para familiarizarse con el estilo y contenido del examen', '2025-04-03'),
(79, 'Repaso de Contenidos', 'Repaso y consolidación de los contenidos clave evaluados en el examen', '2025-04-04'),
(79, 'Técnicas de Gestión del Tiempo', 'Consejos y técnicas para administrar el tiempo de forma efectiva durante el examen', '2025-04-05'),
(79, 'Resolución de Problemas', 'Ejercicios y prácticas para desarrollar habilidades de resolución de problemas en el examen', '2025-04-06'),
(79, 'Feedback y Evaluación', 'Feedback y evaluación de desempeño en las pruebas de práctica y simulacros de examen', '2025-04-07'),
(79, 'Preparación Mental', 'Preparación mental y manejo del estrés antes y durante el examen de certificación', '2025-04-08'),
(79, 'Simulacros de Examen', 'Realización de simulacros de examen para simular condiciones reales de evaluación', '2025-04-09'),
(79, 'Estrategias de Aprendizaje', 'Desarrollo de estrategias de aprendizaje efectivas para maximizar el rendimiento en el examen', '2025-04-10');

-- Clases para la Unidad 10: Proyecto Final: Presentación en Inglés
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(80, 'Definición de Tema', 'Selección y definición del tema para la presentación final en inglés', '2025-04-15'),
(80, 'Investigación y Recopilación de Información', 'Búsqueda, recopilación y análisis de información relevante para la presentación', '2025-04-16'),
(80, 'Estructura y Contenido', 'Elaboración de la estructura y contenido de la presentación final en inglés', '2025-04-17'),
(80, 'Diseño de Diapositivas', 'Creación y diseño de diapositivas para acompañar la presentación en inglés', '2025-04-18'),
(80, 'Práctica de la Presentación', 'Prácticas de la presentación en inglés para mejorar el flujo y la expresión', '2025-04-19'),
(80, 'Feedback y Mejoras', 'Feedback y evaluación de la presentación para identificar áreas de mejora', '2025-04-20'),
(80, 'Preparación Final', 'Preparación final de la presentación en inglés, revisión y ajustes finales', '2025-04-21'),
(80, 'Presentación ante Audiencia', 'Presentación final ante una audiencia, seguida de sesión de preguntas y respuestas', '2025-04-22'),
(80, 'Evaluación del Proyecto', 'Evaluación del proyecto final y retroalimentación sobre el desempeño', '2025-04-23'),
(80, 'Cierre del Curso', 'Cierre del curso y entrega de certificados a los participantes', '2025-04-24');

-- CLASES PARA FINANZAS PERSONALES
-- Clases para la Unidad 9: Planificación Financiera
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(81, 'Conceptos Básicos de Planificación Financiera', 'Introducción a los principios y conceptos básicos de la planificación financiera', '2025-01-01'),
(81, 'Establecimiento de Metas Financieras', 'Cómo establecer metas financieras realistas y alcanzables', '2025-01-02'),
(81, 'Análisis de Situación Financiera', 'Evaluación de la situación financiera actual y análisis de ingresos y gastos', '2025-01-03'),
(81, 'Desarrollo de un Presupuesto Personal', 'Pasos para elaborar un presupuesto personal efectivo', '2025-01-04'),
(81, 'Planificación Financiera a Corto Plazo', 'Cómo planificar las finanzas para el corto plazo y enfrentar emergencias', '2025-01-05'),
(81, 'Planificación Financiera a Largo Plazo', 'Estrategias para la planificación financiera a largo plazo y la jubilación', '2025-01-06'),
(81, 'Planificación Financiera Familiar', 'Cómo incluir a la familia en la planificación financiera y tomar decisiones conjuntas', '2025-01-07'),
(81, 'Automatización de Finanzas Personales', 'Uso de herramientas y tecnología para automatizar la gestión financiera personal', '2025-01-08'),
(81, 'Seguimiento y Revisión del Plan Financiero', 'Importancia de monitorear y revisar el plan financiero de forma periódica', '2025-01-09'),
(81, 'Hábitos Financieros Saludables', 'Desarrollo de hábitos financieros saludables para mantener la estabilidad económica', '2025-01-10');

-- Clases para la Unidad 9: Presupuesto y Ahorro
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(82, 'Elaboración de Presupuestos Personales', 'Pasos para crear un presupuesto personal efectivo', '2025-01-15'),
(82, 'Técnicas de Ahorro Efectivo', 'Métodos y estrategias para ahorrar de manera efectiva', '2025-01-16'),
(82, 'Planificación de Gastos y Prioridades', 'Cómo planificar los gastos y establecer prioridades financieras', '2025-01-17'),
(82, 'Herramientas Digitales de Presupuesto', 'Uso de herramientas digitales para la elaboración y seguimiento del presupuesto', '2025-01-18'),
(82, 'Control de Gastos: Método del Sobrante', 'Método del sobrante para controlar los gastos y maximizar el ahorro', '2025-01-19'),
(82, 'Planificación para Gastos Inesperados', 'Cómo prepararse financieramente para gastos inesperados', '2025-01-20'),
(82, 'Estrategias para Reducir Gastos', 'Técnicas y estrategias para reducir gastos y optimizar el presupuesto', '2025-01-21'),
(82, 'Planificación de Ahorro a Largo Plazo', 'Planificación financiera para el ahorro a largo plazo y metas futuras', '2025-01-22'),
(82, 'Automatización de Ahorros', 'Cómo automatizar los procesos de ahorro para mantener la disciplina financiera', '2025-01-23'),
(82, 'Revisión y Ajuste del Presupuesto', 'Importancia de revisar y ajustar el presupuesto regularmente para alcanzar objetivos', '2025-01-24');

-- Clases para la Unidad 9: Inversiones y Mercados Financieros
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(83, 'Introducción a las Inversiones', 'Conceptos básicos sobre inversiones y su importancia en la planificación financiera', '2025-02-01'),
(83, 'Tipos de Inversiones', 'Análisis de los diferentes tipos de inversiones disponibles', '2025-02-02'),
(83, 'Riesgo y Rentabilidad', 'Relación entre riesgo y rentabilidad en las inversiones', '2025-02-03'),
(83, 'Fondos de Inversión: Conceptos Básicos', 'Definición y características básicas de los fondos de inversión', '2025-02-04'),
(83, 'Cómo Elegir un Fondo de Inversión', 'Factores a considerar al elegir un fondo de inversión', '2025-02-05'),
(83, 'Estrategias de Gestión de Carteras', 'Diversificación y otras estrategias para gestionar carteras de inversión', '2025-02-06'),
(83, 'Mercados Financieros: Funcionamiento', 'Funcionamiento de los mercados financieros y su influencia en las inversiones', '2025-02-07'),
(83, 'Análisis Fundamental', 'Conceptos básicos y técnicas de análisis fundamental en inversiones', '2025-02-08'),
(83, 'Análisis Técnico', 'Conceptos básicos y técnicas de análisis técnico en inversiones', '2025-02-09'),
(83, 'Planificación de Inversiones a Largo Plazo', 'Cómo planificar las inversiones a largo plazo y gestionar riesgos', '2025-02-10');

-- Clases para la Unidad 9: Fondos de Inversión
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(84, 'Tipos de Fondos de Inversión', 'Descripción de los distintos tipos de fondos de inversión y sus características', '2025-02-15'),
(84, 'Selección de Fondos de Inversión', 'Factores a considerar al seleccionar fondos de inversión para una cartera', '2025-02-16'),
(84, 'Estrategias de Inversión con Fondos', 'Diversificación y estrategias de inversión utilizando fondos', '2025-02-17'),
(84, 'Riesgos y Beneficios de los Fondos de Inversión', 'Análisis de los riesgos y beneficios asociados con los fondos de inversión', '2025-02-18'),
(84, 'Performance y Evaluación de Fondos', 'Cómo evaluar el rendimiento y la gestión de fondos de inversión', '2025-02-19'),
(84, 'Impuestos y Costos Asociados a los Fondos', 'Consideraciones fiscales y costos asociados a la inversión en fondos', '2025-02-20'),
(84, 'Fondos de Inversión Sostenible', 'Conceptos básicos y criterios de selección de fondos de inversión sostenible', '2025-02-21'),
(84, 'Planificación de Inversiones con Fondos', 'Cómo incorporar fondos de inversión en la planificación financiera personal', '2025-02-22'),
(84, 'Rebalanceo de Cartera con Fondos', 'Importancia del rebalanceo periódico de la cartera de inversión con fondos', '2025-02-23'),
(84, 'Alternativas de Inversión a los Fondos', 'Otras opciones de inversión disponibles además de los fondos', '2025-02-24');

-- Clases para la Unidad 9: Educación Financiera
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(85, 'Importancia de la Educación Financiera', 'Razones por las que es importante adquirir conocimientos financieros', '2025-03-01'),
(85, 'Conceptos Básicos de Finanzas Personales', 'Principios fundamentales de las finanzas personales y conceptos clave', '2025-03-02'),
(85, 'Desarrollo de Habilidades Financieras', 'Cómo desarrollar habilidades prácticas para la gestión financiera', '2025-03-03'),
(85, 'Fuentes de Educación Financiera', 'Diferentes fuentes y recursos para aprender sobre educación financiera', '2025-03-04'),
(85, 'Aplicación Práctica de Conocimientos Financieros', 'Cómo aplicar los conocimientos financieros en la toma de decisiones', '2025-03-05'),
(85, 'Educación Financiera en la Familia', 'Importancia de la educación financiera desde temprana edad en la familia', '2025-03-06'),
(85, 'Educación Financiera y Emprendimiento', 'Relación entre la educación financiera y el emprendimiento', '2025-03-07'),
(85, 'Educación Financiera en el Ámbito Laboral', 'Beneficios de la educación financiera en el entorno laboral y profesional', '2025-03-08'),
(85, 'Educación Financiera y Bienestar Personal', 'Impacto de la educación financiera en el bienestar y la calidad de vida', '2025-03-09'),
(85, 'Continuidad en la Educación Financiera', 'Importancia de continuar aprendiendo y actualizando conocimientos financieros', '2025-03-10');

-- Clases para la Unidad 9: Gestión del Crédito
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(86, 'Importancia de la Gestión del Crédito', 'Razones por las que es importante gestionar responsablemente el crédito', '2025-03-15'),
(86, 'Conceptos Básicos de Crédito', 'Principios fundamentales del crédito y tipos de deudas', '2025-03-16'),
(86, 'Historial Crediticio y Puntuación Crediticia', 'Cómo funcionan y cómo afectan el historial y la puntuación crediticia', '2025-03-17'),
(86, 'Gestión Responsable de Tarjetas de Crédito', 'Uso adecuado de las tarjetas de crédito y prevención de deudas', '2025-03-18'),
(86, 'Préstamos Personales y Financiamiento', 'Consideraciones al solicitar préstamos personales y otras formas de financiamiento', '2025-03-19'),
(86, 'Estrategias para Reducir Deudas', 'Técnicas y estrategias para reducir y eliminar deudas de manera efectiva', '2025-03-20'),
(86, 'Refinanciación y Consolidación de Deudas', 'Opciones de refinanciación y consolidación de deudas para mejorar la situación financiera', '2025-03-21'),
(86, 'Impacto de la Gestión del Crédito en la Vida Financiera', 'Cómo una gestión responsable del crédito afecta la vida financiera a largo plazo', '2025-03-22'),
(86, 'Prevención del Fraude y Protección de Identidad', 'Medidas para prevenir el fraude y proteger la identidad en transacciones financieras', '2025-03-23'),
(86, 'Desarrollo de Hábitos Financieros Saludables', 'Importancia de desarrollar hábitos financieros saludables para mantener un buen historial crediticio', '2025-03-24');

-- Clases para la Unidad 9: Planificación de Jubilación
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(87, 'Importancia de la Planificación de Jubilación', 'Razones por las que es importante planificar la jubilación desde temprano', '2025-04-01'),
(87, 'Cálculo de la Jubilación: Ingresos y Gastos', 'Cómo calcular los ingresos y gastos esperados durante la jubilación', '2025-04-02'),
(87, 'Opciones de Ahorro para la Jubilación', 'Diferentes opciones de ahorro e inversión para la jubilación', '2025-04-03'),
(87, 'Planes de Pensiones y Seguridad Social', 'Análisis de planes de pensiones y beneficios de seguridad social', '2025-04-04'),
(87, 'Estrategias para Aumentar el Ahorro para la Jubilación', 'Técnicas y estrategias para aumentar el ahorro para la jubilación', '2025-04-05'),
(87, 'Inversiones a Largo Plazo para la Jubilación', 'Cómo seleccionar inversiones a largo plazo para financiar la jubilación', '2025-04-06'),
(87, 'Riesgos y Mitigaciones en la Planificación de Jubilación', 'Identificación de riesgos y formas de mitigarlos en la planificación de jubilación', '2025-04-07'),
(87, 'Planificación de Ingresos Pasivos', 'Cómo generar ingresos pasivos como parte de la planificación de jubilación', '2025-04-08'),
(87, 'Planificación de Gastos en la Jubilación', 'Cómo estimar y planificar los gastos durante la jubilación', '2025-04-09'),
(87, 'Revisión y Ajuste del Plan de Jubilación', 'Importancia de revisar y ajustar el plan de jubilación a lo largo del tiempo', '2025-04-10');

-- Clases para la Unidad 9: Seguros Personales
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(88, 'Conceptos Básicos de Seguros Personales', 'Principios fundamentales de los seguros personales y tipos de coberturas', '2025-04-15'),
(88, 'Seguros de Vida y Salud', 'Análisis de seguros de vida y salud y su importancia en la protección financiera', '2025-04-16'),
(88, 'Seguros de Hogar y Propiedad', 'Coberturas y consideraciones al contratar seguros de hogar y propiedad', '2025-04-17'),
(88, 'Seguros de Automóvil y Transporte', 'Aspectos importantes a considerar al elegir seguros de automóvil y transporte', '2025-04-18'),
(88, 'Seguros de Responsabilidad Civil', 'Importancia de los seguros de responsabilidad civil en la protección financiera', '2025-04-19'),
(88, 'Seguros de Viaje y Accidentes', 'Coberturas y beneficios de los seguros de viaje y accidentes', '2025-04-20'),
(88, 'Seguros de Educación y Ahorro', 'Opciones de seguros de educación y ahorro para metas financieras específicas', '2025-04-21'),
(88, 'Seguros de Ingresos y Retiro', 'Coberturas y beneficios de los seguros de ingresos y retiro para la jubilación', '2025-04-22'),
(88, 'Selección y Comparación de Seguros', 'Cómo seleccionar y comparar distintas opciones de seguros personales', '2025-04-23'),
(88, 'Evaluación y Revisión de Pólizas', 'Importancia de evaluar y revisar periódicamente las pólizas de seguros personales', '2025-04-24');

-- Clases para la Unidad 9: Impuestos Personales
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(89, 'Conceptos Básicos de Impuestos Personales', 'Introducción a los principios básicos de los impuestos personales', '2025-05-01'),
(89, 'Tipos de Impuestos Personales', 'Descripción de los diferentes tipos de impuestos que afectan a las personas', '2025-05-02'),
(89, 'Cumplimiento Tributario', 'Obligaciones y responsabilidades fiscales de los contribuyentes', '2025-05-03'),
(89, 'Deducciones y Créditos Fiscales', 'Cómo aprovechar deducciones y créditos fiscales para reducir la carga impositiva', '2025-05-04'),
(89, 'Declaración de Impuestos', 'Proceso de declaración de impuestos y presentación de formularios', '2025-05-05'),
(89, 'Planificación Fiscal', 'Estrategias para la planificación fiscal y minimización de impuestos', '2025-05-06'),
(89, 'Inversiones y Impuestos', 'Impacto de las inversiones en los impuestos personales y estrategias fiscales', '2025-05-07'),
(89, 'Propiedad y Bienes Raíces', 'Consideraciones fiscales al poseer y transferir propiedad y bienes raíces', '2025-05-08'),
(89, 'Impuestos y Retiro', 'Aspectos fiscales a considerar durante la jubilación y distribución de fondos de retiro', '2025-05-09'),
(89, 'Cumplimiento Tributario Ético', 'Importancia de cumplir con las obligaciones fiscales de manera ética y responsable', '2025-05-10');

-- Clases para la Unidad 9: Proyecto Final: Plan Financiero Personal
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(90, 'Elaboración del Plan Financiero Personal', 'Pasos para desarrollar un plan financiero personal completo y realista', '2025-05-15'),
(90, 'Análisis de Situación Financiera', 'Evaluación detallada de la situación financiera actual y proyecciones futuras', '2025-05-16'),
(90, 'Establecimiento de Metas Financieras', 'Definición de metas financieras claras y alcanzables a corto, mediano y largo plazo', '2025-05-17'),
(90, 'Desarrollo de Estrategias y Planes de Acción', 'Diseño de estrategias y planes de acción para alcanzar las metas financieras establecidas', '2025-05-18'),
(90, 'Asignación de Recursos y Presupuesto', 'Distribución adecuada de recursos financieros y elaboración de un presupuesto personal', '2025-05-19'),
(90, 'Selección de Productos Financieros', 'Análisis y selección de productos financieros adecuados para cada objetivo', '2025-05-20'),
(90, 'Evaluación de Riesgos y Seguros', 'Identificación y evaluación de riesgos financieros y selección de seguros apropiados', '2025-05-21'),
(90, 'Planificación de Jubilación y Previsión Social', 'Incorporación de estrategias de planificación de jubilación y seguridad social en el plan financiero', '2025-05-22'),
(90, 'Revisión y Ajuste del Plan Financiero', 'Importancia de revisar y ajustar periódicamente el plan financiero personal', '2025-05-23'),
(90, 'Presentación del Proyecto Final', 'Preparación y presentación del plan financiero personal ante el grupo y el instructor', '2025-05-24');

-- CLASES PARA COCINA INTERNACIONAL
-- Clases para la Unidad 10: Curso de Cocina Internacional - Introducción a la Cocina Internacional
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(91, 'Historia de la Cocina Internacional', 'Exploración de la historia y evolución de la cocina de diferentes países', '2025-02-01'),
(91, 'Conceptos Básicos de la Cocina Internacional', 'Principios fundamentales y técnicas comunes en la cocina de distintas culturas', '2025-02-02'),
(91, 'Ingredientes Globales', 'Estudio de ingredientes comunes y globales utilizados en la cocina internacional', '2025-02-03'),
(91, 'Técnicas Culinarias Universales', 'Exploración de técnicas culinarias que se aplican en diversas tradiciones gastronómicas', '2025-02-04'),
(91, 'Influencias Culturales en la Gastronomía', 'Análisis de cómo las influencias culturales moldean la gastronomía de cada país', '2025-02-05'),
(91, 'Desarrollo de Paladar Global', 'Cómo desarrollar un paladar que aprecie y comprenda los sabores de todo el mundo', '2025-02-06'),
(91, 'Exploración Gastronómica', 'Experiencia práctica explorando platos representativos de diferentes culturas', '2025-02-07'),
(91, 'Ética Culinaria', 'Consideraciones éticas al cocinar platos de diversas culturas y respeto por las tradiciones', '2025-02-08'),
(91, 'Cocina Internacional en la Actualidad', 'Tendencias y cambios en la cocina internacional en el mundo moderno', '2025-02-09'),
(91, 'Impacto Global de la Gastronomía', 'Cómo la gastronomía internacional impacta en la cultura, economía y sociedad a nivel global', '2025-02-10');

-- Clases para la Unidad 10: Curso de Cocina Internacional - Cocina Italiana
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(92, 'Introducción a la Cocina Italiana', 'Breve historia y características principales de la cocina italiana', '2025-02-15'),
(92, 'Pasta: La Esencia de la Cocina Italiana', 'Elaboración de distintos tipos de pasta y salsas clásicas italianas', '2025-02-16'),
(92, 'Pizza Napoletana y Focaccia', 'Preparación de auténtica pizza napolitana y focaccia italiana', '2025-02-17'),
(92, 'Carnes y Pescados Italianos', 'Técnicas de preparación de carnes y pescados típicos de la cocina italiana', '2025-02-18'),
(92, 'Antipasti y Aperitivos', 'Elaboración de antipasti y aperitivos tradicionales italianos', '2025-02-19'),
(92, 'Quesos y Postres Italianos', 'Degustación y preparación de quesos y postres emblemáticos de Italia', '2025-02-20'),
(92, 'Vinos Italianos', 'Maridaje de vinos italianos con platos típicos de la cocina de Italia', '2025-02-21'),
(92, 'Cocina Regional Italiana', 'Exploración de las diferencias regionales en la cocina italiana y sus platos característicos', '2025-02-22'),
(92, 'Innovación en la Cocina Italiana', 'Tendencias actuales y fusiones en la cocina italiana contemporánea', '2025-02-23'),
(92, 'Cena Italiana Tradicional', 'Preparación y presentación de una cena completa con platos representativos de Italia', '2025-02-24');

-- Clases para la Unidad 10: Curso de Cocina Internacional - Cocina Mexicana
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(93, 'Historia y Cultura Gastronómica de México', 'Exploración de la rica historia y diversidad cultural de la cocina mexicana', '2025-03-01'),
(93, 'Ingredientes y Especias Mexicanas', 'Estudio de los ingredientes y especias clave en la cocina mexicana', '2025-03-02'),
(93, 'Platos Tradicionales de México', 'Preparación de platos emblemáticos de la cocina mexicana: tacos, mole, etc.', '2025-03-03'),
(93, 'Salsas y Guarniciones Mexicanas', 'Elaboración de salsas y guarniciones tradicionales para acompañar platillos mexicanos', '2025-03-04'),
(93, 'Cocina Regional Mexicana', 'Exploración de las diferencias regionales en la gastronomía mexicana y sus platos típicos', '2025-03-05'),
(93, 'Técnicas de Cocina Mexicana', 'Dominio de las técnicas culinarias específicas utilizadas en la cocina mexicana', '2025-03-06'),
(93, 'Bebidas Tradicionales Mexicanas', 'Preparación y degustación de bebidas emblemáticas de México: tequila, mezcal, etc.', '2025-03-07'),
(93, 'Postres Mexicanos', 'Elaboración de postres tradicionales mexicanos como flan, churros, etc.', '2025-03-08'),
(93, 'Cocina Mexicana Contemporánea', 'Innovaciones y fusiones en la cocina mexicana contemporánea', '2025-03-09'),
(93, 'Cena Mexicana Festiva', 'Preparación y presentación de una cena festiva con platillos mexicanos tradicionales', '2025-03-10');

-- Clases para la Unidad 10: Curso de Cocina Internacional - Cocina Asiática
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(94, 'Diversidad y Tradiciones Culinarias de Asia', 'Exploración de la diversidad cultural y tradiciones culinarias de Asia', '2025-03-15'),
(94, 'Ingredientes Asiáticos', 'Estudio de los ingredientes y condimentos fundamentales en la cocina asiática', '2025-03-16'),
(94, 'Wok: Arte de la Cocción Asiática', 'Dominio de las técnicas de cocción en wok para platos asiáticos', '2025-03-17'),
(94, 'Sushi y Sashimi', 'Preparación de sushi y sashimi con técnicas auténticas japonesas', '2025-03-18'),
(94, 'Curry y Especias de la India', 'Elaboración de curry y uso de especias en la cocina india', '2025-03-19'),
(94, 'Platos Tailandeses y Vietnamitas', 'Preparación de platos típicos tailandeses y vietnamitas', '2025-03-20'),
(94, 'Dim Sum y Dumplings', 'Elaboración de dim sum y dumplings siguiendo técnicas tradicionales chinas', '2025-03-21'),
(94, 'Técnica del Tempura Japonés', 'Preparación de tempura japonés con ingredientes frescos y técnicas precisas', '2025-03-22'),
(94, 'Maridaje de Té y Sake', 'Conocimientos sobre maridaje de té y sake con platos asiáticos', '2025-03-23'),
(94, 'Cena Asiática Multicultural', 'Preparación y presentación de una cena multicultural con platos asiáticos representativos', '2025-03-24');

-- Clases para la Unidad 10: Curso de Cocina Internacional - Cocina Francesa
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(95, 'Historia de la Alta Cocina Francesa', 'Exploración de la historia y evolución de la alta cocina francesa', '2025-04-01'),
(95, 'Fundamentos de la Cocina Francesa', 'Principios y técnicas fundamentales de la cocina francesa clásica', '2025-04-02'),
(95, 'Salsas Madre Francesas', 'Elaboración de salsas madre y derivadas que son la base de la cocina francesa', '2025-04-03'),
(95, 'Platos Clásicos de la Gastronomía Francesa', 'Preparación de platos emblemáticos de la gastronomía francesa', '2025-04-04'),
(95, 'Cocina de Autor Francesa', 'Interpretación y creación de platos originales inspirados en la cocina francesa', '2025-04-05'),
(95, 'Quesos y Vinos Franceses', 'Degustación de quesos y vinos franceses y su combinación con platos franceses', '2025-04-06'),
(95, 'Pastelería y Repostería Francesa', 'Elaboración de postres y pasteles clásicos de la repostería francesa', '2025-04-07'),
(95, 'Cocina Regional Francesa', 'Exploración de las diferencias regionales en la cocina francesa y sus platos característicos', '2025-04-08'),
(95, 'Innovación en la Cocina Francesa', 'Tendencias actuales e innovaciones en la cocina francesa contemporánea', '2025-04-09'),
(95, 'Cena Francesa Elegante', 'Preparación y presentación de una cena elegante con platos representativos de la cocina francesa', '2025-04-10');

-- Clases para la Unidad 10: Curso de Cocina Internacional - Cocina Mediterránea
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(96, 'Introducción a la Cocina Mediterránea', 'Características y elementos comunes de la cocina mediterránea', '2025-04-15'),
(96, 'Dieta Mediterránea', 'Exploración de los principios y beneficios de la dieta mediterránea', '2025-04-16'),
(96, 'Aceites y Especias Mediterráneas', 'Uso de aceites y especias característicos en la cocina mediterránea', '2025-04-17'),
(96, 'Pescados y Mariscos Mediterráneos', 'Elaboración de platos de pescados y mariscos típicos de la región mediterránea', '2025-04-18'),
(96, 'Ensaladas y Vegetales', 'Preparación de ensaladas frescas y vegetales en la cocina mediterránea', '2025-04-19'),
(96, 'Platos de Arroz y Couscous', 'Elaboración de platos de arroz y couscous inspirados en la cocina mediterránea', '2025-04-20'),
(96, 'Carnes y Aves Mediterráneas', 'Preparación de carnes y aves con técnicas mediterráneas', '2025-04-21'),
(96, 'Quesos y Vinos Mediterráneos', 'Degustación de quesos y vinos mediterráneos y su combinación con platos mediterráneos', '2025-04-22'),
(96, 'Postres y Dulces Mediterráneos', 'Elaboración de postres y dulces típicos de la región mediterránea', '2025-04-23'),
(96, 'Cena Mediterránea al Aire Libre', 'Preparación y presentación de una cena al aire libre con platos mediterráneos', '2025-04-24');

-- Clases para la Unidad 10: Curso de Cocina Internacional - Cocina Árabe
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(97, 'Historia y Tradiciones Culinarias Árabes', 'Exploración de la historia y tradiciones culinarias de la cocina árabe', '2025-05-01'),
(97, 'Ingredientes y Especias Árabes', 'Estudio de los ingredientes y especias fundamentales en la cocina árabe', '2025-05-02'),
(97, 'Platos Tradicionales Árabes', 'Preparación de platos emblemáticos de la cocina árabe: falafel, kebab, etc.', '2025-05-03'),
(97, 'Panadería y Pastelería Árabe', 'Elaboración de panes y dulces tradicionales de la repostería árabe', '2025-05-04'),
(97, 'Técnicas de Cocina Árabe', 'Dominio de las técnicas culinarias específicas utilizadas en la cocina árabe', '2025-05-05'),
(97, 'Té y Café Árabe', 'Preparación y degustación de té y café árabe con dulces típicos', '2025-05-06'),
(97, 'Platos de Oriente Medio', 'Elaboración de platos típicos de países del Medio Oriente como Turquía, Líbano, etc.', '2025-05-07'),
(97, 'Especias y Sabores Exóticos', 'Exploración de especias y sabores exóticos utilizados en la cocina árabe', '2025-05-08'),
(97, 'Cena Árabe Festiva', 'Preparación y presentación de una cena festiva con platos árabes tradicionales', '2025-05-09'),
(97, 'Influencia Árabe en la Cocina Global', 'Impacto de la cocina árabe en la gastronomía internacional y viceversa', '2025-05-10');

-- Clases para la Unidad 10: Curso de Cocina Internacional - Cocina Fusion
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(98, 'Concepto de Cocina Fusión', 'Exploración del concepto de fusión culinaria y sus orígenes', '2025-05-15'),
(98, 'Técnicas de Fusionado de Sabores', 'Técnicas y métodos para fusionar sabores de diferentes tradiciones culinarias', '2025-05-16'),
(98, 'Platos Fusionados Populares', 'Preparación de platos fusionados que han ganado popularidad a nivel mundial', '2025-05-17'),
(98, 'Creatividad en la Cocina Fusión', 'Desarrollo de habilidades creativas para crear platos fusionados únicos', '2025-05-18'),
(98, 'Maridaje de Cocina Fusión', 'Conocimientos sobre cómo maridar vinos, cervezas y otros licores con cocina fusión', '2025-05-19'),
(98, 'Experimentación Culinaria', 'Experiencia práctica de experimentación con ingredientes y técnicas de cocina fusionada', '2025-05-20'),
(98, 'Ética en la Cocina Fusión', 'Consideraciones éticas al fusionar elementos de diferentes tradiciones culinarias', '2025-05-21'),
(98, 'Innovación y Tendencias', 'Exploración de las tendencias actuales e innovaciones en la cocina fusión', '2025-05-22'),
(98, 'Cena de Fusión Internacional', 'Preparación y presentación de una cena internacional con platos de cocina fusión', '2025-05-23'),
(98, 'Proyecto Final: Creación de un Plato Fusión', 'Desarrollo y presentación de un plato de cocina fusión original', '2025-05-24');

-- Clase Final para la Unidad 10: Curso de Cocina Internacional - Repostería Internacional
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(99, 'Postres y Dulces del Mundo', 'Exploración de postres y dulces típicos de diferentes culturas y países', '2025-06-01'),
(99, 'Técnicas de Repostería Internacional', 'Dominio de técnicas de repostería utilizadas en distintas tradiciones culinarias', '2025-06-02'),
(99, 'Ingredientes Globales en Repostería', 'Uso de ingredientes globales en la elaboración de postres internacionales', '2025-06-03'),
(99, 'Decoración y Presentación', 'Técnicas de decoración y presentación de postres internacionales', '2025-06-04'),
(99, 'Repostería de Alta Costura', 'Creación de postres de alta costura inspirados en la repostería internacional', '2025-06-05'),
(99, 'Postres Saludables del Mundo', 'Elaboración de postres saludables inspirados en diferentes culturas culinarias', '2025-06-06'),
(99, 'Innovación en la Repostería', 'Experimentación e innovación en la creación de nuevos postres internacionales', '2025-06-07'),
(99, 'Degustación y Evaluación', 'Degustación y evaluación de postres internacionales para desarrollar el paladar', '2025-06-08'),
(99, 'Replica de Postres Emblemáticos', 'Replicación de postres emblemáticos de diferentes países con técnicas precisas', '2025-06-09'),
(99, 'Exhibición de Postres Internacionales', 'Preparación y exhibición de una variedad de postres internacionales', '2025-06-10');

-- Clases para la Unidad 10: Curso de Cocina Internacional - Proyecto Final: Cena Internacional
INSERT INTO `playground`.`clases` (`unidades_id`, `titulo`, `descripcion`, `fecha_inicio`)
VALUES
(100, 'Introducción al Proyecto Final', 'Descripción y objetivos del proyecto final: Cena Internacional', '2025-06-10'),
(100, 'Investigación de Platos Representativos', 'Búsqueda e investigación de platos típicos de diferentes países para incluir en el menú', '2025-06-11'),
(100, 'Diseño del Menú Internacional', 'Elaboración del menú completo con platos representativos de diversas cocinas del mundo', '2025-06-12'),
(100, 'Planificación de la Cena', 'Planificación detallada de la cena internacional, incluyendo horarios y preparativos', '2025-06-13'),
(100, 'Revisión de Recetas y Técnicas', 'Revisión y práctica de las recetas seleccionadas y las técnicas culinarias necesarias', '2025-06-14'),
(100, 'Planificación de Cena Internacional', 'Elaboración de un menú completo representativo de la cocina internacional', '2025-06-15'),
(100, 'Compra de Ingredientes Globales', 'Selección y compra de ingredientes auténticos de diferentes culturas culinarias', '2025-06-16'),
(100, 'Preparación y Cocinado', 'Proceso de preparación y cocinado de los platos del menú internacional', '2025-06-17'),
(100, 'Decoración y Presentación', 'Decoración y presentación de la mesa y los platos de la cena internacional', '2025-06-18'),
(100, 'Cena Internacional', 'Celebración y disfrute de una cena internacional con platos representativos de todo el mundo', '2025-06-19');

-- BLOQUES PARA PYTHON
INSERT INTO `playground`.`bloques` (`clases_id`, `titulo`, `tipo`, `contenido`, `visible`)
VALUES
(1, 'Instalación de Python', 'presentación', 'Cómo instalar y configurar Python en diferentes sistemas operativos', 1),
(1, 'Sintaxis Básica', 'video', 'https://ejemplo.com/video_sintaxis_python', 1),
(1, 'Operadores y Expresiones', 'PDF', 'https://ejemplo.com/pdf_operadores_python', 1),
(2, 'Listas en Python', 'archivo', 'https://ejemplo.com/archivo_listas_python', 1),
(2, 'Tuplas en Python', 'presentación', 'Definición y características de las tuplas en Python', 1),
(3, 'Definición y Llamada de Funciones', 'texto', 'Cómo definir y llamar funciones en Python', 1),
(4, 'Conceptos Básicos de POO', 'video', 'https://ejemplo.com/video_poo_python', 1),
(4, 'Clases y Objetos', 'texto', 'Definición y uso de clases y objetos en Python', 1),
(5, 'Apertura y Cierre de Archivos', 'PDF', 'https://ejemplo.com/pdf_archivos_python', 1),
(5, 'Lectura de Archivos', 'archivo', 'https://ejemplo.com/archivo_lectura_archivos_python', 1),
(6, 'Creación de Módulos', 'presentación', 'Cómo crear y utilizar módulos en Python', 1),
(7, 'Qué son las Excepciones', 'texto', 'Concepto de excepciones y su importancia en el manejo de errores', 1),
(8, 'Introducción a Tkinter', 'video', 'https://ejemplo.com/video_tkinter_python', 1),
(9, 'Introducción a Bases de Datos', 'archivo', 'https://ejemplo.com/archivo_intro_bd_python', 1),
(10, 'Presentación del Proyecto Final', 'presentación', 'Explicación de los requisitos y objetivos del proyecto final', 1);

-- BLOQUES PARA DESARROLLO WEB
INSERT INTO `playground`.`bloques` (`clases_id`, `titulo`, `tipo`, `contenido`, `visible`)
VALUES
(11, 'Introducción a HTML - Teoría', 'texto', 'Conceptos básicos de HTML y su estructura', 1),
(11, 'Práctica: Creación de Sitio Estático - Práctica', 'video', 'https://ejemplo.com/video_html_practica', 1),
(12, 'Introducción a JavaScript - Teoría', 'texto', 'Conceptos básicos de JavaScript y su sintaxis', 1),
(12, 'Variables y Tipos de Datos - Teoría', 'presentación', 'Declaración de variables y tipos de datos en JavaScript', 1),
(12, 'Eventos y Manejo del DOM - Teoría', 'PDF', 'https://ejemplo.com/pdf_dom_javascript', 1),
(12, 'Objetos y Métodos - Teoría', 'archivo', 'https://ejemplo.com/archivo_objetos_javascript', 1),
(13, 'Introducción a Node.js - Teoría', 'texto', 'Conceptos básicos de Node.js y su instalación', 1),
(13, 'Creación de Servidores - Teoría', 'video', 'https://ejemplo.com/video_nodejs', 1),
(13, 'Rutas y Middleware - Teoría', 'presentación', 'Definición de rutas y uso de middleware en Express.js', 1),
(14, 'Introducción a Bases de Datos - Teoría', 'texto', 'Conceptos básicos de bases de datos relacionales y no relacionales', 1),
(14, 'SQL Básico - Teoría', 'video', 'https://ejemplo.com/video_sql_basico', 1),
(15, 'Introducción a React.js - Teoría', 'texto', 'Conceptos básicos de React.js y su filosofía', 1),
(15, 'Componentes y Props - Teoría', 'presentación', 'Creación y uso de componentes y props en React.js', 1),
(16, 'Introducción a Redux - Teoría', 'texto', 'Conceptos básicos de Redux y su aplicación en aplicaciones web', 1),
(16, 'Middleware - Teoría', 'archivo', 'https://ejemplo.com/archivo_middleware_redux', 1),
(17, 'Despliegue en Servidores - Teoría', 'texto', 'Opciones y consideraciones para desplegar aplicaciones web en servidores', 1),
(18, 'Riesgos de Seguridad - Teoría', 'presentación', 'Principales riesgos de seguridad en aplicaciones web y cómo mitigarlos', 1),
(18, 'SQL Injection - Teoría', 'texto', 'Prevención de ataques de inyección SQL', 1),
(18, 'XSS - Teoría', 'video', 'https://ejemplo.com/video_xss', 1),
(19, 'Tipos de Pruebas - Teoría', 'texto', 'Introducción a los diferentes tipos de pruebas en el desarrollo web', 1),
(20, 'Presentación del Proyecto Final - Teoría', 'texto', 'Explicación de los requisitos y objetivos del proyecto final', 1),
(20, 'Planificación del Proyecto - Teoría', 'archivo', 'https://ejemplo.com/archivo_planificacion_proyecto', 1),
(20, 'Implementación del Proyecto - Teoría', 'video', 'https://ejemplo.com/video_implementacion_proyecto', 1);

-- BLOQUES PARA BASE DE DATOS
INSERT INTO `playground`.`bloques` (`clases_id`, `titulo`, `tipo`, `contenido`, `visible`)
VALUES
(21, 'Introducción a SQL - Teoría', 'texto', 'Conceptos básicos de SQL y manipulación de datos', 1),
(21, 'Práctica SQL - Ejercicios', 'video', 'https://ejemplo.com/video_practica_sql', 1),
(22, 'Modelado de Datos - Teoría', 'presentación', 'Conceptos básicos de modelado de datos y diseño de bases de datos relacionales', 1),
(22, 'Ejercicio de Modelado - Práctica', 'PDF', 'https://ejemplo.com/pdf_ejercicio_modelado', 1),
(23, 'Normalización - Principios', 'texto', 'Principios de normalización y aplicación de formas normales en el diseño de bases de datos', 1),
(23, 'Ejercicio de Normalización - Práctica', 'video', 'https://ejemplo.com/video_ejercicio_normalizacion', 1),
(23, 'Ejemplo de Normalización - Caso Real', 'archivo', 'https://ejemplo.com/archivo_ejemplo_normalizacion', 1),
(24, 'Joins Avanzados - Teoría', 'texto', 'Uso de joins avanzados como OUTER JOIN, CROSS JOIN y self join', 1),
(24, 'Ejercicio de SQL Avanzado - Práctica', 'presentación', 'Resolución de consultas SQL avanzadas', 1),
(24, 'Aplicación de SQL Avanzado - Ejemplo', 'PDF', 'https://ejemplo.com/pdf_aplicacion_sql_avanzado', 1),
(25, 'Introducción a Bases de Datos No Relacionales - Teoría', 'texto', 'Conceptos básicos y tipos de bases de datos NoSQL', 1),
(25, 'Práctica con MongoDB - Ejercicios', 'video', 'https://ejemplo.com/video_practica_mongodb', 1),
(25, 'Caso de Estudio con MongoDB - Aplicación', 'archivo', 'https://ejemplo.com/archivo_caso_estudio_mongodb', 1),
(25, 'Comparativa con SQL - Análisis', 'presentación', 'Comparativa entre bases de datos NoSQL y SQL', 1),
(26, 'Introducción a MongoDB - Características', 'texto', 'Conceptos básicos y características de MongoDB como base de datos NoSQL', 1),
(26, 'Práctica con Aggregation Framework - Ejercicios', 'video', 'https://ejemplo.com/video_practica_aggregation', 1),
(26, 'Ejemplo de Implementación - Caso Real', 'archivo', 'https://ejemplo.com/archivo_ejemplo_implementacion', 1),
(27, 'Modelado de Datos para Documentos - Teoría', 'texto', 'Diseño de modelos de datos para bases de datos documentales como MongoDB', 1),
(27, 'Ejercicio de Modelado NoSQL - Práctica', 'archivo', 'https://ejemplo.com/archivo_ejercicio_modelado_nosql', 1),
(28, 'Integración con Aplicaciones Web - Teoría', 'texto', 'Integración de bases de datos NoSQL con aplicaciones web', 1),
(28, 'Desarrollo de API - Práctica', 'video', 'https://ejemplo.com/video_desarrollo_api', 1),
(28, 'Ejemplo de Integración - Caso de Estudio', 'archivo', 'https://ejemplo.com/archivo_ejemplo_integracion', 1),
(29, 'Principios de Seguridad - Teoría', 'texto', 'Principios fundamentales de seguridad en bases de datos NoSQL y SQL', 1),
(29, 'Pruebas de Seguridad - Práctica', 'presentación', 'Realización de pruebas de seguridad en bases de datos', 1),
(29, 'Análisis de Riesgos - Caso Práctico', 'archivo', 'https://ejemplo.com/archivo_analisis_riesgos', 1),
(30, 'Definición de Requerimientos - Teoría', 'texto', 'Recolección y definición de requerimientos para el proyecto final de diseño de base de datos', 1),
(30, 'Implementación del Proyecto - Práctica', 'video', 'https://ejemplo.com/video_implementacion_proyecto_bd', 1),
(30, 'Presentación del Proyecto - Evaluación', 'archivo', 'https://ejemplo.com/archivo_presentacion_proyecto_bd', 1);

-- BLOQUES PARA MACHINE LEARNING
INSERT INTO `playground`.`bloques` (`clases_id`, `titulo`, `tipo`, `contenido`, `visible`)
VALUES
(31, 'Conceptos Básicos de Aprendizaje Automático', 'texto', 'Definición y alcance del aprendizaje automático', 1),
(31, 'Historia y Evolución del Aprendizaje Automático', 'video', 'https://ejemplo.com/video_historia_ml', 1),
(32, 'Introducción a la Clasificación', 'presentación', 'Conceptos básicos y fundamentos de la clasificación en aprendizaje automático', 1),
(32, 'Algoritmos de Clasificación', 'archivo', 'https://ejemplo.com/archivo_algoritmos_clasificacion', 1),
(32, 'Regresión en Aprendizaje Automático', 'texto', 'Definición y aplicación de modelos de regresión en problemas de aprendizaje automático', 1),
(33, 'Introducción al Agrupamiento', 'video', 'https://ejemplo.com/video_introduccion_agrupamiento', 1),
(33, 'Algoritmos de Agrupamiento', 'presentación', 'Revisión de algoritmos de agrupamiento como K-Means y DBSCAN', 1),
(34, 'Introducción al Aprendizaje No Supervisado', 'texto', 'Conceptos básicos y diferencias con el aprendizaje supervisado', 1),
(34, 'Agrupamiento K-Means', 'video', 'https://ejemplo.com/video_kmeans', 1),
(35, 'Introducción al Aprendizaje Profundo', 'presentación', 'Conceptos básicos y motivación detrás del aprendizaje profundo', 1),
(35, 'Redes Neuronales Artificiales', 'PDF', 'https://ejemplo.com/pdf_redes_neuronales', 1),
(36, 'Introducción al Procesamiento de Lenguaje Natural', 'archivo', 'https://ejemplo.com/archivo_pln', 1),
(36, 'Preprocesamiento de Texto', 'video', 'https://ejemplo.com/video_preprocesamiento_pln', 1),
(37, 'Introducción a la Visión por Computadora', 'presentación', 'Conceptos fundamentales y aplicaciones de la visión por computadora', 1),
(37, 'Procesamiento de Imágenes', 'PDF', 'https://ejemplo.com/pdf_procesamiento_imagenes', 1),
(38, 'Introducción al Aprendizaje por Refuerzo', 'texto', 'Conceptos básicos y formulación del problema en aprendizaje por refuerzo', 1),
(38, 'Procesos de Decisión de Markov (MDP)', 'video', 'https://ejemplo.com/video_mdp', 1),
(39, 'Ética en la Ciencia de Datos', 'presentación', 'Principios éticos y responsabilidades en el uso de datos y algoritmos', 1),
(39, 'Bias y Fairness', 'texto', 'Identificación y mitigación de sesgos en modelos y datos', 1),
(40, 'Definición del Proyecto', 'archivo', 'https://ejemplo.com/archivo_definicion_proyecto_ml', 1),
(40, 'Análisis y Preparación de Datos', 'video', 'https://ejemplo.com/video_analisis_datos_ml', 1);

-- BLOQUES PARA DESARROLLO VIDEOJUEGOS
INSERT INTO `playground`.`bloques` (`clases_id`, `titulo`, `tipo`, `contenido`, `visible`)
VALUES
(41, 'Conceptos Básicos', 'texto', 'Contenido del bloque 1', 1),
(41, 'Evolución de los Videojuegos', 'video', 'https://ejemplo.com/video1', 1),
(41, 'Plataformas y Géneros', 'presentación', 'https://ejemplo.com/presentacion1', 1),
(41, 'Cultura Gamer', 'archivo', 'https://ejemplo.com/archivo1', 1),
(42, 'Principios de Diseño', 'texto', 'Contenido del bloque 5', 1),
(42, 'Narrativa y Temática', 'video', 'https://ejemplo.com/video2', 1),
(43, 'Fundamentos de Juegos 2D', 'presentación', 'https://ejemplo.com/presentacion2', 1),
(43, 'Herramientas de Desarrollo', 'archivo', 'https://ejemplo.com/archivo2', 1),
(43, 'Sprites y Animaciones', 'texto', 'Contenido del bloque 9', 1),
(43, 'Física en Juegos 2D', 'video', 'https://ejemplo.com/video3', 1),
(44, 'Introducción a Juegos 3D', 'presentación', 'https://ejemplo.com/presentacion3', 1),
(44, 'Herramientas de Modelado', 'archivo', 'https://ejemplo.com/archivo3', 1),
(45, 'Principios de Física en Videojuegos', 'texto', 'Contenido del bloque 13', 1),
(46, 'Introducción a la Inteligencia Artificial en Videojuegos', 'presentación', 'https://ejemplo.com/presentacion4', 1),
(46, 'Agentes y Comportamiento', 'video', 'https://ejemplo.com/video4', 1),
(47, 'Principios de Diseño de Niveles', 'texto', 'Contenido del bloque 16', 1),
(47, 'Flujo del Jugador', 'presentación', 'https://ejemplo.com/presentacion5', 1),
(47, 'Diseño de Escenarios', 'archivo', 'https://ejemplo.com/archivo4', 1),
(48, 'Fundamentos de Audio en Videojuegos', 'video', 'https://ejemplo.com/video5', 1),
(48, 'Creación de Efectos de Sonido', 'texto', 'Contenido del bloque 20', 1),
(48, 'Composición Musical', 'presentación', 'https://ejemplo.com/presentacion6', 1),
(49, 'Importancia de las Pruebas en Videojuegos', 'archivo', 'https://ejemplo.com/archivo5', 1),
(49, 'Tipos de Pruebas', 'texto', 'Contenido del bloque 23', 1),
(49, 'Herramientas de Pruebas', 'video', 'https://ejemplo.com/video6', 1),
(49, 'Pruebas Funcionales', 'presentación', 'https://ejemplo.com/presentacion7', 1),
(50, 'Fase de Planificación', 'texto', 'Contenido del bloque 26', 1);

-- BLOQUES PARA MARKETING DIGITAL
INSERT INTO `playground`.`bloques` (`clases_id`, `titulo`, `tipo`, `contenido`, `visible`)
VALUES
(51, 'Introducción al Marketing Digital', 'texto', 'Conceptos básicos y alcance del marketing digital', 1),
(51, 'Estrategias de Marketing en Redes Sociales', 'video', 'https://ejemplo.com/video_estrategias_redes_sociales', 1),
(51, 'Herramientas de Analítica Web', 'presentación', 'Uso y aplicación de herramientas de analítica web como Google Analytics', 1),
(52, 'Email Marketing', 'archivo', 'https://ejemplo.com/archivo_email_marketing', 1),
(52, 'Automatización de Marketing', 'video', 'https://ejemplo.com/video_automatizacion_marketing', 1),
(53, 'SEO (Optimización de Motores de Búsqueda)', 'presentación', 'Técnicas y estrategias para mejorar el posicionamiento en buscadores', 1),
(53, 'SEM (Marketing en Motores de Búsqueda)', 'PDF', 'https://ejemplo.com/pdf_sem', 1),
(54, 'Marketing de Contenidos', 'texto', 'Estrategias y mejores prácticas para la creación de contenido relevante', 1),
(54, 'Inbound Marketing', 'video', 'https://ejemplo.com/video_inbound_marketing', 1),
(55, 'Publicidad en Línea (Display y PPC)', 'presentación', 'Conceptos y herramientas para la publicidad en línea', 1),
(55, 'Remarketing', 'archivo', 'https://ejemplo.com/archivo_remarketing', 1),
(56, 'Marketing de Influencia', 'video', 'https://ejemplo.com/video_marketing_influencia', 1),
(56, 'Gestión de Reputación Online', 'PDF', 'https://ejemplo.com/pdf_reputacion_online', 1),
(57, 'Análisis de Datos en Marketing', 'texto', 'Métodos y técnicas para analizar datos de marketing y tomar decisiones', 1),
(57, 'Segmentación de Mercado', 'presentación', 'Estrategias para segmentar y dirigirse a diferentes tipos de audiencia', 1),
(58, 'Campañas de Marketing Digital', 'archivo', 'https://ejemplo.com/archivo_campañas_marketing_digital', 1),
(58, 'Métricas y KPIs en Marketing', 'video', 'https://ejemplo.com/video_metricas_kpis', 1),
(59, 'Legalidad y Ética en Marketing Digital', 'presentación', 'Consideraciones legales y éticas en las estrategias de marketing digital', 1),
(59, 'Privacidad de Datos y Cumplimiento Normativo', 'texto', 'Políticas de privacidad y cumplimiento normativo en el uso de datos', 1),
(60, 'Desarrollo de Estrategia Digital', 'archivo', 'https://ejemplo.com/archivo_estrategia_digital', 1),
(60, 'Implementación de Campañas', 'video', 'https://ejemplo.com/video_implementacion_campañas', 1);

-- BLOQUES PARA FOTOGRAFIA
-- BLOQUES PARA FOTOGRAFÍA
INSERT INTO `playground`.`bloques` (`clases_id`, `titulo`, `tipo`, `contenido`, `visible`)
VALUES
(61, 'Introducción a la Fotografía', 'texto', 'Conceptos básicos y principios fundamentales de la fotografía', 1),
(61, 'Historia de la Fotografía', 'video', 'https://ejemplo.com/video_historia_fotografia', 1),
(61, 'Encuadre y Composición', 'presentación', 'Técnicas para componer imágenes visualmente atractivas', 1),
(61, 'Iluminación en Fotografía', 'PDF', 'https://ejemplo.com/pdf_iluminacion_fotografia', 1),
(62, 'Equipo Fotográfico Básico', 'texto', 'Descripción y funciones básicas de cámaras y accesorios', 1),
(62, 'Técnica de Exposición', 'video', 'https://ejemplo.com/video_tecnica_exposicion', 1),
(63, 'Composición Fotográfica', 'presentación', 'Principios de composición y reglas para crear imágenes impactantes', 1),
(64, 'Fotografía de Retrato', 'archivo', 'https://ejemplo.com/archivo_fotografia_retrato', 1),
(65, 'Fotografía de Paisaje', 'video', 'https://ejemplo.com/video_fotografia_paisaje', 1),
(65, 'Fotografía de Naturaleza', 'PDF', 'https://ejemplo.com/pdf_fotografia_naturaleza', 1),
(66, 'Edición Fotográfica Básica', 'texto', 'Introducción a la edición de fotografías con software básico', 1),
(67, 'Software de Edición Avanzada', 'presentación', 'Uso avanzado de herramientas de edición como Adobe Lightroom y Photoshop', 1),
(68, 'Fotografía de Producto', 'video', 'https://ejemplo.com/video_fotografia_producto', 1),
(68, 'Fotografía de Moda', 'PDF', 'https://ejemplo.com/pdf_fotografia_moda', 1),
(69, 'Fotografía Nocturna', 'texto', 'Técnicas y consejos para la fotografía en condiciones de poca luz', 1),
(69, 'Fotografía de Arquitectura', 'presentación', 'Captura de la belleza arquitectónica y composición de imágenes', 1),
(69, 'Fotografía de Viajes', 'archivo', 'https://ejemplo.com/archivo_fotografia_viajes', 1),
(70, 'Fotografía Documental', 'video', 'https://ejemplo.com/video_fotografia_documental', 1),
(70, 'Fotografía de Eventos', 'PDF', 'https://ejemplo.com/pdf_fotografia_eventos', 1);

-- BLOQUES PARA INGLES
-- BLOQUES PARA INGLÉS
INSERT INTO `playground`.`bloques` (`clases_id`, `titulo`, `tipo`, `contenido`, `visible`)
VALUES
(71, 'Introducción al Inglés', 'texto', 'Conceptos básicos y fundamentos del idioma inglés', 1),
(71, 'Gramática Básica', 'video', 'https://ejemplo.com/video_gramatica_basica', 1),
(71, 'Vocabulario Esencial', 'presentación', 'Palabras y frases esenciales para comunicarse en inglés', 1),
(71, 'Pronunciación', 'PDF', 'https://ejemplo.com/pdf_pronunciacion_ingles', 1),
(72, 'Conversación Cotidiana', 'texto', 'Práctica de diálogos y situaciones cotidianas en inglés', 1),
(72, 'Expresiones Idiomáticas', 'video', 'https://ejemplo.com/video_expresiones_idiomaticas', 1),
(72, 'Verbos Irregulares', 'presentación', 'Listado y uso de verbos irregulares en inglés', 1),
(73, 'Comprensión Auditiva', 'archivo', 'https://ejemplo.com/archivo_comprension_auditiva', 1),
(74, 'Comprensión de Lectura', 'video', 'https://ejemplo.com/video_comprension_lectura', 1),
(74, 'Redacción Básica', 'PDF', 'https://ejemplo.com/pdf_redaccion_basica_ingles', 1),
(75, 'Inglés para Viajes', 'texto', 'Vocabulario y frases útiles para viajar y comunicarse en inglés', 1),
(75, 'Inglés de Negocios', 'presentación', 'Términos y situaciones comunes en el ámbito empresarial en inglés', 1),
(75, 'Preparación para Exámenes', 'archivo', 'https://ejemplo.com/archivo_preparacion_examenes_ingles', 1),
(76, 'Inglés Académico', 'video', 'https://ejemplo.com/video_ingles_academico', 1),
(76, 'Escritura Académica', 'PDF', 'https://ejemplo.com/pdf_escritura_academica_ingles', 1),
(77, 'Inglés Avanzado', 'texto', 'Conceptos y prácticas avanzadas del idioma inglés', 1),
(77, 'Inglés Técnico', 'presentación', 'Términos y conceptos técnicos en inglés para diferentes industrias', 1),
(78, 'Inglés para Presentaciones', 'video', 'https://ejemplo.com/video_ingles_presentaciones', 1),
(78, 'Entrevistas en Inglés', 'PDF', 'https://ejemplo.com/pdf_entrevistas_ingles', 1),
(79, 'Inglés de Medios', 'texto', 'Uso del inglés en medios de comunicación como noticias, películas y música', 1),
(79, 'Inglés en Redes Sociales', 'presentación', 'Expresiones y vocabulario común en inglés para redes sociales', 1),
(79, 'Inglés para Arte y Cultura', 'archivo', 'https://ejemplo.com/archivo_ingles_arte_cultura', 1),
(80, 'Inglés Científico', 'video', 'https://ejemplo.com/video_ingles_cientifico', 1),
(80, 'Inglés Jurídico', 'PDF', 'https://ejemplo.com/pdf_ingles_juridico', 1);

-- BLOQUES PARA FINANZAS
INSERT INTO `playground`.`bloques` (`clases_id`, `titulo`, `tipo`, `contenido`, `visible`)
VALUES
(81, 'Introducción a las Finanzas', 'texto', 'Conceptos básicos y fundamentos de las finanzas personales y corporativas', 1),
(82, 'Estructura del Sistema Financiero', 'video', 'https://ejemplo.com/video_estructura_sistema_financiero', 1),
(83, 'Valor del Dinero en el Tiempo', 'archivo', 'https://ejemplo.com/archivo_valor_dinero_tiempo', 1),
(84, 'Intereses y Tasas de Interés', 'texto', 'Concepto de interés y cálculo de tasas de interés en diferentes contextos financieros', 1),
(85, 'Presupuesto Personal', 'presentación', 'Elaboración y seguimiento de un presupuesto personal para controlar ingresos y gastos', 1),
(86, 'Planificación Financiera a Corto Plazo', 'archivo', 'https://ejemplo.com/archivo_planificacion_financiera_corto_plazo', 1),
(87, 'Inversiones de Mediano y Largo Plazo', 'video', 'https://ejemplo.com/video_inversiones_mediano_largo_plazo', 1),
(88, 'Gestión del Riesgo Financiero', 'texto', 'Conceptos y estrategias para gestionar el riesgo en las decisiones financieras', 1),
(89, 'Análisis Financiero Avanzado', 'presentación', 'Herramientas y técnicas para el análisis financiero avanzado de empresas', 1),
(90, 'Finanzas Corporativas', 'archivo', 'https://ejemplo.com/archivo_finanzas_corporativas', 1);

-- BLOQUES PARA COCINA
INSERT INTO `playground`.`bloques` (`clases_id`, `titulo`, `tipo`, `contenido`, `visible`)
VALUES
(91, 'Introducción a la Cocina Italiana', 'texto', 'Conceptos básicos y principios fundamentales de la cocina italiana', 1),
(92, 'Pasta Fresca Casera', 'video', 'https://ejemplo.com/video_pasta_fresca_casera', 1),
(92, 'Salsa Boloñesa', 'archivo', 'https://ejemplo.com/archivo_salsa_bolonesa', 1),
(93, 'Pizza Napolitana', 'presentación', 'Elaboración tradicional de la auténtica pizza napolitana', 1),
(94, 'Tiramisú', 'texto', 'Receta clásica y técnica de preparación del tiramisú italiano', 1),
(95, 'Introducción a la Cocina Mexicana', 'video', 'https://ejemplo.com/video_introduccion_cocina_mexicana', 1),
(95, 'Guacamole', 'presentación', 'Elaboración paso a paso del guacamole mexicano', 1),
(95, 'Tacos al Pastor', 'archivo', 'https://ejemplo.com/archivo_tacos_al_pastor', 1),
(96, 'Sushi y Sashimi', 'texto', 'Técnicas y preparación de sushi y sashimi japoneses', 1),
(97, 'Curry de Pollo', 'video', 'https://ejemplo.com/video_curry_pollo', 1),
(97, 'Arroz Basmati', 'archivo', 'https://ejemplo.com/archivo_arroz_basmati', 1),
(98, 'Paella Española', 'presentación', 'Elaboración tradicional de la paella española', 1),
(98, 'Gazpacho Andaluz', 'texto', 'Receta refrescante y saludable del gazpacho andaluz', 1),
(98, 'Tortilla Española', 'video', 'https://ejemplo.com/video_tortilla_espanola', 1),
(99, 'Rollitos de Primavera', 'archivo', 'https://ejemplo.com/archivo_rollitos_primavera', 1),
(100, 'Pad Thai', 'presentación', 'Preparación auténtica del pad thai tailandés', 1);

-- CATEGORIA USUARIOS
INSERT INTO `playground`.`categoria` (`id`, `tipo`)
VALUES
(1, 'estudiantes'),
(2, 'docentes'),
(3, 'editores'),
(4, 'administradores');

-- USUARIOS
INSERT INTO `playground`.`usuarios` (`nombre`, `apellido`, `email`, `contraseña`, `categoria_id`)
VALUES
('John', 'Doe', 'john.doe@example.com', 'password1', 1),
('Jane', 'Smith', 'jane.smith@example.com', 'password2', 1),
('Michael', 'Johnson', 'michael.johnson@example.com', 'password3', 1),
('Emily', 'Williams', 'emily.williams@example.com', 'password4', 1),
('William', 'Brown', 'william.brown@example.com', 'password5', 1),
('Emma', 'Jones', 'emma.jones@example.com', 'password6', 1),
('Olivia', 'Garcia', 'olivia.garcia@example.com', 'password7', 1),
('James', 'Martinez', 'james.martinez@example.com', 'password8', 1),
('Alexander', 'Hernandez', 'alexander.hernandez@example.com', 'password9', 1),
('Sophia', 'Lopez', 'sophia.lopez@example.com', 'password10', 1),
('Daniel', 'Gonzalez', 'daniel.gonzalez@example.com', 'password11', 1),
('Isabella', 'Wilson', 'isabella.wilson@example.com', 'password12', 1),
('Matthew', 'Taylor', 'matthew.taylor@example.com', 'password13', 1),
('Amelia', 'Lee', 'amelia.lee@example.com', 'password14', 1),
('Ethan', 'Rodriguez', 'ethan.rodriguez@example.com', 'password15', 1),
('Mia', 'Martinez', 'mia.martinez@example.com', 'password16', 1),
('Aiden', 'Brown', 'aiden.brown@example.com', 'password17', 1),
('Harper', 'Davis', 'harper.davis@example.com', 'password18', 1),
('Benjamin', 'Miller', 'benjamin.miller@example.com', 'password19', 1),
('Evelyn', 'Garcia', 'evelyn.garcia@example.com', 'password20', 1),
('Logan', 'Jackson', 'logan.jackson@example.com', 'password21', 1),
('Charlotte', 'Thompson', 'charlotte.thompson@example.com', 'password22', 1),
('Lucas', 'White', 'lucas.white@example.com', 'password23', 1),
('Avery', 'Harris', 'avery.harris@example.com', 'password24', 1),
('Liam', 'Clark', 'liam.clark@example.com', 'password25', 1),
('Aria', 'Lewis', 'aria.lewis@example.com', 'password26', 1),
('Mason', 'Walker', 'mason.walker@example.com', 'password27', 1),
('Ella', 'Hall', 'ella.hall@example.com', 'password28', 1),
('Sophia', 'Hernandez', 'sophia.hernandez@example.com', 'password29', 2),
('Benjamin', 'Adams', 'benjamin.adams@example.com', 'password30', 2),
('Ethan', 'Cook', 'ethan.cook@example.com', 'password31', 2),
('Avery', 'Rivera', 'avery.rivera@example.com', 'password32', 2),
('Liam', 'Parker', 'liam.parker@example.com', 'password33', 2),
('Mia', 'Wright', 'mia.wright@example.com', 'password34', 2),
('Aria', 'Perez', 'aria.perez@example.com', 'password35', 2),
('Amelia', 'Cox', 'amelia.cox@example.com', 'password36', 2),
('Mason', 'Bailey', 'mason.bailey@example.com', 'password37', 2),
('Ella', 'Flores', 'ella.flores@example.com', 'password38', 2),
('Logan', 'Bryant', 'logan.bryant@example.com', 'password39', 2),
('Charlotte', 'Sanders', 'charlotte.sanders@example.com', 'password40', 2),
('Lucas', 'Price', 'lucas.price@example.com', 'password41', 2),
('Emily', 'Griffin', 'emily.griffin@example.com', 'password42', 2),
('William', 'Mitchell', 'william.mitchell@example.com', 'password43', 3),
('Olivia', 'Young', 'olivia.young@example.com', 'password44', 3),
('James', 'Fisher', 'james.fisher@example.com', 'password45', 3),
('Alexander', 'Russell', 'alexander.russell@example.com', 'password46', 3),
('Emma', 'Long', 'emma.long@example.com', 'password47', 3),
('Michael', 'Hayes', 'michael.hayes@example.com', 'password48', 3),
('Jane', 'Bell', 'jane.bell@example.com', 'password49', 4),
('John', 'Carter', 'john.carter@example.com', 'password50', 4);

-- USUARIOS CURSOS

INSERT INTO `playground`.`usuarios_cursos` (`cursos_id`, `usuarios_id`)
VALUES
(5, 8),
(4, 32),
(3, 20),
(9, 41),
(5, 16),
(2, 31),
(1, 11),
(9, 9),
(3, 35),
(6, 16),
(7, 41),
(8, 3),
(7, 20),
(8, 49),
(5, 23),
(4, 34),
(8, 43),
(1, 29),
(9, 27),
(7, 35),
(6, 48),
(9, 36),
(1, 27),
(8, 24),
(1, 12),
(2, 50),
(9, 8),
(2, 4),
(7, 38),
(7, 11),
(1, 14),
(9, 29),
(8, 25),
(9, 18),
(6, 25),
(3, 26),
(2, 41),
(7, 17),
(1, 29),
(9, 2),
(6, 48),
(9, 35),
(8, 40),
(7, 46),
(8, 48),
(5, 34),
(4, 4),
(1, 8),
(9, 7),
(6, 15),
(3, 34),
(2, 14),
(8, 43),
(3, 28),
(4, 20),
(9, 35),
(5, 17),
(2, 33),
(9, 28),
(5, 15),
(6, 50),
(7, 36),
(3, 22),
(7, 44),
(8, 29),
(2, 13),
(9, 38),
(6, 35),
(1, 25),
(7, 39),
(8, 46),
(5, 4),
(4, 28),
(1, 13),
(9, 20),
(5, 17),
(6, 36),
(3, 50),
(7, 45),
(9, 20);

