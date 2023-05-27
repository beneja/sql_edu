use 2_sem;
CREATE TABLE movies
(id int PRIMARY KEY auto_increment NOT NULL, title varchar(45) not null, title_eng  varchar(30),
year_movie  year not null, count_min int not null, storyline TEXT);
INSERT INTO movies (title, title_eng, year_movie, count_min, storyline) VALUES 
('Игры разума', 'A Beautiful Mind', 2001, 135, 'От всемирной известности до греховных глубин — все это познал на своей шкуре Джон Форбс Нэш-младший. Математический гений, он на заре своей карьеры сделал титаническую работу в области теории игр, которая перевернула этот раздел математики и практически принесла ему международную известность. Однако буквально в то же время заносчивый и пользующийся успехом у женщин Нэш получает удар судьбы, который переворачивает уже его собственную жизнь.'),
('Форрест Гамп', 'Forrest Gump', 1994, 142, 'Сидя на автобусной остановке, Форрест Гамп — не очень умный, но добрый и открытый парень — рассказывает случайным встречным историю своей необыкновенной жизни. С самого малолетства парень страдал от заболевания ног, соседские мальчишки дразнили его, но в один прекрасный день Форрест открыл в себе невероятные способности к бегу. Подруга детства Дженни всегда его поддерживала и защищала, но вскоре дороги их разошлись.'),
('Иван Васильевич меняет профессию', null, 1994, 128, 'Инженер-изобретатель Тимофеев сконструировал машину времени, которая соединила его квартиру с далеким шестнадцатым веком - точнее, с палатами государя Ивана Грозного. Туда-то и попадают тезка царя пенсионер-общественник Иван Васильевич Бунша и квартирный вор Жорж Милославский. На их место в двадцатом веке «переселяется» великий государь. Поломка машины приводит ко множеству неожиданных и забавных событий...'),
('Назад в будущее', 'Back to the Future', 1985 ,116 , 'Подросток Марти с помощью машины времени, сооружённой его другом-профессором доком Брауном, попадает из 80-х в далекие 50-е. Там он встречается со своими будущими родителями, ещё подростками, и другом-профессором, совсем молодым.'),
('Криминальное чтиво', 'Pulp Fiction', 1994, 154, null);
SELECT * FROM movies;
RENAME TABLE movies TO cinema;
ALTER TABLE cinema ADD COLUMN status_active BIT;
ALTER TABLE cinema ADD COLUMN genre_id INT AFTER title_eng;
ALTER TABLE cinema DROP cinema_ibfk_1;
ALTER TABLE cinema DROP status_active; 

CREATE TABLE genres
(id int PRIMARY KEY auto_increment NOT NULL, nameGenre varchar(45) not null);
INSERT INTO genres (nameGenre) VALUES ('Action'), ('Documental'), ('Comedy');
ALTER TABLE cinema ADD foreign key (genre_id) REFERENCES genres (id); # внешний ключ. После ADD можно задать имя связи CONSTRAINT "name"
-- Посмотреть ключи
DESCRIBE cinema;
-- DROP - удалить таблицу
-- TRUNCATE - очистить таблицу
TRUNCATE genres;
#Удалить внешний ключ из синем\
ALTER TABLE cinema DROP FOREIGN KEY cinema_ibfk_1;
SHOW CREATE TABLE cinema;

ALTER TABLE cinema ADD COLUMN Catrgory VARCHAR(1);
ALTER TABLE cinema RENAME COLUMN Catrgory TO Category;
UPDATE cinema SET Catrgory = 'П' WHERE id = 6;
UPDATE cinema SET Catrgory = 'В' WHERE id = 7;
UPDATE cinema SET Catrgory = 'Д' WHERE id = 8;

SELECT *, CASE
	WHEN Category = 'П' THEN 'Подростковое'
    WHEN Category = 'В' THEN 'Взрослое'
    WHEN Category = 'Д' THEN 'Детское'
    ELSE 'Не определено'
END AS CategoryLong FROM cinema;

SELECT id,title,count_min, IF (count_min > 130, 'Полнометражный', 'Короткометражный') AS Прожолжительность FROM cinema;