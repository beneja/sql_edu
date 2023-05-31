USE 3_sem;

-- Отсортируйте данные по полю заработная плата (salary) в порядке: убывания; возрастания 
SELECT *
FROM Staff
ORDER BY salary;
SELECT *
FROM Staff
ORDER BY salary DESC;

-- Выведите 5 максимальных заработных плат (saraly)
SELECT *
FROM Staff
ORDER BY salary DESC
LIMIT 5;

-- Посчитайте суммарную зарплату (salary) по каждой специальности (роst)
SELECT post, SUM(salary) AS salarySum
FROM Staff
GROUP BY post
ORDER BY salarySum;

-- Найдите кол-во сотрудников с специальностью (post) «Рабочий» в возрасте от 24 до 49 лет включительно.
SELECT count(post)
FROM Staff
WHERE post  = 'Рабочий' AND age > 24 and age < 49;

-- Найдите количество специальностей
SELECT COUNT(DISTINCT post) AS 'Специальности'
FROM Staff;

-- Выведите специальности, у которых средний возраст сотрудников меньше 40 лет
SELECT post
FROM Staff
GROUP BY post
HAVING AVG(age) < 40;