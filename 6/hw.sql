USE 6_sem;
/*Создайте таблицу users_old, аналогичную таблице users.*/
CREATE TABLE users_old LIKE users;
/*Создайте процедуру, 
с помощью которой можно переместить любого (одного) пользователя из таблицы users в таблицу users_old. 
(использование транзакции с выбором commit или rollback – обязательно).
*/
DELIMITER //
CREATE PROCEDURE `move_users`(IN user_id INTEGER)
    DETERMINISTIC
BEGIN
	START TRANSACTION;
	INSERT INTO users_old (firstname,lastname,email)
    SELECT firstname,lastname,email FROM users WHERE users.id = user_id;
    DELETE FROM users WHERE users.id=user_id;
    COMMIT;
END //

DELIMITER ;
CALL move_users(1);

/*Создайте функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
*/
DROP function IF EXISTS `hello`;

DELIMITER //
CREATE FUNCTION hello()
RETURNS varchar(13)
DETERMINISTIC
BEGIN
DECLARE result VARCHAR(13);
DECLARE ctime TIME DEFAULT curtime();
SELECT CASE 
	WHEN ctime >= '00:00:00' AND  CURRENT_TIME < '06:00:00' 
		THEN 'Доброй ночи'
	WHEN ctime >= '06:00:00' AND  CURRENT_TIME < '12:00:00' 
		THEN 'Доброе утро'
	WHEN ctime >= '12:00:00' AND  CURRENT_TIME < '18:00:00' 
		THEN 'Добрый день'
	ELSE 'Добрый вечер'
END into result;
RETURN result;
END //
DELIMITER ;

select hello();
