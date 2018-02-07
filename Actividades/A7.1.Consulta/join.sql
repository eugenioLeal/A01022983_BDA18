SELECT distinct productLine FROM orders JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber JOIN products ON orderdetails.productCode = products.productCode WHERE customerNumber = 112;
