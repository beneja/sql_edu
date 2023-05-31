USE 3_sem;
CREATE TABLE staff
(Id INT PRIMARY KEY AUTO_INCREMENT NOT NULL, 
Firstname VARCHAR(20) NOT NULL, 
Lastname VARCHAR(30) NOT NULL, 
Post VARCHAR(10) NOT NULL,
Seniority INT NOT NULL,
Salary INT NOT NULL,
Age INT NOT NULL);

INSERT INTO Staff (firstname, lastname, post, seniority, salary, age)
VALUES
('Вася', 'Петров', 'Начальник', '40', 100000, 60),
('Петр', 'Власов', 'Начальник', '8', 70000, 30),
('Катя', 'Катина', 'Инженер', '2', 70000, 25),
('Саша', 'Сасин', 'Инженер', '12', 50000, 35),
('Иван', 'Иванов', 'Рабочий', '40', 30000, 59),
('Петр', 'Петров', 'Рабочий', '20', 25000, 40),
('Сидр', 'Сидоров', 'Рабочий', '10', 20000, 35),
('Антон', 'Антонов', 'Рабочий', '8', 19000, 28),
('Юрий', 'Юрков', 'Рабочий', '5', 15000, 25),
('Максим', 'Максимов', 'Рабочий', '2', 11000, 22),
('Юрий', 'Галкин', 'Рабочий', '3', 12000, 24),
('Людмила', 'Маркина', 'Уборщик', '10', 10000, 49);

# Выведите все записи, отсортированные по полю "age" по возрастанию
SELECT * FROM Staff
ORDER BY age;
# Выведите все записи, отсортированные по полю “firstname"
SELECT * FROM staff
ORDER BY firstname;
# Выведите записи полей "firstname ", “lastname", "age", отсортированные по полю "firstname " в алфавитном порядке по убыванию
SELECT firstname, lastname,age
FROM Staff
ORDER BY firstname DESC;
# Выполните сортировку по полям " firstname " и "age" по убыванию
SELECT * FROM Staff
ORDER BY firstname DESC, age DESC;
# Выведите уникальные (неповторяющиеся) значения полей "firstname"
SELECT DISTINCT firstname
FROM Staff;
# Отсортируйте записи по возрастанию значений поля "id". Выведите первые   две записи данной выборки
SELECT * 
FROM Staff
ORDER BY ID
LIMIT 2;
# Отсортируйте записи по возрастанию значений поля "id". Пропустите первые 4 строки данной выборки и извлеките следующие 3
SELECT * 
FROM Staff
ORDER BY ID
LIMIT 3 OFFSET 4;
# Отсортируйте записи по убыванию поля "id". Пропустите две строки данной выборки и извлеките следующие за ними 3 строки
SELECT * 
FROM Staff
ORDER BY ID DESC
LIMIT 3 OFFSET 2;
# Найдите количество сотрудников с должностью «Рабочий» 
SELECT COUNT(*)
FROM Staff
WHERE post = 'Рабочий';
# Посчитайте ежемесячную зарплату начальников
SELECT SUM(Salary) FROM Staff
WHERE Post IN ('Начальник');
# Выведите средний возраст сотрудников, у которых заработная плата больше 30000
SELECT AVG(Age) FROM Staff
WHERE Salary > 30000;
# Выведите максимальную и минимальную заработные платы
SE