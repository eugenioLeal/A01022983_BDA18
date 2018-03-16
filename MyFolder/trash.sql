-- 5) Realiza un procedimiento almacenado (y cursores) que permita agregar el idioma original (original_language) a la tabla film.
-- Por el momento no es posible saber el lenguaje original de todas las películas,
-- pero sí se sabe la siguiente información.
--      Todas las películas con categoría “Documentary” están en italiano
--      Todas las películas con categoría “Foreign” están en japonés
--      Todas las película en las que actúa SISSI SOBIESKI están en alemán
--      Todas las películas en las que actúa ED CHASE están en mandarín
--      Todas las películas en las que actúa AUDREY OLIVIER están en francés
-- El resto de películas está en inglés

SELECT title,name,first_name,last_name,original_language FROM film
  join film_category on film.film_id = film_category.film_id
  join category on film_category.category_id = category.category_id
  join film_actor on film.film_id = film_actor.film_id
  join actor on actor.actor_id =film_actor.actor_id;



  DELIMITER //
CREATE PROCEDURE curdemo()
BEGIN
  alter table films
  add column original_language varchar(30);
  DECLARE done INT DEFAULT FALSE;
  DECLARE fname, lname, genere, name varCHAR(20);
  DECLARE cur1 CURSOR FOR SELECT name, first_name, last_name FROM film
  join film_category on film.film_id = film_category.film_id
  join category on film_category.category_id = category.category_id
  join film_actor on film.film_id = film_actor.film_id
  join actor on actor.actor_id =film_actor.actor_id;


  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cur1;

  read_loop: LOOP

    IF done THEN
      LEAVE read_loop;
    END IF;

        FETCH cur1 INTO genere,fname,lname;
        if(CONCAT((fname)," ",(lname)='SISSI SOBIESKI')
        {
			insert into film where film_id=filmid
        }





    END LOOP;

  CLOSE cur1;

END;
//
