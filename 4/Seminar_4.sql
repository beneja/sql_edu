CREATE DATABASE seminar_4;
USE seminar_4;

DROP TABLE IF EXISTS teacher;
CREATE TABLE teacher
(	
	id INT NOT NULL PRIMARY KEY,
    surname VARCHAR(45),
    salary INT
);

INSERT teacher
VALUES
	(1,"Авдеев", 17000),
    (2,"Гущенко",27000),
    (3,"Пчелкин",32000),
    (4,"Питошин",15000),
    (5,"Вебов",45000),
    (6,"Шарпов",30000),
    (7,"Шарпов",40000),
    (8,"Питошин",30000);
    
SELECT * from teacher; 
DROP TABLE IF EXISTS lesson;
CREATE TABLE lesson
(	
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    course VARCHAR(45),
    teacher_id INT,
    FOREIGN KEY (teacher_id)  REFERENCES teacher(id)
);
INSERT INTO lesson(course,teacher_id)
VALUES
	("Знакомство с веб-технологиями",1),
    ("Знакомство с веб-технологиями",2),
    ("Знакомство с языками программирования",3),
    ("Базы данных и SQL",4),
    ("Нейронные сети", NULL); -- Учитель, который ведет данный предмет, временно отстутствует
    
# Получить фамилию учителей и курсы, которые они ведут
SELECT teacher.surname, lesson.course
FROM teacher
JOIN lesson ON teacher.id = lesson.teacher_id;

# Выбрать фамилию всех учителей и курсы, которые они ведут. Если учитель не ведет курс, его фамилию все равно необходимо вывести
SELECT teacher.surname, lesson.course
FROM teacher
LEFT JOIN lesson ON teacher.id = lesson.teacher_id;

# Вывести учителей, которые не ведут никакие курсы
SELECT teacher.surname, lesson.course
FROM teacher
LEFT JOIN lesson ON teacher.id = lesson.teacher_id
WHERE lesson.teacher_id IS null;

# Получите список курсов и учителей , которые их ведут (используя RIGHT JOIN)
SELECT teacher.surname, lesson.course
FROM lesson
RIGHT JOIN teacher ON teacher.id = lesson.teacher_id
WHERE lesson.id IS NOT null;

# Получить информацию по учителям , которые ведут курс "Знакомство с веб-технологиями"
# 5.1. 	С помощью фильтра “WHERE”, используя “JOIN”
SELECT *
FROM teacher
RIGHT JOIN lesson ON teacher.id = lesson.teacher_id
WHERE lesson.course = 'Знакомство с веб-технологиями';

# 5.2. 	С помощью подзапроса (выборка с помощью с SELECT-a)

SELECT * FROM teacher
WHERE id IN (
SELECT teacher_id FROM lesson
WHERE course = 'Знакомство с веб-технологиями'
);

SELECT surname
FROM teacher
JOIN (
SELECT teacher_id FROM lesson
WHERE course = 'Знакомство с веб-технологиями'
) AS web ON web.teacher_id = teacher.id;

# Получить все строки левой и правой таблицы
SELECT * FROM teacher
CROSS JOIN lesson;

# Получите учителей из таблицы “teachers” : Авдеев, Шарпов, Вебов
SELECT * FROM teacher
WHERE surname IN ('Авдеев', 'Шарпов', 'Вебов');

# Выберите всех учителей из таблицы “teachers”, исключив “Пчелкина”.
SELECT * FROM teacher
WHERE surname NOT IN ('Пчелкин');

SELECT * FROM teacher;
SELECT * FROM lesson;


create table users
(
    id  int auto_increment primary key,
    login varchar(255) null,
    pass  varchar(255) null,
    male  tinyint      null
);

create table clients
(
    id    int auto_increment primary key,
    login varchar(255) null,
    pass  varchar(255) null,
    male  tinyint      null
);

INSERT INTO users (login, pass, male) VALUES ('alex', '$2y$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);
INSERT INTO users (login, pass, male) VALUES ('Mikle', '$ws$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);
INSERT INTO users (login, pass, male) VALUES ('Olia', '$2y$10$88zbBCKLJklStIgTqBKIluijJUnbeZ5WqJI4RJgkksnFZon5kH14y', 2);
INSERT INTO users (login, pass, male) VALUES ('Tom', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH20y', 1);
INSERT INTO users (login, pass, male) VALUES ('Margaret', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ4wqIu4RJgkksnFZon5kH20y', 2);
INSERT INTO users (login, pass, male) VALUES ('alex', '$2y$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);

INSERT INTO clients (login, pass, male) VALUES ('alexander', '$2y$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);
INSERT INTO clients (login, pass, male) VALUES ('Mikle', '$ws$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);
INSERT INTO clients (login, pass, male) VALUES ('Olia', '$2y$10$88zbBCKLJklStIgTqBKIluijJUnbeZ5WqJI4RJgkksnFZon5kH14y', 2);
INSERT INTO clients (login, pass, male) VALUES ('Dmitry', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH20y', 1);
INSERT INTO clients (login, pass, male) VALUES ('Margaret', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ4wqIu4RJgkksnFZon5kH20y', 2);
INSERT INTO clients (login, pass, male) VALUES ('Leonid', '$2y$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);
INSERT INTO clients (login, pass, male) VALUES ('Mikle', '$ws$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);
INSERT INTO clients (login, pass, male) VALUES ('Olga', '$2y$10$88zbBCKLJklStIgTqBKIluijJUnbeZ5WqJI4RJgkksnFZon5kH14y', 2);
INSERT INTO clients (login, pass, male) VALUES ('Tom', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH20y', 1);
INSERT INTO clients (login, pass, male) VALUES ('Masha', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ4wqIu4RJgkksnFZon5kH20y', 2);
INSERT INTO clients (login, pass, male) VALUES ('alex', '$2y$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);

# 1.	Получить список пользователей и клиентов, удалив одинаковых клиентов и пользователей
SELECT * FROM users
UNION
SELECT * FROM clients;

# 2.	Получить список пользователей и клиентов. Дубликаты удалять не нужно
SELECT * FROM users
UNION ALL
SELECT * FROM clients;

