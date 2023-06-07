USE 5_sem;
/*Создайте представление, в которое попадет информация о  пользователях (имя, фамилия, город и пол), которые не старше 20 лет.
*/
DROP VIEW IF EXISTS younger20;
CREATE VIEW younger20 AS
SELECT us.firstname,us.lastname, pr.hometown, 
IF (pr.gender='f', 'women','man') AS 'sex' FROM profiles AS pr
JOIN users AS us
ON us.id=pr.user_id
WHERE (DATEDIFF(UTC_DATE(),pr.birthday))/365.25<=20;

SELECT * FROM younger20;

/*Найдите кол-во  отправленных сообщений каждым пользователем и  выведите ранжированный список пользователей,
указав имя и фамилию пользователя, количество отправленных сообщений и место в рейтинге
(первое место у пользователя с максимальным количеством сообщений) . (используйте DENSE_RANK)
*/
SELECT u.firstname AS 'Имя',
	u.lastname AS 'Фамилия',
	count(m.id) AS count_sms,
	(DENSE_RANK() OVER(ORDER BY COUNT(m.id) DESC)) AS 'rank'  
FROM users AS u 
JOIN messages AS m
ON u.id=m.from_user_id
GROUP BY u.id;

/*Выберите все сообщения, отсортируйте сообщения по возрастанию даты отправления (created_at)
и найдите разницу времени отправления между соседними сообщениями, получившегося списка. (используйте LEAD или LAG)*/
SELECT id,body,created_at,
TIMESTAMPDIFF(SECOND,LAG (created_at) OVER (ORDER BY created_at),created_at) delta
FROM messages
ORDER BY created_at;