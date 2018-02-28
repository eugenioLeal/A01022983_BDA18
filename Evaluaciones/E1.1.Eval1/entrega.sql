
-- MYSQL --

-- 1) Carga la base de datos Sakila

-- 2) Crea una tabla LOG_FILM en la para almacenar todos los cambios realizados a la
-- tabla film los campos de la tabla son los siguientes:
--      Id. número consecutivo, único y que no permite valores nulos
--      Tipo. Tipo de operación realizada (siempre es  update)
--      Film_id. id de el film que se modificó
--      Last_value. Valor anterior (no importa lo que se modifiqué, todo se castea a texto)
--      New_value. Valor modificado (no importa lo que se modifiqué, todo se castea a texto)
--      Timestamp. Almacena la información de fecha y hora del cambio
create table log_film (
	id int primary key not null auto_increment,
    tipo varchar(50) not null default 'update',
    film_id smallint(5) unsigned not null,
    last_value varchar(200),
    new_value varchar(200),
    tstamp timestamp,
    foreign key (film_id) references film (film_id)
);

-- 3) Crea un stored procedure que reciba los datos necesarios
--    para almacenar la información de la tabla LOG_FILM
use classicmodels;
delimiter $$
create procedure store_data(in pelicula smallint(5) unsigned, in ultimo varchar(255), in nuevo varchar(255)
BEGIN
    insert into LOG_FILM(film_id, last_value, new_value) values(pelicula, ultimo, nuevo);
END$$
delimiter ;

-- 4) Crea un trigger que se active cada vez que realizamos un update en la tabla film.
--    Este trigger guarda la información requerida en la tabla LOG_FILM utilizando el stored procedure del inciso 3
delimiter $$
create trigger on_update_film
after update on film
for each row
begin
	if new.original_language_id is not null then
		call store_data(new.film_id, old.original_language_id, new.original_language_id);
    end if;
end$$
delimiter ;


-- 5) Realiza un procedimiento almacenado (y cursores) que permita agregar el idioma original (original_language) a la tabla film.
-- Por el momento no es posible saber el lenguaje original de todas las películas,
-- pero sí se sabe la siguiente información.
--      Todas las películas con categoría “Documentary” están en italiano
--      Todas las películas con categoría “Foreign” están en japonés
--      Todas las película en las que actúa SISSI SOBIESKI están en alemán
--      Todas las películas en las que actúa ED CHASE están en mandarín
--      Todas las películas en las que actúa AUDREY OLIVIER están en francés
-- El resto de películas está en inglés
delimiter $$
create procedure agregar_idioma()
BEGIN
    declare var int;
    declare done int DEFAULT FALSE;
    declare mi_cursor CURSOR FOR SELECT film_id FROM film;
    declare continue handler FOR NOT FOUND SET done = true;
    open mi_cursor;
    read_loop: loop
        fetch mi_cursor into
        if done then
            leave read_loop;
        end if;
        if (SELECT category_id FROM film_category WHERE film_id = var) = 6 THEN update film SET original_language_id = 2 WHERE film_id = var;
        elseif (SELECT category_id FROM film_category WHERE film_id = var) = 9 THEN update film SET original_language_id = 3 WHERE film_id = var;
        elseif (SELECT COUNT(*) FROM film_actor WHERE film_id = var AND actor_id = 31) = 1 THEN update film SET original_language_id = 6 WHERE film_id = var;
        elseif (SELECT COUNT(*) FROM film_actor WHERE film_id = var AND actor_id = 3) = 1 THEN update film SET original_language_id = 4 WHERE film_id = var;
        elseif (SELECT COUNT(*) FROM film_actor WHERE film_id = var AND actor_id = 34) = 1 THEN update film SET original_language_id = 5 WHERE film_id = var;
        else update film SET original_language_id=1 WHERE film_id = var;
END if;
    end loop;
    close mi_cursor;
END$$
delimiter ;

-- DB2 --

-- Utiliza db2 para modelar el siguiente caso práctico

-- La empresa Mary Gomitas S.A. es una empresa de retail dedicada a la
-- venta de gomitas de todos los sabores. La empresa desea que le diseñes
-- una base de datos que le permita lo siguiente:

-- 1) Almacenar toda la información relacionada con sus gomitas
-- 2) Registrar las variaciones de precios de las gomitas
-- a) Las gomitas cambian de precio el día 1o de febrero, 25 de abril y 25 de octubre.
--    Se incrementa el precio es un 45% sobre su valor
-- b) Las gomitas cambian de precio el 15 de febrero, 5 de mayo y 5 de noviembre.
--    El nuevo precio es igual al precio anterior al 1 de febrero más un incremento de 10%
-- 3) En enero se surte la tienda. Realiza al menos 12 inserciones de
--    diferentes productos y con diferentes preciosa cada uno en la tabla o tablas que hayas creado en el punto 1
-- a) El precio de los productos está considera de manera inicial para
--    ser el mismo durante todo el año (1 enero del 2018 al 1 enero de 2019)
-- 4) Realiza las actualizaciones de precios según el punto número 2.
-- 5) Realiza las siguientes consultas:
-- a) Consulta que muestre el precio promedio de cada producto durante todo el año
-- b) Consulta que los precios más altos de cada producto
-- c) Consulta que los precios más bajos de cada producto
CREATE TABLE gomitas(
    id int NOT NULL,
    price decimal(6,2) NOT NULL,
    cstart date NOT NULL,
    cend date NOT NULL,
    period business_time(cstart, cend),
    PRIMARY key(id, bussiness_time WITHOUT overlaps)
);

insert into gomitas(id, price, cstart, cend, period)
insert into gomitas(1, 3, "2018-01-01", "2017-01-01")
insert into gomitas(2, 3, "2018-01-01", "2017-01-01")
insert into gomitas(3, 3, "2018-01-01", "2017-01-01")
insert into gomitas(4, 3, "2018-01-01", "2017-01-01")
insert into gomitas(5, 3, "2018-01-01", "2017-01-01")
insert into gomitas(6, 3, "2018-01-01", "2017-01-01")
insert into gomitas(7, 3, "2018-01-01", "2017-01-01")
insert into gomitas(8, 3, "2018-01-01", "2017-01-01")
insert into gomitas(9, 3, "2018-01-01", "2017-01-01")
insert into gomitas(10, 3, "2018-01-01", "2017-01-01")
insert into gomitas(11, 3, "2018-01-01", "2017-01-01")
insert into gomitas(12, 3, "2018-01-01", "2017-01-01")

update gomitas
for portion of business_time FROM '2018-2-1' to '2019-1-1'
  set price = price * 1.45;

update gomitas
for portion of business_time FROM '2018-2-15' to '2019-1-1'
  set price = (price / 1.45) * 1.1;

update gomitas
for portion of business_time FROM '2018-4-25' to '2019-1-1'
  set price = price * 1.45;

update gomitas
for portion of business_time FROM '2018-5-5' to '2019-1-1'
  set price = (price / 1.45)*1.1;

update gomitas
for portion of business_time FROM '2018-10-25' to '2019-1-1'
  set price = price * 1.45;

update gomitas
for portion of business_time FROM '2018-11-5' to '2019-1-1'
  set price = (price / 1.45) * 1.1;


select SUM(price)/COUNT(*) as promedio from gomitas where id = 1;

select MAX(price) as MAX from gomitas where id = 1;

select MIN(price) as MAX from gomitas where id = 1;
