/*
Autor: Andrea Maldonado


1. Crea y agrega al entregable las consultas para completar el setup de acuerdo a lo
pedido.*/

CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    email VARCHAR(100) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    rol VARCHAR(50) NOT NULL
);


INSERT INTO usuarios (email, nombre, apellido, rol) 
VALUES
('amaldonado@gmail.com', 'Andrea', 'Maldonado', 'Administrador'),
('dsanchez@a.com', 'Daniela', 'Sanchez', 'Usuario'),
('cornejo@b.com', 'Cristobal', 'Cornejo', 'Usuario'),
('tperez@c.com', 'Tomás', 'Perez', 'Usuario'),
('opaine@d.com', 'Osvaldo', 'Painenao', 'Administrador');


select * from usuarios;

CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    contenido TEXT NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    destacado BOOLEAN DEFAULT FALSE,
    usuario_id BIGINT REFERENCES usuarios(id) ON DELETE SET NULL
);



INSERT INTO posts (titulo, contenido, usuario_id, destacado) VALUES
('Alimentación Balanceada', 'Alimentarse con los 5 grupos es lo correcto. Para una vida saludable.', 1, TRUE),
('Inversiones al Alza', 'Las inversiones han estado estado durante este mes en los fondos de pensiones.', 1, FALSE),
('Delincuencia', 'Prueba de texto de delincuencia en las calles', 3, TRUE),
('IPC a la baja', 'IPC noto una baja de un punto respecto al mes pasado.', 4, FALSE),
('Viajar es saludable', 'Viajar y tener experiencias de viaje puede mejorar el estado de humor.', NULL, FALSE);


select * from posts



CREATE TABLE comentarios (
    id SERIAL PRIMARY KEY,
    contenido TEXT NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario_id BIGINT REFERENCES usuarios(id) ON DELETE SET NULL,
    post_id BIGINT REFERENCES posts(id) ON DELETE CASCADE
);

drop table comentarios;

-- Insertar registros en comentarios (fecha se carga por defecto)
INSERT INTO comentarios (contenido, usuario_id, post_id) VALUES
('No considero correcto alimentarse en base a los 5 grupos', 1, 1),
('Me encanta el azucar', 1, 1),
('Santiago esta terrible', 3, 3),
('No se nota la baja del IPC', 4, 4),
('Aún no entiendo como se debo alimentar.', 4, 1);
 
--select * from comentarios
