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
SELECT MIN(Salary), MAX(Salary)
FROM Staff;
SELECT * FROM Staff;

CREATE TABLE activity_staff (
	id INT AUTO_INCREMENT PRIMARY KEY, 
	staff_id INT NOT NULL,
	date_activity DATE,
	count_pages INT,
	FOREIGN KEY (staff_id) REFERENCES staff (id) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO activity_staff (staff_id, date_activity, count_pages)
VALUES
(1, '2022-01-01', 250),
(2, '2022-01-01', 220),
(3, '2022-01-01', 170),
(1, '2022-01-02', 100),
(2, '2022-01-02', 220),
(3, '2022-01-02', 300),
(7, '2022-01-02', 350),
(1, '2022-01-03', 168),
(2, '2022-01-03', 62),
(3, '2022-01-03', 84);

# Выведите общее количество напечатанных страниц каждым сотрудником
SELECT SUM(count_pages), staff_id
FROM activity_staff
GROUP BY staff_id;

# Посчитайте количество страниц за каждый день
SELECT SUM(count_pages), date_activity
FROM activity_staff
GROUP BY date_activity;
# Найдите среднее арифметическое по количеству ежедневных страниц
SELECT AVG(count_pages), date_activity
FROM activity_staff
GROUP BY date_activity;
# Выведите id сотрудников, которые напечатали более 500 страниц за всех дни
SELECT staff_id, SUM(count_pages)
FROM activity_staff
GROUP BY staff_id
HAVING SUM(count_pages) > 500;
#  Выведите  дни, когда работало более 3 сотрудников Также укажите кол-во сотрудников, которые работали в выбранные дни.
SELECT date_activity, COUNT(*)
FROM activity_staff
GROUP BY date_activity
HAVING COUNT(*) > 3;
# Выведите среднюю заработную плату по должностям, которая составляет более 30000
SELECT AVG(Salary), post
FROM Staff
GROUP BY Post
HAVING AVG(Salary) > 30000;

DELETE FROM Staff
WHERE id = 7;