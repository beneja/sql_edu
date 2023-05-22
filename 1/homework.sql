USE first_seminar;
#Создайте таблицу с мобильными телефонами, используя SQL-скрипт. Заполните БД данными
CREATE TABLE `Cell phones`(id int primary key not null auto_increment, ProductName varchar(45) not null, 
Manufacture varchar(45) not null, ProductCount varchar(45) not null, Price int not null);
INSERT `Cell phones` (`id`,`ProductName`, `Manufacture`, `ProductCount`, `Price`) VALUES 
('1', 'iPhone X', 'Apple', '3', '76000'), ('2', 'iPhone 8', 'Apple', '2', '51000'), ('3', 'Galaxy S9', 'Samsung', '2', '56000'), 
('4', 'Galaxy S8', 'Samsung', '1', '41000'), ('5', 'P20 Pro', 'Huawei', '5', '36000');

#Выведите название, производителя и цену для товаров, количество которых превышает 2 
SELECT ProductName, Manufacture, Price FROM `Cell phones` WHERE ProductCount > 2;

#Выведите весь ассортимент товаров марки “Samsung”
SELECT * FROM `Cell phones` WHERE Manufacture = 'Samsung';

#Выведите информацию о телефонах, где суммарный чек больше 100 000 и меньше 145 000**
SELECT * FROM `Cell phones` WHERE ProductCount*Price > 100000 and ProductCount*Price < 145000;

#Товары, в которых есть упоминание "Iphone"
SELECT * FROM `Cell phones` WHERE ProductName like '%iPhone%';
#"Galaxy"
SELECT * FROM `Cell phones` WHERE ProductName like '%Galaxy%';
#Товары, в которых есть ЦИФРЫ
SELECT * FROM `Cell phones` WHERE ProductName RLIKE '[0-9]';
#Товары, в которых есть ЦИФРА "8"  
SELECT * FROM `Cell phones` WHERE ProductName RLIKE '[8]';
