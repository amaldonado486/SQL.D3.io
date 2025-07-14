/*2. Cruza los datos de la tabla usuarios y posts, mostrando las siguientes columnas:
nombre y email del usuario junto al título y contenido del post.*/

select u.nombre,
	   u.email,
	   p.titulo,
	   p.contenido
  from usuarios u
  inner join posts p on u.id = p.usuario_id;

/*
3. Muestra el id, título y contenido de los posts de los administradores.
a. El administrador puede ser cualquier id.*/
select p.id,
       p.titulo,
	   p.contenido
from posts p
INNER JOIN usuarios u ON p.usuario_id = u.id
where u.rol = 'Administrador';

/*
4. Cuenta la cantidad de posts de cada usuario.
a. La tabla resultante debe mostrar el id e email del usuario junto con la
cantidad de posts de cada usuario.
*/

select * from usuarios u left join posts p on u.id = p.usuario_id;


Select u.id,
      u.email,
	  count(p.titulo) as cantidad
  from usuarios u
  left join posts p on u.id = p.usuario_id
group by u.id,
	  u.email
Order by u.id asc;

/*
5. Muestra el email del usuario que ha creado más posts.
a. Aquí la tabla resultante tiene un único registro y muestra solo el email.
*/	 
SELECT u.nombre,
	   u.email,
	  COUNT(*) cantidad
FROM usuarios u
LEFT JOIN posts p ON u.id = p.usuario_id
group by u.nombre,
		 u.email
ORDER BY 3 desc
LIMIT 1;

/* 6. Muestra la fecha del último post de cada usuario */
select u.nombre,
	  MAX(p.fecha_creacion) as ult_post
from usuarios u
inner join posts p
on u.id = p.usuario_id
group by u.nombre
order by 2 desc;


/*7. Muestra el título y contenido del post (artículo) con más comentarios.
*/
Select p.titulo, p.contenido, count(*) cant_comentarios
from posts p
inner join comentarios c
on p.id = c.post_id
group by p.titulo, p.contenido
ORDER BY 3 desc
LIMIT 1;

/*
8. Muestra en una tabla el título de cada post, el contenido de cada post y el contenido
de cada comentario asociado a los posts mostrados, junto con el email del usuario
que lo escribió.*/

select p.titulo    as titulo_post,
	   p.contenido as contenido_post,
	   CASE WHEN c.contenido IS NULL THEN '' ELSE c.contenido end as contenido_comentario,
	   case when u.nombre is null then '' else u.nombre end nombre  
from posts p
left join comentarios c
on p.id = c.post_id
left join usuarios u
on u.id = p.usuario_id;



/*9.  Muestra el contenido del último comentario de cada usuario.*/

select u.nombre as usuario,
	  c.contenido as contenido_comentario,
	  c.fecha_creacion as fecha_ult_comentario
from usuarios u
inner join comentarios c
on u.id = c.usuario_id
where c.fecha_creacion = (SELECT MAX(c2.fecha_creacion)
                             FROM comentarios c2
							 WHERE c2.usuario_id = u.id);


--10. Muestra los emails de los usuarios que no han escrito ningún comentario.
--Hint: Recuerda el uso de Having
select u.nombre,
	  u.email
from usuarios u
left join comentarios c on u.id = c.usuario_id
group by u.nombre,
	     u.email
having count(c.id) = 0;							 