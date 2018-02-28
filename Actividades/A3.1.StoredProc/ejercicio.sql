--------------------------------------------------
-- ejercicios de clase Miercoles 17/Enero/18    --
-- Stop Procedures                              --
--------------------------------------------------

----------------------
-- Ejemplo clase    --
----------------------
use classicmodels;
delimiter $$ 
create procedure count_customers()
BEGIN
    declare contador int default 0;
    select count(*) into contador from customers;
    select contador;
END$$
Delimiter ;
-- en otro archivo
call count_customers();

-- utiliza describe table_name para averiguar el tipo de dato almacenado
describe products;

--------------------------
--  Primer Ejercicio    --
--------------------------
-- Muestra producto por “product line” (motorcycles)
use classicmodels;
delimiter $$
-- Como ya sabes que linea_producto es un varchar(50) haces lo siguiente:
create procedure show_products(
IN linea_producto varchar(50))
BEGIN 
	declare line varchar(50);
    set line = concat(linea_producto, "%");
	select * from products
    where productLine like line;
END$$
delimiter ;
-- en otro archivo
call show_products("Motor%");

--------------------------
--  Segundo Ejercicio   --
--------------------------
-- Muestre cuantos clientes inicia su nombre con la letra “variable” (parametro)
use classicmodels;
delimiter $$
create procedure show_clients(
IN nombre_cliente varchar(50))
BEGIN
	declare line varchar(50);
    set line = concat(nombre_cliente, "%");
	select * from customers
    where nombre_cliente like line;
END$$
delimiter ;
-- en otro archivo
call show_clients("var%");

--------------------------
--  Tercer Ejercicio    --
--------------------------
-- Muestre el producto mas caro y el mas barato (no requiere parametros)
-- intento uno
use classicmodels;
delimiter $$
create procedure show_extreme_price()
BEGIN
	declare max1 decimal(10,2);
    declare min1 decimal(10,2);
	select max(buyPrice) into max1 from products;
	select max(buyPrice) into max1 from products;    
    select * from products where buyPrice=min1 or buyPrice=max1;
END$$
delimiter ;
-- intento dos
use classicmodels;
delimiter $$
create procedure show_extreme_price()
BEGIN
	declare max1 decimal(10,2);
    declare min1 decimal(10,2);
	select * from products order by buyPrice asc limit 1 into max1;
	select * from products order by buyPrice asc limit 1 into max1;
END$$
delimiter ;
-- en otro archivo
call show_extreme_price();

