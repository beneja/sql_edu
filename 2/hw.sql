USE 2_sem;
CREATE TABLE sales(id INT PRIMARY KEY AUTO_INCREMENT NOT NULL, order_date DATE NOT NULL, coun_product INT NOT NULL);
INSERT INTO sales(order_date, coun_product) values ('2022-01-01', 156), ('2022-01-02', 180), ('2022-01-03',21),
('2022-01-04',124), ('2022-01-05', 341);

SELECT id, CASE
	WHEN coun_product < 100 THEN 'Маленький заказ'
    WHEN (coun_product >= 100 AND coun_product <= 300) THEN 'Средний заказ'
    ELSE 'Большой заказ'
END AS 'Тип заказа' FROM sales;

CREATE TABLE orders (id INT PRIMARY KEY AUTO_INCREMENT NOT NULL, employee_id VARCHAR(3) NOT NULL,
amount REAL NOT NULL, order_status VARCHAR(10) NOT NULL);
INSERT INTO orders(employee_id, amount, order_status) values ('e03',15.00,'OPEN'),('e01',25.50,'OPEN'),('e05',100.70,'CLOSED'),
('e02',22.18,'OPEN'),('e04',9.50,'CANCELLED');

SELECT *, CASE
	WHEN order_status  = 'OPEN' THEN 'Order is in open state'
    WHEN order_status  = 'CLOSED' THEN 'Order is closed'
    WHEN order_status  = 'CANCELLED' THEN 'Order is cancelled'
    ELSE 'Ошибка'
END AS full_order_status FROM orders;