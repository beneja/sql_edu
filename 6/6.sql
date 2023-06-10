USE 6_sem;
#Задача 1.  Создайте процедуру, которая выберет для одного пользователя 5 пользователей в случайной комбинации,
#которые удовлетворяют хотя бы одному критерию:
#1) из одного города
#2) состоят в одной группе
#3) друзья друзей
DELIMITER $$
CREATE PROCEDURE Procedure_1(IN user INT)
BEGIN
WITH
  cte1 AS (SELECT initiator_user_id FROM friend_requests WHERE target_user_id IN (SELECT initiator_user_id 
  FROM 
  (
WITH
  cte1 AS (SELECT initiator_user_id FROM friend_requests WHERE target_user_id = user AND status = 'approved'),
  cte2 AS (SELECT target_user_id FROM friend_requests WHERE initiator_user_id = user AND status = 'approved')
SELECT *
FROM cte1
UNION SELECT * FROM cte2
) AS num_1) AND status = 'approved' AND initiator_user_id != user),
  cte2 AS (SELECT target_user_id FROM friend_requests WHERE initiator_user_id IN (SELECT initiator_user_id 
  FROM (
  WITH
  cte1 AS (SELECT initiator_user_id FROM friend_requests WHERE target_user_id = user AND status = 'approved'),
  cte2 AS (SELECT target_user_id FROM friend_requests WHERE initiator_user_id = user AND status = 'approved')
SELECT *
FROM cte1
UNION SELECT * FROM cte2
)AS num_2) AND status = 'approved'AND target_user_id != user)
SELECT *
FROM cte1
UNION SELECT * FROM cte2

UNION
SELECT user_id FROM profiles WHERE hometown = (SELECT hometown FROM profiles
WHERE user_id = user) AND user_id != user

UNION
SELECT DISTINCT user_id FROM users_communities WHERE community_id IN (SELECT community_id FROM users_communities
WHERE user_id = user)AND user_id != user
ORDER BY rand()
LIMIT 5;
END $$
DELIMITER ;


CALL Procedure_1 (5);

DROP PROCEDURE IF EXISTS sp_friendship_offers;
DELIMITER //
CREATE PROCEDURE sp_friendship_offers(for_user_id BIGINT)
BEGIN
-- друзья
WITH friends AS (
SELECT initiator_user_id AS id
    FROM friend_requests
    WHERE status = 'approved' AND target_user_id = for_user_id 
    UNION
    SELECT target_user_id 
    FROM friend_requests
    WHERE status = 'approved' AND initiator_user_id = for_user_id 
)
SELECT p2.user_id FROM profiles p1
JOIN profiles p2 ON p1.hometown = p2.hometown 
WHERE p1.user_id = for_user_id AND p2.user_id <> for_user_id
-- состоят в одной группе
UNION SELECT uc2.user_id FROM users_communities uc1
JOIN users_communities uc2 ON uc1.community_id = uc2.community_id 
WHERE uc1.user_id = for_user_id AND uc2.user_id <> for_user_id
-- друзья друзей
UNION SELECT fr.initiator_user_id FROM friends f
JOIN friend_requests fr ON fr.target_user_id = f.id
WHERE fr.initiator_user_id != for_user_id  AND fr.status = 'approved'
UNION SELECT fr.target_user_id FROM  friends f
JOIN  friend_requests fr ON fr.initiator_user_id = f.id 
WHERE fr.target_user_id != for_user_id  AND status = 'approved'
ORDER BY rand() 
LIMIT 5;
END//
DELIMITER ;
CALL sp_friendship_offers (3);

/*
Задача 2.  Создание функции, вычисляющей коэффициент популярности пользователя 
(по заявкам на дружбу – таблица friend_requests)
*/

-- Создание функции:
DROP FUNCTION IF EXISTS function_1;
DELIMITER //
CREATE FUNCTION function_1 (user INT)
RETURNS FLOAT
DETERMINISTIC
BEGIN
DECLARE input INT;
DECLARE output INT;
SET input = (SELECT COUNT(*) FROM friend_requests WHERE target_user_id = user);
SET output = (SELECT COUNT(*) FROM friend_requests WHERE initiator_user_id = user);
IF output = 0 THEN RETURN null;
ELSE RETURN input / output;
END IF;
END//
DELIMITER ;
-- Вызов функции:
SELECT id, function_1(id) AS 'Популярность' FROM users;
