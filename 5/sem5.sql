USE 5_sem;
CREATE TABLE academic_record (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(45),
quartal VARCHAR(45),
subject VARCHAR(45),
grade INT
);

INSERT INTO academic_record (name, quartal, subject, grade)
VALUES
	('Александр','1 четверть','математика',4),
    ('Александр','2 четверть','русский',4),
    ('Александр','3 четверть','физика',5),
    ('Александр','4 четверть','история',4),
    ('Антон','1 четверть','математика',4),
    ('Антон','2 четверть','русский',3),
    ('Антон','3 четверть','физика',5),
    ('Антон','4 четверть','история',3),
    ('Петя','1 четверть','физика',4),
	('Петя','2 четверть','физика',3),
    ('Петя','3 четверть','физика',4),
    ('Петя','2 четверть','математика',3),
    ('Петя','3 четверть','математика',4),
    ('Петя','4 четверть','физика',5);
    
/*
стрдний балл ученика
наименьшую оценку ученика
сумму всех оценок
количество всех оценок
*/
SELECT name, AVG(grade) OVER (W), 
			MIN(grade) OVER (W),
            SUM(grade) OVER (W),
            COUNT(grade) OVER (W)
            FROM academic_record
WINDOW W AS (PARTITION BY name);

/*Получить информацию об оценках Пети по физике по четвертям*/
SELECT grade, quartal,
LAG(grade,1,0) OVER (),
LEAD(grade,1,0) OVER ()
FROM academic_record WHERE name = 'Петя' AND subject = 'физика';

CREATE VIEW view1 AS       
SELECT from_user_id, to_user_id, body
FROM messages
WHERE from_user_id=1 OR to_user_id=1;
SELECT * FROM view1;

CREATE VIEW friend_id1 AS
WITH 
	initiator AS (SELECT target_user_id FROM friend_requests WHERE initiator_user_id = 1 AND status = 'approved'),
    target AS (SELECT initiator_user_id FROM friend_requests WHERE target_user_id = 1 AND status = 'approved')
SELECT initiator.target_user_id FROM initiator UNION SELECT target.initiator_user_id FROM target;
SELECT * FROM friend_id1;
