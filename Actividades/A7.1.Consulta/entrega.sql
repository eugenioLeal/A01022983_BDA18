-- Hacer una consulta que muestra todos los product_lines(textDescription) que ha comprado el cliente.
SELECT distinct productLine FROM orders JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber JOIN products ON orderdetails.productCode = products.productCode WHERE customerNumber = 112;

-- Revisar con Explain el costo de la consulta(guardar screenshot)
explain
SELECT distinct productLine FROM orders JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber JOIN products ON orderdetails.productCode = products.productCode WHERE customerNumber = 112;

-- Agregar indices a la tabla con mayor costo
create index my_index on orderdetails (productCode)

-- Volver a revisar con explain(comparar)
explain
SELECT distinct productLine FROM orders JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber JOIN products ON orderdetails.productCode = products.productCode WHERE customerNumber = 112;
