// primero
use classicmodels;
delimiter $$
create procedure show_products(
IN linea_producto varchar(50))
BEGIN 
	declare line varchar(50);
    set line = concat(linea_producto, "%");
	select * from products
    where productLine like line;
END$$
delimiter ;

// segundo 
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

call show_clients("var%");

// tercero
use classicmodels;
delimiter $$
create procedure show_extreme_price()
BEGIN
	declare max1 decimal(10,2);
    declare min1 decimal(10,2);
	select max(buyPrice) into max1 from products;
	select max(buyPrice) into max1 from products;    
    select * from products
    where buyPrice=min1 and buyPrice=max1;
END$$
delimiter ;
